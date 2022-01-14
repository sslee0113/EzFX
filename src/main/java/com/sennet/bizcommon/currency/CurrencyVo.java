package com.sennet.bizcommon.currency;

import lombok.Data;
import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;
@Data
@Getter
@Setter
public class CurrencyVo {
	
	private String currCode;             // 통화코드(PK)
	private String engName;              // 영문명
	private String korName;              // 한글명
	private String quotFlag;             // 고시통화여부 
	private int quotSeq;                 // 고시순서
	private int currUnit;                // 환율단위
	private int undrPoint;               // 소숫점이하 자리수
	private BigDecimal ttSprdRate;       // 전신환스프레드
	private BigDecimal basicSprdRate;    // 현찰스프레드
	private BigDecimal coinSprdRate;     // 주화스프레드
	private String staCd;                // 상태구분코드
	private String firstDate;            // 등록일 
	private String firstTime;            // 시
	private String lastDate;             // 수정일
	private String lastTime;             // 시

	@Override
	public String toString() {
		return "Currency [currCode=" + currCode + ", engName=" + engName + ", korName=" + korName + ", quotFlag="
				+ quotFlag + ", quotSeq=" + quotSeq + ", currUnit=" + currUnit + ", undrPoint=" + undrPoint
				+ ", ttSprdRate=" + ttSprdRate.toString() + ", basicSprdRate=" + basicSprdRate.toString() + ", coinSprdRate=" + coinSprdRate.toString()
				+ ", staCd=" + staCd + ", firstDate=" + firstDate + ", firstTime=" + firstTime + ", lastDate="
				+ lastDate + ", lastTime=" + lastTime + "]";
	}

}