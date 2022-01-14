package com.sennet.bizcommon.zipcode;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ZipcodeVo {
	
	private int totalCount;		// 행개수
	private String zipcode;				// 구역번호
	private String province;			// 시도
	private String provinceEng;			// 시도영문
	private String county;				// 시군구
	private String countyEng;			// 시군구영문
	private String town;				// 읍면
	private String townEng;				// 읍면영문
	private String roadNameCd;			// 도로명코드
	private String roadName;			// 도로명
	private String roadNameEng;			// 도로명영문
	private String undergroundYn;		// 지하여부
	private String mainBuildingNo;		// 건물번호본번
	private String subBuildingNo;		// 건물번호부번
	private String buildingMgntNo;		// 건물관리번호(PK)
	private String bulkDeliveryName;	// 다량배달처명
	private String buildingName;		// 시군구용건물명
	private String lawDongCode;			// 법정동코드
	private String lawDongName;			// 법정동명
	private String liName;				// 리명
	private String adminDongName;		// 행정동명
	private String mountainYn;			// 산여부
	private String mainLotNo;			// 지번본번
	private String serialNo;			// 읍면동일련번호
	private String subLotNo;			// 지번부번
	private String oldZipcode;			// 구_우편번호
	private String zipcodeSerialNo;		// 우편번호일련번호
	private String addr;
	
	@Override
	public String toString() {
		return "Zipcode [zipcode=" + zipcode + ", province=" + province + ", provinceEng=" + provinceEng + ", county=" + county
				+ ", countyEng=" + countyEng + ", town=" + town + ", townEng=" + townEng + ", roadNameCd=" + roadNameCd + ", roadName="
				+ roadName + ", roadNameEng=" + roadNameEng + ", undergroundYn=" + undergroundYn + ", mainBuildingNo=" + mainBuildingNo
				+ ", subBuildingNo=" + subBuildingNo + ", buildingMgntNo=" + buildingMgntNo + ", bulkDeliveryName=" + bulkDeliveryName
				+ ", buildingName=" + buildingName + ", lawDongCode=" + lawDongCode + ", lawDongName=" + lawDongName + ", liName=" + liName
				+ ", adminDongName=" + adminDongName + ", mountainYn=" + mountainYn + ", mainLotNo=" + mainLotNo + ", serialNo=" + serialNo
				+ ", subLotNo=" + subLotNo + ", oldZipcode=" + oldZipcode + ", zipcodeSerialNo=" + zipcodeSerialNo + "]";
	}

}