package com.sennet.bizcommon.frgnexchrate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sennet.common.StringUtil;
import com.sennet.exception.DuplicatedException;
import com.sennet.exception.NotFoundException;

@Service
@Transactional
public class FrgnExchRateService {

	@Autowired
	private FrgnExchRateDao frgnExchRateDao;

	
	@Autowired
	private ModelMapper modelMapper;

	// insert FrgnExchRate
		public int insertFrgnExchRate(FrgnExchRateVo paramVo) {
			FrgnExchRateVo frgnExchRateVo = modelMapper.map(paramVo, FrgnExchRateVo.class);
			
			FrgnExchRateVo frgnExchRateTempVo = frgnExchRateDao.findOneFrgnExchRate(paramVo);
			if (frgnExchRateTempVo != null) {
				throw new DuplicatedException(paramVo.getCurrCode());
			}
			frgnExchRateVo.setValDate(paramVo.getValDate());
			frgnExchRateVo.setCurrCode(paramVo.getCurrCode());
			frgnExchRateVo.setQuotSeq(paramVo.getQuotSeq());
			frgnExchRateVo.setMidRate(paramVo.getMidRate());
			frgnExchRateVo.setTtSellRate(paramVo.getTtSellRate());
			frgnExchRateVo.setTtBuyRate(paramVo.getTtBuyRate());
			frgnExchRateVo.setCashSellRate(paramVo.getCashSellRate());
			frgnExchRateVo.setCashBuyRate(paramVo.getCashBuyRate());
			frgnExchRateVo.setCoinSellRate(paramVo.getCoinSellRate());
			frgnExchRateVo.setCoinBuyRate(paramVo.getCoinBuyRate());
			frgnExchRateVo.setUsdCrosRate(paramVo.getUsdCrosRate());
			frgnExchRateVo.setStaCd("0");
			frgnExchRateVo.setFirstDate(StringUtil.currentDateString("yyyyMMdd"));
			frgnExchRateVo.setFirstTime(StringUtil.currentDateString("HHmmss"));
			return frgnExchRateDao.saveFrgnExchRate(frgnExchRateVo);
		}
		
		public FrgnExchRateVo getFrgnExchRateVo(String valDate, String currCode){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("valDate", valDate);
			map.put("currCode", currCode);
			
			FrgnExchRateVo frgnExchRateVo = frgnExchRateDao.readMaxFrgnExchRateVo(map);
			if(frgnExchRateVo == null){
				throw new NotFoundException("환율고시전입니다. 거래를 계속 할 수 없습니다.");
			}
			else{
				return frgnExchRateVo;
			}
		}
		
		// 리스트 조회
		public List<FrgnExchRateVo> searchListFrgnExchRate(String startDate, String endDate, int quotSeq) {
			Map<String, Object> condition = new HashMap<String, Object>();
			condition.put("startDate", startDate);
			condition.put("endDate", endDate);
			condition.put("quotSeq", quotSeq);
			
			return frgnExchRateDao.searchListFrgnExchRate(condition);
		}	

}
