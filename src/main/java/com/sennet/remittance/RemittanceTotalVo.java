package com.sennet.remittance;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class RemittanceTotalVo {

	String trBrno; 			// 거래점
	String trDt;   			// 송금일
	String crcd;   			// 통화코드
	BigDecimal owmnAmt;  	// 송금금액
}
