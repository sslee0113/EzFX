package com.sennet.accounting;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AccountingDetailVo {
	
	// 점구분
	private String brType;
	// 차대구분
	private String crdrTcd;
	// 계정명
	private String acsjNm;
	// 통화
	private String crd;
	// 외화금액
	private BigDecimal frc;
	// 원화금액
	private BigDecimal wna;
	// 구분
	private String posiYn;
	// ROW
	private int row;

	@Override
	public String toString() {
		return "AccountingList [" + (brType != null ? "brType=" + brType + ", " : "")
				+ (crdrTcd != null ? "crdrTcd=" + crdrTcd + ", " : "") + (acsjNm != null ? "acsjNm=" + acsjNm + ", " : "")
				+ (crd != null ? "crd=" + crd + ", " : "") + (frc != null ? "frc=" + frc + ", " : "")
				+ (wna != null ? "wna=" + wna + ", " : "") + (posiYn != null ? "posiYn=" + posiYn + ", " : "") + "row="
				+ row + "]";
	}
}
