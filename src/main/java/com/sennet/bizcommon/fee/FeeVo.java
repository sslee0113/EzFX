package com.sennet.bizcommon.fee;

import java.math.BigDecimal;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class FeeVo {
	
	private long feeCd;				// 수수료코드(PK)
	private String rmtKdcd;			// 송금종류코드
	private String rmtKdcdName;		// 송금종류코드명
	private String ntcd;			// 국가코드
	private String crcd;			// 통화코드
	private String aplStrtDt;		// 적용시작일자
	private String aplEndDt;		// 적용종료일자
	private BigDecimal aplStrtAmt;	// 적용시작금액
	private BigDecimal aplEndAmt;	// 적용종료금액
	private String feeCrcd;			// 수수료통화
	private BigDecimal feeAmt;		// 수수료금액
	private String firstUserId;		// 최초사용자ID
	private String firstDate;		// 최초등록일자
	private String firstTime;		// 최초등록시간
	private String lastUserId;		// 최종사용자ID
	private String lastDate;		// 최종변경일자
	private String lastTime;		// 최종변경시간
	

	@Override
	public String toString() {
		return "Fee [feeCd=" + feeCd + ", " + (rmtKdcd != null ? "rmtKdcd=" + rmtKdcd + ", " : "")
				+ (ntcd != null ? "ntcd=" + ntcd + ", " : "") + (crcd != null ? "crcd=" + crcd + ", " : "")
				+ (aplStrtDt != null ? "aplStrtDt=" + aplStrtDt + ", " : "")
				+ (aplEndDt != null ? "aplEndDt=" + aplEndDt + ", " : "")
				+ (aplStrtAmt != null ? "aplStrtAmt=" + aplStrtAmt + ", " : "")
				+ (aplEndAmt != null ? "aplEndAmt=" + aplEndAmt + ", " : "")
				+ (feeCrcd != null ? "feeCrcd=" + feeCrcd + ", " : "")
				+ (feeAmt != null ? "feeAmt=" + feeAmt + ", " : "")
				+ (firstUserId != null ? "firstUserId=" + firstUserId + ", " : "")
				+ (firstDate != null ? "firstDate=" + firstDate + ", " : "")
				+ (firstTime != null ? "firstTime=" + firstTime + ", " : "")
				+ (lastUserId != null ? "lastUserId=" + lastUserId + ", " : "")
				+ (lastDate != null ? "lastDate=" + lastDate + ", " : "")
				+ (lastTime != null ? "lastTime=" + lastTime : "") + "]";
	}

}