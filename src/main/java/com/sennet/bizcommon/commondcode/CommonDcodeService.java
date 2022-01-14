package com.sennet.bizcommon.commondcode;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.sennet.common.StringUtil;
import com.sennet.exception.NotFoundException;

@Service
@Transactional
public class CommonDcodeService {

	@Autowired
	private CommonDcodeDao CommonDcodeDao;

	@Autowired
	private ModelMapper modelMapper;
	
	// insert CommonDcode
	public int insertCommonDcode(CommonDcodeVo paramVo) {
		CommonDcodeVo CommonDcodeVo = modelMapper.map(paramVo, CommonDcodeVo.class);
		CommonDcodeVo.setGcode(paramVo.getGcode());
		CommonDcodeVo.setDcode(paramVo.getDcode());
		CommonDcodeVo.setDcodeName(paramVo.getDcodeName());
		CommonDcodeVo.setViewSeq(paramVo.getViewSeq());
		// 로그인된 사용자의 정보 가져온다.
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = authentication.getName();
		CommonDcodeVo.setFirstUserId( userId);
		CommonDcodeVo.setFirstDatetime(StringUtil.currentDateString("yyyyMMddHHmmss"));
		CommonDcodeVo.setLastUserId(userId);
		CommonDcodeVo.setLastDatetime(StringUtil.currentDateString("yyyyMMddHHmmss"));
		return CommonDcodeDao.saveCommonDcode(CommonDcodeVo);
	}
	// update CommonDcode
	public int updateCommonDcode(CommonDcodeVo paramVo) {
		
		Map<String, Object> condition = new HashMap<String, Object>();		
		condition.put("gcode", paramVo.getGcode());
		condition.put("dcode", paramVo.getDcode());
		CommonDcodeVo CommonDcodeVo = CommonDcodeDao.findOneCommonDcode(condition);
		if (CommonDcodeVo == null) {
			throw new NotFoundException(paramVo.getGcode());
		}		
		CommonDcodeVo.setGcode(paramVo.getGcode());
		CommonDcodeVo.setDcode(paramVo.getDcode());
		CommonDcodeVo.setDcodeName(paramVo.getDcodeName());
		CommonDcodeVo.setViewSeq(paramVo.getViewSeq());
		// 로그인된 사용자의 정보 가져온다.
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = authentication.getName();

		CommonDcodeVo.setLastUserId(userId);
		CommonDcodeVo.setLastDatetime(StringUtil.currentDateString("yyyyMMddHHmmss"));
		return CommonDcodeDao.saveCommonDcode(CommonDcodeVo);
	}

	// delete CommonDcode
	public int deleteCommonDcode(CommonDcodeVo paramVo) {
		return CommonDcodeDao.deleteCommonDcode(paramVo);
	}
	// 리스트 조회
	public List<CommonDcodeVo> searchListCommonDcode(String gcode) {
		Map<String, Object> condition = new HashMap<String, Object>();		
		condition.put("gcode", gcode);
		return CommonDcodeDao.searchListCommonDcode(condition);	
	}
}
