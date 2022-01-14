package com.sennet.accounting;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AccountingVo {

	// 거래코드
	private String trCd;
	// 거래점코드
	private String trBrno;
	// 상대점코드
	private String opTrBrno;
	// 주계정코드
	private String mainAcsjNm;
	// 상대계정코드
	private String opAcsjNm;
	// 매입매도구분코드
	private String buySellType;
	// 거래통화코드
	private String trCrd;
	// 거래외화금액
	private BigDecimal trFrc;
	// 환율회차
	private int quotSeq;
	// 매매기준율
	private BigDecimal midRate;
	// 고시환율
	private BigDecimal quotRate;
	// 우대율
	private BigDecimal prmRt;
	// 적용환율
	private BigDecimal aplyRate;
	// 매매원화금액
	private BigDecimal dlnWna;
	// 적용원화금액
	private BigDecimal aplyWna;
	// 매매손익원화금액
	private BigDecimal dlnPlWna;
	// 포지션발생여부
	private String posiYn;
	// 포지션외화금액
	private BigDecimal posiFrc;
	// 포지션원화금액
	private BigDecimal posiWna;
	// 수수료
	private BigDecimal fee;
	// 현금
	private BigDecimal cash;
	// 보통예금
	private BigDecimal saving;
	// BIC
	private String bic;

	@Override
	public String toString() {
		return "Accounting [" + (trCd != null ? "trCd=" + trCd + ", " : "")
				+ (trBrno != null ? "trBrno=" + trBrno + ", " : "")
				+ (opTrBrno != null ? "opTrBrno=" + opTrBrno + ", " : "")
				+ (mainAcsjNm != null ? "mainAcsjNm=" + mainAcsjNm + ", " : "")
				+ (opAcsjNm != null ? "opAcsjNm=" + opAcsjNm + ", " : "")
				+ (buySellType != null ? "buySellType=" + buySellType + ", " : "")
				+ (trCrd != null ? "trCrd=" + trCrd + ", " : "") + (trFrc != null ? "trFrc=" + trFrc + ", " : "")
				+ "quotSeq=" + quotSeq + ", " + (midRate != null ? "midRate=" + midRate + ", " : "")
				+ (quotRate != null ? "quotRate=" + quotRate + ", " : "")
				+ (prmRt != null ? "prmRt=" + prmRt + ", " : "")
				+ (aplyRate != null ? "aplyRate=" + aplyRate + ", " : "")
				+ (dlnWna != null ? "dlnWna=" + dlnWna + ", " : "")
				+ (aplyWna != null ? "aplyWna=" + aplyWna + ", " : "")
				+ (dlnPlWna != null ? "dlnPlWna=" + dlnPlWna + ", " : "")
				+ (posiYn != null ? "posiYn=" + posiYn + ", " : "")
				+ (posiFrc != null ? "posiFrc=" + posiFrc + ", " : "")
				+ (posiWna != null ? "posiWna=" + posiWna + ", " : "") + (fee != null ? "fee=" + fee + ", " : "")
				+ (cash != null ? "cash=" + cash + ", " : "") + (saving != null ? "saving=" + saving + ", " : "")
				+ (bic != null ? "bic=" + bic : "") + "]";
	}
	
}
