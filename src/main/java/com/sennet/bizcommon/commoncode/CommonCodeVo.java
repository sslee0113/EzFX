package com.sennet.bizcommon.commoncode;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
@Data
@Getter
@Setter
public class CommonCodeVo {
	
	private String gcode;			// 그룹코드(PK)
	private String gcodeName;		// 그룹코드명
	private String staCd;			// 상태구분코드
	private String firstUserId;		// 최초등록아이디
	private String firstDatetime;	// 최초등록일시
	private String lastUserId;		// 최종변경아이디
	private String lastDatetime;	// 최종변경일시
	@Override
	public String toString() {
		return "CommonCode [gcode=" + gcode + ", gcodeName=" + gcodeName + ", staCd=" + staCd + ", firstUserID="
				+ firstUserId + ", firstDatetime=" + firstDatetime + ", lastUserId=" + lastUserId + ", lastDatetime="
				+ lastDatetime + "]";
	}

}