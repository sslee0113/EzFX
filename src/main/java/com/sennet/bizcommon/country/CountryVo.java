package com.sennet.bizcommon.country;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class CountryVo {
	
	private String ctryCode;		// 국가코드(PK)
	private String engName;			// 영문명
	private String korName;			// 한글명
	private String currCode;		// 통화코드
	private String oecdJoinFlag;	// OECD가입여부
	private String ctntType;		// 대륙코드
	private String g8JoinFlag;		// G8가입여부
	private String staCd;			// 상태구분코드
	private String firstDate;		// 최초등록일자
	private String firstTime;		// 최초등록시간
	private String lastDate;		// 최종변경일자
	private String lastTime;		// 최초등록시간
	
	

	@Override
	public String toString() {
		return "Country [ctryCode=" + ctryCode + ", engName=" + engName + ", korName=" + korName + ", currCode="
				+ currCode + ", oecdJoinFlag=" + oecdJoinFlag + ", ctntType=" + ctntType + ", g8JoinFlag=" + g8JoinFlag
				+ ", staCd=" + staCd + ", firstDate=" + firstDate + ", firstTime=" + firstTime + ", lastDate="
				+ lastDate + ", lastTime=" + lastTime + "]";
	}

}