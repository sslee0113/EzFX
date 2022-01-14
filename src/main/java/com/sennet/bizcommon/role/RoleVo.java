package com.sennet.bizcommon.role;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
@Data
public class RoleVo {
	private String roleCd;         // 권한코드	
	private String menuId;         // 메뉴아이디
	private String firstUserId;    // 사용자아이디
	private String firstDatetime;  // 등록일시
	private String lastUserId;     // 최종변경아이디
	private String lastDatetime;   // 변경일시
}