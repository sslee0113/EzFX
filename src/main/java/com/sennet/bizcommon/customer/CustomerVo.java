package com.sennet.bizcommon.customer;

import javax.persistence.Id;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class CustomerVo {
	
	private String cifNo;			// 고객번호(PK)
	private String brnNo;			// 고객관리점번호
	private String residentCd;		// 실명번호구분
	private String residentNo;		// 실명번호
	private String engFirstName;	// 영문명(성)
	private String engLastName;		// 영문명(이름)
	private String korFirstName;	// 한글명(성)
	private String korLastName;		// 한글명(이름)
	private String habitationCd;	// 거주구분
	private String nationalCode;	// 국적
	private String telNo;			// 일반전화
	private String cellNo;			// 핸드폰번호
	private String zipCode;			// 우편번호
	private String addr1;			// 한글주소1
	private String addr2;			// 한글주소2
	private String orCifFlag;		// 당발송금고객여부
	private String orEngAddr1;		// 송금영문주소1
	private String orEngAddr2;		// 송금영문주소2
	private String orEngAddr3;		// 송금영문주소3
	private String orEngAddr4;		// 송금영문주소4
	private String staCd;			// 상태구분코드
	private String firstDate;		// 최초등록일자
	private String firstTime;		// 최초등록시간
	private String lastDate;		// 최종변경일자
	private String lastTime;		// 최변변경시간

	@Override
	public String toString() {
		return "Customer [cifNo=" + cifNo + ", brnNo=" + brnNo + ", residentCd=" + residentCd + ", residentNo="
				+ residentNo + ", engFirstName=" + engFirstName + ", engLastName=" + engLastName + ", korFirstName="
				+ korFirstName + ", korLastName=" + korLastName + ", habitationCd=" + habitationCd + ", nationalCode="
				+ nationalCode + ", telNo=" + telNo + ", cellNo=" + cellNo + ", zipCode=" + zipCode + ", addr1="
				+ addr1 + ", addr2=" + addr2 + ", orCifFlag=" + orCifFlag + ", orEngAddr1=" + orEngAddr1
				+ ", orEngAddr2=" + orEngAddr2 + ", orEngAddr3=" + orEngAddr3 + ", orEngAddr4=" + orEngAddr4
				+ ", staCd=" + staCd + ", firstDate=" + firstDate + ", firstTime=" + firstTime + ", lastDate="
				+ lastDate + ", lastTime=" + lastTime + "]";
	}

}