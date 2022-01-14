package com.sennet.accounting.bs;

import java.math.BigDecimal;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
@Data
// 외화총계정원장
public class BsVo {
	private String actgTrDt;                   //회계일자 (PK)
	private String brno;                       //영업점  (PK)
	private String acsjCd;                     //계정과목코드 (PK)
	private String currCd;                     //통화코드 (PK)
	private BigDecimal dybfFrcBala;            //전일외화잔액
	private BigDecimal dybfWonBala;            //전일원화잔액
	private long posiCrCnt;                    //포지션입금건수
	private BigDecimal posiCrFrc;              //포지션입금외화금액
	private BigDecimal posiCrWon;              //포지션입금원화금액
	private long posiDrCnt;                    //포지션지급건수
	private BigDecimal posiDrFrc;              //포지션지급외화금액
	private BigDecimal posiDrWon;              //포지션지급원화금액
	private long altCrCnt;                     //대체입금건수
	private BigDecimal altCrFrc;               //대체입금외화금액
	private BigDecimal altCrWon;               //대체입금원화금액
	private long altDrCnt;                     //대체지급건수
	private BigDecimal altDrFrc;               //대체지급외화금액
	private BigDecimal altDrWon;               //대체지급원화금액
	private long cnclPosiCrCnt;                //취소포지션지급건수
	private BigDecimal cnclPosiCrFrc;          //취소표지션지급외화금액
	private BigDecimal cnclPosiCrWon;          //취소포지션지급원화금액
	private long cnclPosiDrCnt;                //취소포지션입금급건수
	private BigDecimal cnclPosiDrFrc;          //취소포지션입금외화금액
	private BigDecimal cnclPosiDrWon;          //취소표지션입금원화금액
	private long cnclAltCrCnt;                 //취소대체입금건수
	private BigDecimal cnclAltCrFrc;           //취소대체입금외화금액
	private BigDecimal cnclAltCrWon;           //취소대체입금원화금액
	private long cnclAltDrCnt;                 //취소대체지급건수
	private BigDecimal cnclAltDrFrc;           //취소대체지급외화금액
	private BigDecimal cnclAltDrWon;           //취소대체지급원화금액
	@Override
	public String toString() {
		return "BsVo [" + (actgTrDt != null ? "actgTrDt=" + actgTrDt + ", " : "")
				+ (brno != null ? "brno=" + brno + ", " : "") + (acsjCd != null ? "acsjCd=" + acsjCd + ", " : "")
				+ (currCd != null ? "currCd=" + currCd + ", " : "")
				+ (dybfFrcBala != null ? "dybfFrcBala=" + dybfFrcBala + ", " : "")
				+ (dybfWonBala != null ? "dybfWonBala=" + dybfWonBala + ", " : "") + "posiCrCnt=" + posiCrCnt + ", "
				+ (posiCrFrc != null ? "posiCrFrc=" + posiCrFrc + ", " : "")
				+ (posiCrWon != null ? "posiCrWon=" + posiCrWon + ", " : "") + "posiDrCnt=" + posiDrCnt + ", "
				+ (posiDrFrc != null ? "posiDrFrc=" + posiDrFrc + ", " : "")
				+ (posiDrWon != null ? "posiDrWon=" + posiDrWon + ", " : "") + "altCrCnt=" + altCrCnt + ", "
				+ (altCrFrc != null ? "altCrFrc=" + altCrFrc + ", " : "")
				+ (altCrWon != null ? "altCrWon=" + altCrWon + ", " : "") + "altDrCnt=" + altDrCnt + ", "
				+ (altDrFrc != null ? "altDrFrc=" + altDrFrc + ", " : "")
				+ (altDrWon != null ? "altDrWon=" + altDrWon + ", " : "") + "cnclPosiCrCnt=" + cnclPosiCrCnt + ", "
				+ (cnclPosiCrFrc != null ? "cnclPosiCrFrc=" + cnclPosiCrFrc + ", " : "")
				+ (cnclPosiCrWon != null ? "cnclPosiCrWon=" + cnclPosiCrWon + ", " : "") + "cnclPosiDrCnt="
				+ cnclPosiDrCnt + ", " + (cnclPosiDrFrc != null ? "cnclPosiDrFrc=" + cnclPosiDrFrc + ", " : "")
				+ (cnclPosiDrWon != null ? "cnclPosiDrWon=" + cnclPosiDrWon + ", " : "") + "cnclAltCrCnt="
				+ cnclAltCrCnt + ", " + (cnclAltCrFrc != null ? "cnclAltCrFrc=" + cnclAltCrFrc + ", " : "")
				+ (cnclAltCrWon != null ? "cnclAltCrWon=" + cnclAltCrWon + ", " : "") + "cnclAltDrCnt=" + cnclAltDrCnt
				+ ", " + (cnclAltDrFrc != null ? "cnclAltDrFrc=" + cnclAltDrFrc + ", " : "")
				+ (cnclAltDrWon != null ? "cnclAltDrWon=" + cnclAltDrWon : "") + "]";
	}
}