package com.sennet.bizcommon.frgnexchratenotice;

import java.math.BigDecimal;
import java.util.List;

import lombok.Data;

@Data
public class FrgnExchRateNoticeVo {
		private String valDate;				// 고시일자
		private String currCode;			// 고시통화코드
		private int quotSeq;				// 고시회차
		private BigDecimal ttSprdRate;		// 전신환 SPREAD
		private BigDecimal basicSprdRate;	// 현찰 SPREAD
		private BigDecimal coinSprdRate;	// 주화 SPREAD
		private BigDecimal midRate;			// 매매기준율
}
