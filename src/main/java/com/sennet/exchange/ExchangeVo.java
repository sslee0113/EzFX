package com.sennet.exchange;

import java.math.BigDecimal;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter

public class ExchangeVo {
	
	private BigDecimal pmnyFrgAmt; 		// 지폐 외화금액
	private BigDecimal cnFrgAmt; 		// 주화 외화금액 
	private String tradeType; 			// 거래구분
	private String refNo;           // REF번호
	private String efmDscd;         // 환전구분코드
	private String trDt;            // 거래일자
	private String rcfmDt;          // 기산일자
	private String rnnoDscd;        // 실명번호구분코드
	private String rnno;            // 실명번호
	private String pspNo;           // 여권번호
	private String custNo;          // 고객번호
	private String custNm;          // 고객명
	private String crcd;            // 통화코드
	private BigDecimal efmAmt;      // 환전금액
	private BigDecimal pmnyAmt;     // 지폐금액
	private BigDecimal cnAmt;       // 주화금액
	private String amtyDscd;        // 거주구분
	private String ntntNtcd;        // 국적
	private String usNtcd;          // 상대국가
	private String trMnbdPccd;      // 거래주체
	private String intdRscd;        // 사유코드
	private String brno;        	// 관리점
	private String crcCnclDt;       // 정정취소일자
	private String crcCnclNm;       // 정정취소사유
	private BigDecimal pmnyExrt;    // 고시환율(지폐)
	private BigDecimal cnExrt;      // 고시환율(주화)
	private BigDecimal prmRt;       // 우대율
	private BigDecimal wnItrlkAmt;	// 원화연동금액
	private String wnItrlkAct; 		// 원환연동계좌
	private BigDecimal altWna; 		// 대체원화금액
	private BigDecimal cashWna;		// 현금원화금액
	private BigDecimal pmnyAplExrt; // 적용환율(지폐)
	private BigDecimal cnAplExrt;   // 적용환율(주화)
	private BigDecimal pmnyDlnPlWna;// 매매손익원화금액(지폐)
	private BigDecimal cnDlnPlWna;  // 매매손익원화금액(주화)
	private BigDecimal pmnyStlmWna; // 정산원화금액(지폐)
	private BigDecimal cnStlmWna;   // 정산원화금액(주화)
	private BigDecimal sumStlmWna;  // 정산원화금액(합계)
	private BigDecimal tusaTnslAmt; // 대미환산금액
	private String frxcLdgrStcd;    // 외환원장상태코드
	private String firstDate;       // 최초등록일자
	private String firstTime;       // 최초등록시간
	private String lastDate;        // 최종변경일자
	private String lastTime;        // 최종변경시간
	
}
		