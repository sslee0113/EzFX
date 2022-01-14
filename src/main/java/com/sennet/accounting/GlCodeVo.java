package com.sennet.accounting;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
@Getter
@Setter
public class GlCodeVo {
	@Id
	private String acsjCd;       //계정과목코드
	private String acsjNm;       //계정과목명
	private String acsjGrp;      //계정그룹
	private String hostAcsjCd;   //계정계코드
	private String bokAcsjTcd;   //한국은행코드
	private String acsjOputNm;   //계정과목조회명
	private String astDbtTcd;    //자산부채구분코드
	private String wnFrTcd;      //원화외화구분코드
	private String evSbjTcd;     //평가주체구분코드
	private String astDbtYn;     //양변여부
	private String onlnTcd;      //온라인구분코드
	private String statTcd;      //상태구분코드
	private String qryYn;        //조회여부
	private String qrySqn;       //조회순서
	private String lastDate;     //최종변경일
	private String lastTime;     //최종변경시간
	private String lastUser;     //최종사용자

	@Override
	public String toString() {
		return "FrcGlCodeVo [acsjCd=" + acsjCd + ", acsjNm=" + acsjNm + ", acsjGrp=" + acsjGrp + ", hostAcsjCd=" + hostAcsjCd
				+ ", bokAcsjTcd=" + bokAcsjTcd + ", acsjOputNm=" + acsjOputNm + ", astDbtTcd=" + astDbtTcd + ", wnFrTcd=" + wnFrTcd
				+ ", evSbjTcd=" + evSbjTcd + ", astDbtYn=" + astDbtYn + ", onlnTcd=" + onlnTcd + ", statTcd=" + statTcd
				+ ", qryYn=" + qryYn + ", qrySqn=" + qrySqn + ", lastDate=" + lastDate + ", lastTime=" + lastTime
				+ ", lastUser=" + lastUser + "]";
	}
}
