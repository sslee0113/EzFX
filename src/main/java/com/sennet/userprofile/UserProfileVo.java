package com.sennet.userprofile;

import java.util.List;

import com.sennet.bizcommon.role.TrRoleVo;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class UserProfileVo {
	
	private Long   accountSeq;      // 순서번호(PK)
	private String userName;        // 사용자아이디
	private String password;        // 비밀번호
	private String fullName;        // 사용자명
	private String role;            // 권한코드
	private String startDate;       // 생성일시
	private String modifyDate;      // 수정일시
	private String finalDate;       // 
	private Integer badCount;       // 로그인실패횟수
	private String badCountdate;    // 로그인실패일
	private String whiteIp;         // 허용IP
	private String passwordDate;    // 패스워드 수정일
	private String posCd;           // 직급코드
	private String userPos;         // 직급명 
	private String superUser;       // 최고책임자여부
	private String brno;            // 소속지점코드
	private String offrId;          // 책임자 아이디 
	private String telNo;           // 전화번호
	private String cellNo;          // 핸드폰 번호
	private List<TrRoleVo> trRoleVoList;  // 사용자 권한에 따른 메뉴 리스트
	private String tempPassword;    // 임시 비밀번호
}
