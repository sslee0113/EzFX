package com.sennet.bizcommon.commoncode;

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
import com.sennet.exception.DuplicatedException;
import com.sennet.exception.NotFoundException;

@Service
@Transactional
public class CommonCodeService {

	@Autowired
	private CommonCodeDao commonCodeDao;

	@Autowired
	private ModelMapper modelMapper;
	
	// insert CommonCode
	public int insertCommonCode(CommonCodeVo paramVo) {
		CommonCodeVo commonCodeVo = modelMapper.map(paramVo, CommonCodeVo.class);
		
		CommonCodeVo commonCodeTempVo = commonCodeDao.findOneCommonCode(paramVo.getGcode());
		if (commonCodeTempVo != null) {
			throw new DuplicatedException(paramVo.getGcode());
		}
		commonCodeVo.setGcode(paramVo.getGcode());
		commonCodeVo.setGcodeName(paramVo.getGcodeName());
		// 로그인된 사용자의 정보 가져온다.
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = authentication.getName();
		commonCodeVo.setFirstUserId( userId);
		commonCodeVo.setFirstDatetime(StringUtil.currentDateString("yyyyMMddHHmmss"));
		commonCodeVo.setLastUserId(userId);
		commonCodeVo.setLastDatetime(StringUtil.currentDateString("yyyyMMddHHmmss"));
		return commonCodeDao.saveCommonCode(commonCodeVo);
	}

	// Find One by PK
	public CommonCodeVo findOneCommonCode(String gcode) {
		return commonCodeDao.findOneCommonCode(gcode);
	}
	// update CommonCode
	public int updateCommonCode(CommonCodeVo paramVo) {
		CommonCodeVo commonCodeVo = commonCodeDao.findOneCommonCode(paramVo.getGcode());
		if (commonCodeVo == null) {
			throw new NotFoundException(paramVo.getGcode());
		}		
		commonCodeVo.setGcodeName(paramVo.getGcodeName());
		commonCodeVo.setStaCd(paramVo.getStaCd());
		// 로그인된 사용자의 정보 가져온다.
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = authentication.getName();

		commonCodeVo.setLastUserId(userId);
		commonCodeVo.setLastDatetime(StringUtil.currentDateString("yyyyMMddHHmmss"));
		
		return commonCodeDao.saveCommonCode(commonCodeVo);
	}

	// delete CommonCode
	public CommonCodeVo delete(String gcode) {
		CommonCodeVo commonCodeVo = commonCodeDao.findOneCommonCode(gcode);
		if (commonCodeVo == null) {
			throw new NotFoundException(gcode);
		}
		// 삭제는 상태코드를 '9' 로 
		commonCodeVo.setStaCd("9");
		// 로그인된 사용자의 정보 가져온다.
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = authentication.getName();

		commonCodeVo.setLastUserId(userId);
		commonCodeVo.setLastDatetime(StringUtil.currentDateString("yyyyMMddHHmmss"));
		int effectRows = commonCodeDao.saveCommonCode(commonCodeVo);
		if(effectRows==1){
			return commonCodeVo;
		}
		else{
			return null;
		}
	}
	
	// 리스트 조회
	public List<CommonCodeVo> searchListCommonCode(String gcode, String gcodeName, String staCd) {
		Map<String, Object> condition = new HashMap<String, Object>();		
		condition.put("gcode", gcode);
		condition.put("gcodeName", gcodeName);
		condition.put("staCd", staCd);
		return commonCodeDao.searchListCommonCode(condition);	
	}

}
