package com.sennet.accounting;

import java.math.BigDecimal;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class GlDetailJournalizeVo {
	
	private String actgTrDt;   		//회계일자
	private long actgTrSrno;   		//일련번호
	private String brno;       		//영업점번호
	private String oppBrno;    		//상대점번호
	private String bankCd;     		//은행코드
	private int rowNo;              //열번호
	private BigDecimal basicRate;   //매매기준율
	private BigDecimal exrRate;     //적용환율
	private String posiYn;          //포지션대체구분

	private String cCurrCd;         //c통화코드
	private String cAcctCd;         //c계정코드
	private BigDecimal cFrc;        //c대체외화금액
	private BigDecimal cWon;        //c대체원화금액

	private String dCurrCd;         //d통화코드
	private String dAcctCd;         //d계정코드
	private BigDecimal dFrc;        //d대체외화금액 
	private BigDecimal dWon;        //d대체원화금액
	

	@Override
	public String toString() {
		return "GlDetailJournalizeVo [" + (actgTrDt != null ? "actgTrDt=" + actgTrDt + ", " : "") + "actgTrSrno=" + actgTrSrno
				+ ", " + (brno != null ? "brno=" + brno + ", " : "")
				+ (oppBrno != null ? "oppBrno=" + oppBrno + ", " : "")
				+ (bankCd != null ? "bankCd=" + bankCd + ", " : "") + "rowNo=" + rowNo + ", "
				+ (basicRate != null ? "basicRate=" + basicRate + ", " : "")
				+ (exrRate != null ? "exrRate=" + exrRate + ", " : "")
				+ (posiYn != null ? "posiYn=" + posiYn + ", " : "")
				+ (dCurrCd != null ? "dCurrCd=" + dCurrCd + ", " : "")
				+ (dAcctCd != null ? "dAcctCd=" + dAcctCd + ", " : "") + (dFrc != null ? "dFrc=" + dFrc + ", " : "")
				+ (dWon != null ? "dWon=" + dWon + ", " : "") + (cCurrCd != null ? "cCurrCd=" + cCurrCd + ", " : "")
				+ (cAcctCd != null ? "cAcctCd=" + cAcctCd + ", " : "") + (cFrc != null ? "cFrc=" + cFrc + ", " : "")
				+ (cWon != null ? "cWon=" + cWon : "") + "]";
	}
}
