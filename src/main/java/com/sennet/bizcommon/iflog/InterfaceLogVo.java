package com.sennet.bizcommon.iflog;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class InterfaceLogVo {
	private String ifNo;		// 인터페이스 번호(Pk)
	private String staCd;		// 상태코드(PK)
	private String trYn;		// 전송여부
	private String trDate;		// 전송여부
	private String trTime;		// 거래시각
	private String bizType;		// 업무종료
	private String firstDate;	// 생성일자
	private String firstTime;	// 생성시간
	private String lastDate;	// 수정일자
	private String lastTime;	// 수정시간
	private int totalCount;	// Pageable 총 개수

	@Override
	public String toString() {
		return "IfLog [" + (ifNo != null ? "ifNo=" + ifNo + ", " : "") + (staCd != null ? "staCd=" + staCd + ", " : "")
				+ (trYn != null ? "trYn=" + trYn + ", " : "") + (trDate != null ? "trDate=" + trDate + ", " : "")
				+ (trTime != null ? "trTime=" + trTime + ", " : "")
				+ (bizType != null ? "bizType=" + bizType + ", " : "")
				+ (firstDate != null ? "firstDate=" + firstDate + ", " : "")
				+ (firstTime != null ? "firstTime=" + firstTime + ", " : "")
				+ (lastDate != null ? "lastDate=" + lastDate + ", " : "")
				+ (lastTime != null ? "lastTime=" + lastTime : "") + "]";
	}

}