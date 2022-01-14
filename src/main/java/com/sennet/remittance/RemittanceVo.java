package com.sennet.remittance;

import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
@Data
public class RemittanceVo {
	@NotBlank
	private String tradeType; 		// 거래구분
	private String refNo;           // REF번호
	private String trBrno;          // 거래점번호
	private String rmtKdcd;         // 송금종류코드
	@NotBlank
	private String crcd;            // 통화코드
	@NotNull
	private BigDecimal owmnAmt;     // 당발송금금액
	private String trDt;            // 거래일자
	private String sndgDt;          // 발송일자
	private String rcfmDt;          // 기산일자
	private String crcCnclDt;       // 정정취소일자
	private String crcCnclNm;       // 정정취소사유
	private int quotSeq;         	// 고시회차
	private BigDecimal basicRate;   // 매매기준율
	private BigDecimal prmRt;       // 우대율
	private BigDecimal aplExrt;     // 적용환율
	private BigDecimal dlnPlWna;    // 매매손익원화금액
	private BigDecimal tusaTnslAmt; // 대미환산금액
	@NotBlank
	private String rmprRnnoDscd;    // 송금인실명번호구분코드
	@NotBlank
	private String rmprRnno;        // 송금인실명번호
	private String rmprPspNo;       // 송금인여권번호
	private String rmprCustNo;      // 송금인고객번호
	@NotBlank
	private String rmprKrFirstNm;   // 송금인한글명(성)
	@NotBlank
	private String rmprKrLastNm;    // 송금인한글명(이름)
	private String rmprEnFirstNm;   // 송금인영문명(성)
	private String rmprEnLastNm;    // 송금인영문명(이름)
	@NotBlank
	private String rmprAdr1;        // 송금인주소1
	@NotBlank
	private String rmprAdr2;        // 송금인주소2
	private String rmprAdr3;        // 송금인주소3
	private String rmprTlno;        // 송금인전화번호
	private String rmprCellNo;      // 송금인핸드폰번호
	private String rmprNtntNtcd;    // 송금인국적국가코드
	private String rmprAmtyDscd;    // 송금인거주성구분코드
	private String rmprTrMnbdPccd;  // 송금인거래주체특성코드
	private String rmprSitNtcd;     // 송금인소재지국가코드
	private String rmprSitZip;      // 송금인소재지우편번호
	private String adreRnnoDscd;    // 수취인실명번호구분코드
	private String adreRnno;        // 수취인실명번호
	@NotBlank
	private String adreEnFirstNm;   // 수취인영문명(성)
	@NotBlank
	private String adreEnLastNm;    // 수취인영문명(이름)
	private String adreState;    	// 수취인주(STATE)
	private String adreCty;    		// 수취인지급도시(CITY)
	@NotBlank
	private String adreAdr1;        // 수취인주소1
	private String adreAdr2;        // 수취인주소2
	private String adreAdr3;        // 수취인주소3
	private String adreAcno;        // 수취인계좌번호
	@NotBlank
	private String adreNtcd;        // 수취인국가코드
	private String adreNtntNtcd;    // 수취인국적국가코드
	private String adreAmtyDscd;    // 수취인거주성구분코드
	@NotBlank
	private String adreTlno;        // 수취인전화번호
	private String rcvgBnkCd;       // 수취인기관번호
	private String feeCrcd;         // 수수료통화코드
	private BigDecimal feeAmt;      // 수수료외화금액
	private BigDecimal feeAmtWna;   // 수수료원화금액
	private String cndChgDt;        // 조건변경일자
	private String rmtApcDscd;      // 송금신청구분코드
	private String wnItrlkAct; 		// 원환연동계좌
	private BigDecimal wnItrlkAmt;	// 원화연동금액
	private BigDecimal altWna; 		// 일반원화대체
	private BigDecimal cashWna;     // 현금
	private BigDecimal drwbAmt;     // 퇴결금액
	private String hdyTrYn;         // 휴일거래여부
	private String closAfTrYn;      // 마감후거래여부
	private String frxcLdgrStcd;    // 외환원장상태코드
	private String firstDate;       // 최초등록일자
	private String firstTime;       // 최초등록시간
	private String lastDate;        // 최종변경일자
	private String lastTime;        // 최종변경시간

	@Override
	public String toString() {
		return "RemittanceVo [" + (refNo != null ? "refNo=" + refNo + ", " : "")
				+ (trBrno != null ? "trBrno=" + trBrno + ", " : "")
				+ (rmtKdcd != null ? "rmtKdcd=" + rmtKdcd + ", " : "") + (crcd != null ? "crcd=" + crcd + ", " : "")
				+ (owmnAmt != null ? "owmnAmt=" + owmnAmt + ", " : "") + (trDt != null ? "trDt=" + trDt + ", " : "")
				+ (sndgDt != null ? "sndgDt=" + sndgDt + ", " : "") + (rcfmDt != null ? "rcfmDt=" + rcfmDt + ", " : "")
				+ (crcCnclDt != null ? "crcCnclDt=" + crcCnclDt + ", " : "")
				+ (crcCnclNm != null ? "crcCnclNm=" + crcCnclNm + ", " : "") + "quotSeq=" + quotSeq + ", "
				+ (basicRate != null ? "basicRate=" + basicRate + ", " : "")
				+ (prmRt != null ? "prmRt=" + prmRt + ", " : "") + (aplExrt != null ? "aplExrt=" + aplExrt + ", " : "")
				+ (dlnPlWna != null ? "dlnPlWna=" + dlnPlWna + ", " : "")
				+ (tusaTnslAmt != null ? "tusaTnslAmt=" + tusaTnslAmt + ", " : "")
				+ (rmprRnnoDscd != null ? "rmprRnnoDscd=" + rmprRnnoDscd + ", " : "")
				+ (rmprRnno != null ? "rmprRnno=" + rmprRnno + ", " : "")
				+ (rmprPspNo != null ? "rmprPspNo=" + rmprPspNo + ", " : "")
				+ (rmprCustNo != null ? "rmprCustNo=" + rmprCustNo + ", " : "")
				+ (rmprKrFirstNm != null ? "rmprKrFirstNm=" + rmprKrFirstNm + ", " : "")
				+ (rmprKrLastNm != null ? "rmprKrLastNm=" + rmprKrLastNm + ", " : "")
				+ (rmprEnFirstNm != null ? "rmprEnFirstNm=" + rmprEnFirstNm + ", " : "")
				+ (rmprEnLastNm != null ? "rmprEnLastNm=" + rmprEnLastNm + ", " : "")
				+ (rmprAdr1 != null ? "rmprAdr1=" + rmprAdr1 + ", " : "")
				+ (rmprAdr2 != null ? "rmprAdr2=" + rmprAdr2 + ", " : "")
				+ (rmprAdr3 != null ? "rmprAdr3=" + rmprAdr3 + ", " : "")
				+ (rmprTlno != null ? "rmprTlno=" + rmprTlno + ", " : "")
				+ (rmprCellNo != null ? "rmprCellNo=" + rmprCellNo + ", " : "")
				+ (rmprNtntNtcd != null ? "rmprNtntNtcd=" + rmprNtntNtcd + ", " : "")
				+ (rmprAmtyDscd != null ? "rmprAmtyDscd=" + rmprAmtyDscd + ", " : "")
				+ (rmprTrMnbdPccd != null ? "rmprTrMnbdPccd=" + rmprTrMnbdPccd + ", " : "")
				+ (rmprSitNtcd != null ? "rmprSitNtcd=" + rmprSitNtcd + ", " : "")
				+ (rmprSitZip != null ? "rmprSitZip=" + rmprSitZip + ", " : "")
				+ (adreRnnoDscd != null ? "adreRnnoDscd=" + adreRnnoDscd + ", " : "")
				+ (adreRnno != null ? "adreRnno=" + adreRnno + ", " : "")
				+ (adreEnFirstNm != null ? "adreEnFirstNm=" + adreEnFirstNm + ", " : "")
				+ (adreEnLastNm != null ? "adreEnLastNm=" + adreEnLastNm + ", " : "")
				+ (adreState != null ? "adreState=" + adreState + ", " : "")
				+ (adreCty != null ? "adreCty=" + adreCty + ", " : "")
				+ (adreAdr1 != null ? "adreAdr1=" + adreAdr1 + ", " : "")
				+ (adreAdr2 != null ? "adreAdr2=" + adreAdr2 + ", " : "")
				+ (adreAdr3 != null ? "adreAdr3=" + adreAdr3 + ", " : "")
				+ (adreAcno != null ? "adreAcno=" + adreAcno + ", " : "")
				+ (adreNtcd != null ? "adreNtcd=" + adreNtcd + ", " : "")
				+ (adreNtntNtcd != null ? "adreNtntNtcd=" + adreNtntNtcd + ", " : "")
				+ (adreAmtyDscd != null ? "adreAmtyDscd=" + adreAmtyDscd + ", " : "")
				+ (adreTlno != null ? "adreTlno=" + adreTlno + ", " : "")
				+ (rcvgBnkCd != null ? "rcvgBnkCd=" + rcvgBnkCd + ", " : "")
				+ (feeCrcd != null ? "feeCrcd=" + feeCrcd + ", " : "")
				+ (feeAmt != null ? "feeAmt=" + feeAmt + ", " : "")
				+ (feeAmtWna != null ? "feeAmtWna=" + feeAmtWna + ", " : "")
				+ (cndChgDt != null ? "cndChgDt=" + cndChgDt + ", " : "")
				+ (rmtApcDscd != null ? "rmtApcDscd=" + rmtApcDscd + ", " : "")
				+ (wnItrlkAct != null ? "wnItrlkAct=" + wnItrlkAct + ", " : "")
				+ (wnItrlkAmt != null ? "wnItrlkAmt=" + wnItrlkAmt + ", " : "")
				+ (altWna != null ? "altWna=" + altWna + ", " : "")
				+ (cashWna != null ? "cashWna=" + cashWna + ", " : "")
				+ (drwbAmt != null ? "drwbAmt=" + drwbAmt + ", " : "")
				+ (hdyTrYn != null ? "hdyTrYn=" + hdyTrYn + ", " : "")
				+ (closAfTrYn != null ? "closAfTrYn=" + closAfTrYn + ", " : "")
				+ (frxcLdgrStcd != null ? "frxcLdgrStcd=" + frxcLdgrStcd + ", " : "")
				+ (firstDate != null ? "firstDate=" + firstDate + ", " : "")
				+ (firstTime != null ? "firstTime=" + firstTime + ", " : "")
				+ (lastDate != null ? "lastDate=" + lastDate + ", " : "")
				+ (lastTime != null ? "lastTime=" + lastTime : "") + "]";
	}

}