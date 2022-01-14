package com.sennet.bizcommon.role;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class TrRoleVo {
	private String chk;                  // 권한체크
	private String roleCd;               // 권한코드
	private String menuUrl;              // 메뉴URL
	private String menuName;             // 메뉴명
	private String menuId;               // 메뉴아이디
	private String dcode;                // 상위메뉴구분코드
	private String dcodeName;            // 상위메뉴구분코드명
	private String firstUserId;          // 등록자
	private String firstDatetime;        // 등록일시
	private String lastUserId;           // 수정자
	private String lastDatetime;         // 수정일시
	@Override
	public String toString() {
		return "TrRoleVo [chk=" + chk + ", roleCd=" + roleCd + ", menuUrl=" + menuUrl + ", menuName=" + menuName
				+ ", menuId=" + menuId + ", dcodeName=" + dcodeName + ", firstUserId=" + firstUserId
				+ ", firstDatetime=" + firstDatetime + ", lastUserId=" + lastUserId + ", lastDatetime=" + lastDatetime
				+ "]";
	}
	public boolean isActive(){
		return this.chk==null?false:true;
	}
}