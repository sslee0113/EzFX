package com.sennet.accounting.bs;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class BsResponseVo {

	private String acsjCd;     //계정과목코드
	private String acsjOputNm; //계정과목조회명
	private String currCd;     //통화코드
	private String frc;        //외화
	private String won;        //원화
	private String usdCros;    // 0
	private String qrySqn;     // 0

}
