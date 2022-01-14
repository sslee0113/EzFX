package com.sennet.bizcommon.menu;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
@Data
public class MenuVo {
	
	private String menuId;       // 메뉴아이디
	private Integer viewSeq;     // 보기순서
	private String menuUrl;      // 메뉴 URL
	private String menuName;     // 메뉴명 
	private String menuCd;       // 상위메뉴구분코드
	private String dcodeName;    // 상위메뉴구분코드명
	private String firstUserId;  // 등록자 
	private String firstDatetime;// 등록일시
	private String lastUserId;   // 수정자
	private String lastDatetime; // 수정일시
}