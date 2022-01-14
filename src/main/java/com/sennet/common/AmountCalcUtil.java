package com.sennet.common;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sennet.bizcommon.currency.CurrencyService;
import com.sennet.bizcommon.currency.CurrencyVo;
import com.sennet.bizcommon.frgnexchrate.FrgnExchRateVo;
import com.sennet.bizcommon.frgnexchrate.FrgnExchRateService;
import com.sennet.exception.NotFoundException;

import lombok.extern.slf4j.Slf4j;
@Slf4j
public class AmountCalcUtil {
	
//    static int USD = 1;
//    static int ETC = 2;

	// 적용환율
	public static BigDecimal getAplExrt(BigDecimal rate, BigDecimal sprdRate, BigDecimal prmRt, String crcd, String efmDscd){
		
		int scale = 2;
		if(crcd.equals("USD")){
			scale = 1;
		}else{
			scale = 2;
		}
		
		BigDecimal aplExrt;
		BigDecimal b100 = new BigDecimal("100");
		prmRt = b100.subtract(prmRt).divide(b100, 2, BigDecimal.ROUND_DOWN); 
		log.info("prmRt:"+prmRt.toString());
		
		sprdRate = sprdRate.multiply(prmRt);
		
		// 매도 : 적용환율 = 기준율 + (ROUNDDOWN(기준율 * SPREAD / 100), scale))
		// 매입 : 적용환율 = 기준율 - (ROUNDDOWN(기준율 * SPREAD / 100), scale))
		if(efmDscd.equalsIgnoreCase("B")){ // B:매입, S:매도

			aplExrt = rate.subtract(roundDown(rate.multiply(sprdRate.divide(new BigDecimal("100"))), scale));
		}else{

			aplExrt = rate.add(roundDown(rate.multiply(sprdRate.divide(new BigDecimal("100"))), scale));
		}
		
		log.info("aplExrt:"+aplExrt.toString());
		
		return aplExrt;
		
	}
	
	// 매매원화금액
	public static BigDecimal getStlmWna(BigDecimal amt, BigDecimal aplyExrt){
		
		if(amt.compareTo(BigDecimal.ZERO)<=0){

			return BigDecimal.ZERO;
		}
		
		BigDecimal dlnPlWna = amt.multiply(aplyExrt).setScale(2, BigDecimal.ROUND_DOWN);

		log.info("dlnPlWna:"+dlnPlWna.toString());

		return dlnPlWna;
	}
	
	// 매매손익원화금액
	public static  BigDecimal getDlnPlWna(BigDecimal amt, BigDecimal midRate, BigDecimal aplyExrt){
		
		if(amt.compareTo(BigDecimal.ZERO)<=0){

			return BigDecimal.ZERO;
		}
		
		BigDecimal midRateAmt = amt.multiply(midRate).setScale(2, BigDecimal.ROUND_DOWN);
		BigDecimal aplyRateAmt = amt.multiply(aplyExrt).setScale(2, BigDecimal.ROUND_DOWN);
		BigDecimal stlmWna = midRateAmt.subtract(aplyRateAmt).abs();
		
		log.info("midRateAmt:"+midRateAmt.toString());
		log.info("aplyRateAmt:"+aplyRateAmt.toString());
		log.info("stlmWna:"+stlmWna.toString());
		
		return stlmWna;
	}
	// 정산원화금액 합계
	public static BigDecimal getSumStlmWna(BigDecimal pmnyStlmWna, BigDecimal cnStlmWna){
		
		return pmnyStlmWna.add(cnStlmWna);
	}
	
	// 매매금액 - 적용금액 계산의 절대값을 리턴한다
	public static BigDecimal getPlWna(BigDecimal dlnWna, BigDecimal aplyWna){
		
		return dlnWna.subtract(aplyWna).abs();
	}
	
	public static BigDecimal roundDown(BigDecimal a, int scale)
	{
	    return a.setScale(scale, RoundingMode.DOWN);
	}
	
	// 대미환산금액
	public static BigDecimal getTusaTnslAmt(BigDecimal amt1, BigDecimal amt2, BigDecimal usdCrosRate){
		
		BigDecimal usdAmt1 = amt1.multiply(usdCrosRate);
		BigDecimal usdAmt2 = amt2.multiply(usdCrosRate);
		BigDecimal tusaTnslAmt = usdAmt1.add(usdAmt2);
		
		return tusaTnslAmt;
	}
}
