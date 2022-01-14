package com.sennet.bizcommon.branch;

import javax.persistence.Id;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class BranchVo {
	
	private String brno;		// 영업점번호(PK)
	private String korName;		// 한글영업점명
	private String engName;		// 영문영업점명
	private String fxBrnNo;		// 외환점번호
	private String telNo;		// 전화번호
	private String faxNo;		// FAX번호
	private String zipCode;		// 우편번호
	private String addr;		// 주소
	private String brnType;		// 지점상태
	private String staCd;		// 상태구분코드
	private String firstDate;	// 최초등록일자
	private String firstTime;	// 최초등록시간
	private String lastDate;	// 최종변경일자
	private String lastTime;	// 최변변경시간
	
	
	
	
	
	
	
	
	
	@Override
	public String toString() {
		return "Branch [brno=" + brno + ", korName=" + korName + ", engName=" + engName + ", fxBrnNo=" + fxBrnNo
				+ ", telNo=" + telNo + ", faxNo=" + faxNo + ", zipCode=" + zipCode + ", addr=" + addr + ", brnType="
				+ brnType + ", staCd=" + staCd + ", firstDate=" + firstDate + ", firstTime=" + firstTime + ", lastDate="
				+ lastDate + ", lastTime=" + lastTime + "]";
	}

}