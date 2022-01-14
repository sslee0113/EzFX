package com.sennet.bizcommon.frgnexchratenotice;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.sennet.bizcommon.currency.CurrencyService;
import com.sennet.bizcommon.currency.CurrencyVo;
import com.sennet.bizcommon.frgnexchrate.FrgnExchRateDao;
import com.sennet.bizcommon.frgnexchrate.FrgnExchRateService;
import com.sennet.bizcommon.frgnexchrate.FrgnExchRateVo;
import com.sennet.common.StringUtil;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class FrgnExchRateNoticeService {

	@Autowired
	private FrgnExchRateService frgnExchRateService;
	
	@Autowired
	private FrgnExchRateDao frgnExchRateDao;
	
	@Autowired
	private FrgnExchRateNoticeDao frgnExchRateNoticeDao;
	
	@Autowired
    private CurrencyService currencyService;
	
	private int USD=1;
	private int ETC=2;
	
    public int insertExchRateNotice(List<FrgnExchRateNoticeVo> paramList){
        Iterator<FrgnExchRateNoticeVo> itr = paramList.iterator();
        CurrencyVo currencyVo;
        FrgnExchRateVo frgnExchRateVo = new FrgnExchRateVo();
//        int frgnExchRateVoint = 0;
        BigDecimal usd = new BigDecimal("0");
        
        // 대미환산율을 계산하기 위해서 USD 매매기준율을 찾는다.
        while(itr.hasNext()){
        	
        	FrgnExchRateNoticeVo  vo = itr.next();
        	if(vo.getCurrCode().equalsIgnoreCase("USD")){
        		usd = vo.getMidRate();
        		break;
        	}
        }

        FrgnExchRateNoticeVo vo;
        
        try{
        	
        	int quotSeq = frgnExchRateDao.getNextSeqFrgnExchRate(StringUtil.currentDateString("yyyyMMdd"));
        	
            itr = paramList.iterator();
            while(itr.hasNext())
            {
            	FrgnExchRateNoticeVo frgnExchRateNoticeVo = itr.next();
 
        		// 통화정보 가져오기
        		currencyVo = currencyService.findOneCurrency(frgnExchRateNoticeVo.getCurrCode());

        		// 환율계산 파라미터 SET
        		vo = new FrgnExchRateNoticeVo();
        		vo.setCurrCode(frgnExchRateNoticeVo.getCurrCode());
        		vo.setMidRate(frgnExchRateNoticeVo.getMidRate());
        		vo.setTtSprdRate(currencyVo.getTtSprdRate());
        		vo.setBasicSprdRate(currencyVo.getBasicSprdRate());
        		vo.setCoinSprdRate(currencyVo.getCoinSprdRate());

        		// 환율계산
        		
        		frgnExchRateVo = getCalculatedRate(vo, usd);

        		FrgnExchRateVo insertVo = new FrgnExchRateVo();
        		insertVo.setValDate(StringUtil.currentDateString("yyyyMMdd"));
        		insertVo.setCurrCode(frgnExchRateNoticeVo.getCurrCode());
        		insertVo.setMidRate(frgnExchRateNoticeVo.getMidRate());
        		insertVo.setQuotSeq(quotSeq);

        		insertVo.setTtSellRate(frgnExchRateVo.getTtSellRate());
        		insertVo.setTtBuyRate(frgnExchRateVo.getTtBuyRate());
        		insertVo.setCashSellRate(frgnExchRateVo.getCashSellRate());
        		insertVo.setCashBuyRate(frgnExchRateVo.getCashBuyRate());
        		insertVo.setCoinSellRate(frgnExchRateVo.getCoinSellRate());
        		insertVo.setCoinBuyRate(frgnExchRateVo.getCoinBuyRate());
        		insertVo.setUsdCrosRate(frgnExchRateVo.getUsdCrosRate());
        		insertVo.setStaCd("0");
        		frgnExchRateService.insertFrgnExchRate(insertVo);
            }
        }
        catch(Exception e){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			StringWriter sw = new StringWriter();
			PrintWriter pw = new PrintWriter(sw);
			e.printStackTrace(pw);
			String sStackTrace = sw.toString(); // stack trace as a string
			log.error(sStackTrace);
			throw e;
        }
        return 1;
    }
    
	public FrgnExchRateVo getCalculatedRate(FrgnExchRateNoticeVo frgnExchRateNoticeVo, BigDecimal usd){
		FrgnExchRateVo frgnExchRateVo = new FrgnExchRateVo();
		if(frgnExchRateNoticeVo.getCurrCode().equalsIgnoreCase("USD")){
			frgnExchRateVo = calculatedRate(frgnExchRateNoticeVo, usd, this.USD);
		}else{

			frgnExchRateVo = calculatedRate(frgnExchRateNoticeVo, usd, this.ETC);
		}
		return frgnExchRateVo;
	}
	private FrgnExchRateVo calculatedRate(FrgnExchRateNoticeVo frgnExchRateNoticeVo, BigDecimal usd, int scale){
		
		FrgnExchRateVo frgnExchRateVo = new FrgnExchRateVo();
		
		BigDecimal midRate = frgnExchRateNoticeVo.getMidRate();

		// 전신환매도율 = 매매기준율 + (ROUNDDOWN(매매기준율 * 전신환SPREAD / 100), scale))
		frgnExchRateVo.setTtSellRate(midRate.add(this.roundDown(midRate.multiply(frgnExchRateNoticeVo.getTtSprdRate().divide(new BigDecimal("100"))), scale)));
		// 전신환매입율 = 매매기준율 - (ROUNDDOWN(매매기준율 * 전신환SPREAD / 100), scale))
		frgnExchRateVo.setTtBuyRate(midRate.subtract(this.roundDown(midRate.multiply(frgnExchRateNoticeVo.getTtSprdRate().divide(new BigDecimal("100"))), scale)));
		// 현찰매도율   = 매매기준율 + (ROUNDDOWN(매매기준율 * 현찰SPREAD / 100), scale))
		frgnExchRateVo.setCashSellRate(midRate.add(this.roundDown(midRate.multiply(frgnExchRateNoticeVo.getBasicSprdRate().divide(new BigDecimal("100"))), scale)));
		// 현찰매입율   = 매매기준율 - (ROUNDDOWN(매매기준율 * 현찰SPREAD / 100), scale))
		frgnExchRateVo.setCashBuyRate(midRate.subtract(this.roundDown(midRate.multiply(frgnExchRateNoticeVo.getBasicSprdRate().divide(new BigDecimal("100"))), scale)));
		// 주화매도율   = 매매기준율 + (ROUNDDOWN(매매기준율 * 주화SPREAD / 100), scale))
		frgnExchRateVo.setCoinSellRate(midRate.add(this.roundDown(midRate.multiply(frgnExchRateNoticeVo.getCoinSprdRate().divide(new BigDecimal("100"))), scale)));
		// 주화매입율   = 매매기준율 - (ROUNDDOWN(매매기준율 * 주화SPREAD / 100), scale))	
		frgnExchRateVo.setCoinBuyRate(midRate.subtract(this.roundDown(midRate.multiply(frgnExchRateNoticeVo.getCoinSprdRate().divide(new BigDecimal("100"))), scale)));
		// 대미환산율 = 매매기준율 / USD매매기준율
		frgnExchRateVo.setUsdCrosRate(midRate.divide(usd, 6, BigDecimal.ROUND_DOWN));
		
		return frgnExchRateVo;
	}
	
	private BigDecimal roundDown(BigDecimal a, int scale)
	{
	    return a.setScale(scale, RoundingMode.DOWN);
	}
	
	public List<FrgnExchRateNoticeVo> findByValDateOrderByCurrCodeAsc(FrgnExchRateNoticeVo paramVo) {
		return frgnExchRateNoticeDao.findByValDateOrderByCurrCodeAsc(paramVo);
	}
	
}
