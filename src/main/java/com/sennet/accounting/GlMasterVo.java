package com.sennet.accounting;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class GlMasterVo {
	private String actgTrDt;     // 회계일자
	private long actgTrSrno;     // 일련번호
	private String bzTcd;        // 업무구분
	private String refNo;        // 참조번호
	private String prcTcd;       // 처리구분
	private String orgActgTrDt;  // 원회계일자
	private long orgActgTrSrno;  // 원일련번호
	private String statTcd;      // 상태구분
	private String regiDt;       // 등록일자
	private String regiTm;       // 등록시간
	@Override
	public String toString() {
		return "FrcGlMasterVo [actgTrDt=" + actgTrDt + ", actgTrSrno=" + actgTrSrno + ", bzTcd=" + bzTcd + ", refNo=" + refNo
				+ ", prcTcd=" + prcTcd + ", orgActgTrDt=" + orgActgTrDt + ", orgActgTrSrno=" + orgActgTrSrno
				+ ", statTcd=" + statTcd + ", regiDt=" + regiDt + ", regiTm=" + regiTm + "]";
	}
}
