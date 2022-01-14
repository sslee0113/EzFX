package com.sennet.accounting;

import java.math.BigDecimal;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class GlDetailVo {
	
	private String actgTrDt;       //회계일자
	private long actgTrSrno;       //일련번호
	private long actgTrSubSrno;    //부 일련번호
	private String brno;           //영업점번호
	private String oppBrno;        //상대점번호
	private String crdrTcd;        //입금지급구분코드
	private String currCd;         //통화코드
	private BigDecimal basicRate;  //매매기준율
	private BigDecimal exrRate;    //적용환율
	private String acctCd;         //계정코드
	private BigDecimal frc;        //대체외화금액
	private BigDecimal won;        //대체원화금액
	private String posiYn;         //포지션대체구분
	private String bankCd;         //은행코드
	private int rowNo;             //열번호

	@Override
	public String toString() {
		return "GlDetail [" + (actgTrDt != null ? "actgTrDt=" + actgTrDt + ", " : "") + "actgTrSrno=" + actgTrSrno
				+ ", actgTrSubSrno=" + actgTrSubSrno + ", " + (brno != null ? "brno=" + brno + ", " : "")
				+ (oppBrno != null ? "oppBrno=" + oppBrno + ", " : "")
				+ (crdrTcd != null ? "crdrTcd=" + crdrTcd + ", " : "")
				+ (currCd != null ? "currCd=" + currCd + ", " : "")
				+ (basicRate != null ? "basicRate=" + basicRate + ", " : "")
				+ (exrRate != null ? "exrRate=" + exrRate + ", " : "")
				+ (acctCd != null ? "acctCd=" + acctCd + ", " : "") + (frc != null ? "frc=" + frc + ", " : "")
				+ (won != null ? "won=" + won + ", " : "") + (posiYn != null ? "posiYn=" + posiYn + ", " : "")
				+ (bankCd != null ? "bankCd=" + bankCd + ", " : "") + "rowNo=" + rowNo + "]";
	}
}
