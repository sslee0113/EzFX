package com.sennet.bizcommon.commondcode;

import java.io.Serializable;

import javax.persistence.Entity;

import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.Table;

import com.sennet.bizcommon.commoncode.CommonCodeVo;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class CommonDcodeVo{
	private String gcode;			// 그룹코드(PK)
	private String dcode;			// 상세구분코드(PK)
	private String dcodeName;		// 상세구분코드명
	private Integer viewSeq;		// 보기순서
	private String firstUserId;		// 최초등록아이디
	private String firstDatetime;	// 최초등록일시
	private String lastUserId;		// 최종변경아이디
	private String lastDatetime;	// 최종변경일시
	
	@Override
	public String toString() {
		return "CommonDcode [gcode=" + gcode + ", dcode=" + dcode + ", dcodeName=" + dcodeName + ", viewSeq=" + viewSeq
				+ ", firstUserId=" + firstUserId + ", firstDatetime=" + firstDatetime + ", lastUserId=" + lastUserId
				+ ", lastDatetime=" + lastDatetime + "]";
	}
	
}