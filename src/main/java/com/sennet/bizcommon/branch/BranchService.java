package com.sennet.bizcommon.branch;

import lombok.extern.slf4j.Slf4j;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sennet.common.StringUtil;
import com.sennet.exception.DuplicatedException;
import com.sennet.exception.NotFoundException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Transactional
@Slf4j
public class BranchService {

	@Autowired
	private BranchDao branchDao;
	
	@Autowired
	private ModelMapper modelMapper;

	// insert Branch
		public int insertBranch(BranchVo paramVo) {
			BranchVo branchVo = modelMapper.map(paramVo, BranchVo.class);
			
			BranchVo branchTempVo = branchDao.findOneBranch(paramVo.getBrno());
			if (branchTempVo != null) {
				throw new DuplicatedException(paramVo.getBrno());
			}
			
			branchVo.setBrno(paramVo.getBrno());
			branchVo.setKorName(paramVo.getKorName());
			branchVo.setEngName(paramVo.getEngName());
			branchVo.setFxBrnNo(paramVo.getFxBrnNo());
			branchVo.setTelNo(paramVo.getTelNo());
			branchVo.setFaxNo(paramVo.getFaxNo());
			branchVo.setZipCode(paramVo.getZipCode());
			branchVo.setAddr(paramVo.getAddr());
			branchVo.setBrnType(paramVo.getBrnType());
			branchVo.setStaCd(paramVo.getStaCd());
			
			branchVo.setFirstDate(StringUtil.currentDateString("yyyyMMdd"));
			branchVo.setFirstTime(StringUtil.currentDateString("HHmmss"));
			branchVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
			branchVo.setLastTime(StringUtil.currentDateString("HHmmss"));
			return branchDao.saveBranch(branchVo);
		}
		// update Branch
		public int updateBranch(BranchVo paramVo) {
			BranchVo branchVo = branchDao.findOneBranch(paramVo.getBrno());
			if (branchVo == null) {
				throw new NotFoundException(paramVo.getBrno());
			}		
			branchVo.setKorName(paramVo.getKorName());
			branchVo.setEngName(paramVo.getEngName());
			branchVo.setFxBrnNo(paramVo.getFxBrnNo());
			branchVo.setTelNo(paramVo.getTelNo());
			branchVo.setFaxNo(paramVo.getFaxNo());
			branchVo.setZipCode(paramVo.getZipCode());
			branchVo.setAddr(paramVo.getAddr());
			branchVo.setBrnType(paramVo.getBrnType());
			branchVo.setStaCd(paramVo.getStaCd());

			branchVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
			branchVo.setLastTime(StringUtil.currentDateString("HHmmss"));
			
			return branchDao.saveBranch(branchVo);
		}

		// delete Branch
		public int delete(String brno) {
			BranchVo branchVo = branchDao.findOneBranch(brno);
			if (branchVo == null) {
				throw new NotFoundException(brno);
			}
			// 삭제는 상태코드를 '9' 로 
			branchVo.setStaCd("9");

			branchVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
			branchVo.setLastTime(StringUtil.currentDateString("HHmmss"));
			return branchDao.saveBranch(branchVo);
		}
		
		// 리스트 조회
		public List<BranchVo> searchListBranch(String brno, String korName) {
			Map<String, Object> condition = new HashMap<String, Object>();
			condition.put("brno", brno);
			condition.put("korName", korName);
			return branchDao.searchListBranch(condition);
		}
	
}
