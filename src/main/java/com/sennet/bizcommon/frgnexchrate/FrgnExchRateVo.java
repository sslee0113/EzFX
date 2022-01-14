package com.sennet.bizcommon.frgnexchrate;

import java.math.BigDecimal;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class FrgnExchRateVo {
	
	private String valDate;				// 고시일자(PK)
	private String currCode;			// 고시통화코드(PK)
	private int quotSeq;				// 고시회차(PK)
	private BigDecimal midRate;			// 매매기준율
	private BigDecimal ttSellRate;		// 전신환매도율
	private BigDecimal ttBuyRate;		// 전신환매입율
	private BigDecimal cashSellRate;	// 현찰매도율
	private BigDecimal cashBuyRate;		// 현찰매입율
	private BigDecimal coinSellRate;	// 주화매도율
	private BigDecimal coinBuyRate;		// 주화매입율
	private BigDecimal usdCrosRate;		// 대미환산율
	private String staCd;				// 상태구분코드
	private String firstDate;			// 최초등록일자
	private String firstTime;			// 최초등록시간
	
	@Override
	public String toString() {
		return "FrgnExchRate [" + (valDate != null ? "valDate=" + valDate + ", " : "")
				+ (currCode != null ? "currCode=" + currCode + ", " : "") + "quotSeq=" + quotSeq + ", "
				+ (midRate != null ? "midRate=" + midRate.toString() + ", " : "")
				+ (ttSellRate != null ? "ttSellRate=" + ttSellRate.toString() + ", " : "")
				+ (ttBuyRate != null ? "ttBuyRate=" + ttBuyRate.toString() + ", " : "")
				+ (cashSellRate != null ? "cashSellRate=" + cashSellRate.toString() + ", " : "")
				+ (cashBuyRate != null ? "cashBuyRate=" + cashBuyRate.toString() + ", " : "")
				+ (coinSellRate != null ? "coinSellRate=" + coinSellRate.toString() + ", " : "")
				+ (coinBuyRate != null ? "coinBuyRate=" + coinBuyRate.toString() + ", " : "")
				+ (usdCrosRate != null ? "usdCrosRate=" + usdCrosRate.toString() + ", " : "")
				+ (staCd != null ? "staCd=" + staCd + ", " : "")
				+ (firstDate != null ? "firstDate=" + firstDate + ", " : "")
				+ (firstTime != null ? "firstTime=" + firstTime : "") + "]";
	}

}