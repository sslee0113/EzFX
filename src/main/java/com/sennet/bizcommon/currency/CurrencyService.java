package com.sennet.bizcommon.currency;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.sennet.bizcommon.country.CountryVo;
import com.sennet.common.StringUtil;
import com.sennet.exception.DuplicatedException;
import com.sennet.exception.NotFoundException;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@Service
@Transactional
public class CurrencyService {

	@Autowired
	private CurrencyDao currencyDao;
	
	@Autowired
	private ModelMapper modelMapper;

	// insert Currency
		public int insertCurrency(CurrencyVo paramVo) {
			CurrencyVo currencyVo = modelMapper.map(paramVo, CurrencyVo.class);
			
			CurrencyVo currencyTempVo = currencyDao.findOneCurrency(paramVo.getCurrCode());
			if (currencyTempVo != null) {
				throw new DuplicatedException(paramVo.getCurrCode());
			}
			currencyVo.setCurrCode(paramVo.getCurrCode());
			currencyVo.setEngName(paramVo.getEngName());
			currencyVo.setKorName(paramVo.getKorName());
			currencyVo.setQuotFlag(paramVo.getQuotFlag());
			currencyVo.setQuotSeq(paramVo.getQuotSeq());
			currencyVo.setCurrUnit(paramVo.getCurrUnit());
			currencyVo.setUndrPoint(paramVo.getUndrPoint());
			currencyVo.setTtSprdRate(paramVo.getTtSprdRate());
			currencyVo.setBasicSprdRate(paramVo.getBasicSprdRate());
			currencyVo.setCoinSprdRate(paramVo.getCoinSprdRate());
			
			currencyVo.setFirstDate(StringUtil.currentDateString("yyyyMMdd"));
			currencyVo.setFirstTime(StringUtil.currentDateString("HHmmss"));
			currencyVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
			currencyVo.setLastTime(StringUtil.currentDateString("HHmmss"));
			return currencyDao.saveCurrency(currencyVo);
		}
		// update Currency
		public int updateCurrency(CurrencyVo paramVo) {
			CurrencyVo currencyVo = currencyDao.findOneCurrency(paramVo.getCurrCode());
			if (currencyVo == null) {
				throw new NotFoundException(paramVo.getCurrCode());
			}		
			currencyVo.setEngName(paramVo.getEngName());
			currencyVo.setKorName(paramVo.getKorName());
			currencyVo.setQuotFlag(paramVo.getQuotFlag());
			currencyVo.setQuotSeq(paramVo.getQuotSeq());
			currencyVo.setCurrUnit(paramVo.getCurrUnit());
			currencyVo.setUndrPoint(paramVo.getUndrPoint());
			currencyVo.setTtSprdRate(paramVo.getTtSprdRate());
			currencyVo.setBasicSprdRate(paramVo.getBasicSprdRate());
			currencyVo.setCoinSprdRate(paramVo.getCoinSprdRate());

			currencyVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
			currencyVo.setLastTime(StringUtil.currentDateString("HHmmss"));
			
			return currencyDao.saveCurrency(currencyVo);
		}
		
		public CurrencyVo findOneCurrency(String currCode){
			CurrencyVo currencyVo = currencyDao.findOneCurrency(currCode);
			if (currencyVo == null){
				throw new NotFoundException(currCode);
			}
			return currencyVo;
		}

		// delete Currency
		public int delete(String currCode) {
			CurrencyVo currencyVo = currencyDao.findOneCurrency(currCode);
			if (currencyVo == null) {
				throw new NotFoundException(currCode);
			}
			// 삭제는 상태코드를 '9' 로 
			currencyVo.setStaCd("9");
			currencyVo.setQuotFlag("N");
			
			currencyVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
			currencyVo.setLastTime(StringUtil.currentDateString("HHmmss"));
			return currencyDao.saveCurrency(currencyVo);
		}
		
		// currCodeList
		public List<CurrencyCodeResponseVo> currCodeList() {
			Map<String, Object> condition = new HashMap<String, Object>();
			condition.put("staCd", "0");
			condition.put("quotFlag", "Y");
	        
			List<CurrencyVo> currencyVoList = currencyDao.currCodeList(condition);
			
	        CurrencyCodeResponseVo currCodeResponseVo;
	        CurrencyVo currencyVo;
	        Iterator<CurrencyVo> itr = currencyVoList.iterator();
	        List<CurrencyCodeResponseVo> list = new ArrayList<CurrencyCodeResponseVo>();
	        while(itr.hasNext()){
	        	currencyVo = (CurrencyVo)itr.next();
	        	currCodeResponseVo = new CurrencyCodeResponseVo();
	        	currCodeResponseVo.setValue(currencyVo.getCurrCode());
	        	currCodeResponseVo.setText(currencyVo.getCurrCode());
	        	
	        	list.add(currCodeResponseVo);
	        }
			
			return list;
		}
		
		
		// 리스트 조회
		public List<CurrencyVo> searchListCurrency(String currCode) {
			Map<String, Object> condition = new HashMap<String, Object>();
			condition.put("currCode", currCode);
			return currencyDao.searchListCurrency(condition);
		}

}
