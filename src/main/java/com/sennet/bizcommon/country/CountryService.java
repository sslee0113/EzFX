package com.sennet.bizcommon.country;

import lombok.extern.slf4j.Slf4j;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sennet.common.StringUtil;
import com.sennet.exception.DuplicatedException;
import com.sennet.exception.NotFoundException;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Service
@Transactional
@Slf4j
public class CountryService {

	@Autowired
	private CountryDao countryDao;
	
	@Autowired
	private ModelMapper modelMapper;

	// insert Country
		public int insertCountry(CountryVo paramVo) {
			CountryVo countryVo = modelMapper.map(paramVo, CountryVo.class);
			
			CountryVo countryTempVo = countryDao.findOneCountry(paramVo.getCtryCode());
			if (countryTempVo != null) {
				throw new DuplicatedException(paramVo.getCtryCode());
			}
			countryVo.setCtryCode(paramVo.getCtryCode());
			countryVo.setEngName(paramVo.getEngName());
			countryVo.setKorName(paramVo.getKorName());
			countryVo.setCurrCode(paramVo.getCurrCode());
			countryVo.setOecdJoinFlag(paramVo.getOecdJoinFlag());
			countryVo.setCtntType(paramVo.getCtntType());
			countryVo.setG8JoinFlag(paramVo.getG8JoinFlag());
			countryVo.setStaCd(paramVo.getStaCd());
			
			countryVo.setFirstDate(StringUtil.currentDateString("yyyyMMdd"));
			countryVo.setFirstTime(StringUtil.currentDateString("HHmmss"));
			countryVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
			countryVo.setLastTime(StringUtil.currentDateString("HHmmss"));
			return countryDao.saveCountry(countryVo);
		}
		// update Country
		public int updateCountry(CountryVo paramVo) {
			CountryVo countryVo = countryDao.findOneCountry(paramVo.getCtryCode());
			if (countryVo == null) {
				throw new NotFoundException(paramVo.getCtryCode());
			}		
			countryVo.setEngName(paramVo.getEngName());
			countryVo.setKorName(paramVo.getKorName());
			countryVo.setCurrCode(paramVo.getCurrCode());
			countryVo.setOecdJoinFlag(paramVo.getOecdJoinFlag());
			countryVo.setCtntType(paramVo.getCtntType());
			countryVo.setG8JoinFlag(paramVo.getG8JoinFlag());
			countryVo.setStaCd(paramVo.getStaCd());

			countryVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
			countryVo.setLastTime(StringUtil.currentDateString("HHmmss"));
			
			return countryDao.saveCountry(countryVo);
		}

		// delete Country
		public int delete(String ctryCode) {
			CountryVo countryVo = countryDao.findOneCountry(ctryCode);
			if (countryVo == null) {
				throw new NotFoundException(ctryCode);
			}
			// 삭제는 상태코드를 '9' 로 
			countryVo.setStaCd("9");

			countryVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
			countryVo.setLastTime(StringUtil.currentDateString("HHmmss"));
			return countryDao.saveCountry(countryVo);
		}
		
		// ctryCodeList
		public List<CountryCodeResponseVo> ctryCodeList() {
			Map<String, Object> condition = new HashMap<String, Object>();
			condition.put("staCd", "0");
	        
			List<CountryVo> countryVoList = countryDao.ctryCodeList(condition);
			
			CountryCodeResponseVo ctryCodeResponse;
	        CountryVo countryVo;
	        Iterator<CountryVo> itr = countryVoList.iterator();
	        List<CountryCodeResponseVo> list = new ArrayList<CountryCodeResponseVo>();
	        while(itr.hasNext()){
	        	countryVo = (CountryVo)itr.next();
	        	ctryCodeResponse = new CountryCodeResponseVo();
	        	ctryCodeResponse.setValue(countryVo.getCtryCode());
	        	ctryCodeResponse.setText(countryVo.getCtryCode());
	        	
	        	list.add(ctryCodeResponse);
	        }
			
			return list;
		}
		
		// ctryCurrCodeList
		public List<CountryCodeResponseVo> ctryCurrCodeList() {
			Map<String, Object> condition = new HashMap<String, Object>();
			condition.put("staCd", "0");
			
			List<CountryVo> countryVoList = countryDao.ctryCodeList(condition);
			
			CountryCodeResponseVo currCodeResponse;
			CountryVo countryVo;
			Iterator<CountryVo> itr = countryVoList.iterator();
			List<CountryCodeResponseVo> list = new ArrayList<CountryCodeResponseVo>();
			while(itr.hasNext()){
			    countryVo = (CountryVo)itr.next();
			    currCodeResponse = new CountryCodeResponseVo();
			    currCodeResponse.setValue(countryVo.getCurrCode());
			    currCodeResponse.setText(countryVo.getCurrCode());
			    
			    list.add(currCodeResponse);
			}
			
			return list;
		}
		
		// 리스트 조회
		public List<CountryVo> searchListCountry(String ctryCode) {
			Map<String, Object> condition = new HashMap<String, Object>();
			condition.put("ctryCode", ctryCode);
			return countryDao.searchListCountry(condition);
		}
	
}
