package com.sennet.bizcommon.zipcode;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.extern.slf4j.Slf4j;


@Service
@Transactional
@Slf4j
public class ZipcodeService {
	
	@Autowired
	private ZipcodeDao zipcodeDao;

	@Autowired
	private ModelMapper modelMapper;
	
	// 팝업 Pageable 리스트 조회
	public PageImpl<ZipcodeVo> searchListZipcodePopupPageable(String zipcode, String province, String roadName, String mainBuildingNo,Pageable pageable) {
		int totalCount = 0;
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("zipcode", zipcode);
		condition.put("province", province);
		condition.put("roadName", roadName);
		condition.put("mainBuildingNo", mainBuildingNo);
		condition.put("start", pageable.getOffset());
		condition.put("end", pageable.getOffset()+pageable.getPageSize());
		List<ZipcodeVo> zipCodeList = zipcodeDao.searchListZipcodePopupPageable(condition);
		if(zipCodeList.size()>0){
			totalCount = ((ZipcodeVo)zipCodeList.get(0)).getTotalCount();
		}
        return new PageImpl<ZipcodeVo>(zipCodeList, pageable,totalCount);
	}

	// Pageable 리스트 조회
	public PageImpl<ZipcodeVo> searchListZipcodePageable(String zipcode, String province, String roadName, String mainBuildingNo,Pageable pageable) {
		int totalCount = 0;
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("zipcode", zipcode);
		condition.put("province", province);
		condition.put("roadName", roadName);
		condition.put("mainBuildingNo", mainBuildingNo);
		condition.put("start", pageable.getOffset());
		condition.put("end", pageable.getOffset()+pageable.getPageSize());
		List<ZipcodeVo> zipCodeList =  zipcodeDao.searchListZipcodePageable(condition);
		if(zipCodeList.size()>0){
			totalCount = ((ZipcodeVo)zipCodeList.get(0)).getTotalCount();
		}
        return new PageImpl<ZipcodeVo>(zipCodeList, pageable,totalCount);
	}

}
