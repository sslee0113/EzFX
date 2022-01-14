package com.sennet.common;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;

public class ErrorMsg {
	
	public ErrorResponse getBindingResultErrMsg(String bizCode, BindingResult result){
		
		ErrorResponse errorResponse = new ErrorResponse();
		List<ObjectError> errorList = result.getAllErrors();
        Iterator<ObjectError> itr = errorList.iterator();
        ObjectError oe;
        String msg;
        String codes[];
        String code;
        String field;
        while(itr.hasNext()){
        	oe = itr.next();
        	oe.getDefaultMessage();
        	codes = oe.getCodes();
        	codes = codes[0].split("\\.");
        	field = codes[codes.length-1];

        	code = oe.getCode(); // NotBlank or NotNull
        	msg = this.getRemittance().get(field);

        	if(code!=null && code.equalsIgnoreCase("NOTBLANK")){
				errorResponse.setMessage(msg + " 항목은 필수 입력 값입니다.");
        	}else
        	if(code!=null && code.equalsIgnoreCase("NOTBLANK")){
				errorResponse.setMessage(msg + " 항목은 필수 입력 값입니다.");
        	}
        	errorResponse.setCode("bad.request");

        	break;
        }
        
        return errorResponse;
	}
	

	public String getErrMsg(String bizCode, String key){
		
		if(bizCode==null){
			return null;
		}
		
		if(bizCode.equalsIgnoreCase("OR")){
			return getRemittance().get(key);
		}
		
		return "";
	}
	
	private Map<String, String> getRemittance(){

		Map<String, String> map = new HashMap<String, String>();
		
		map.put("refNo","REF번호");
		map.put("trBrno","거래점번호");
		map.put("rmtKdcd","송금종류코드");
		map.put("crcd","통화코드");
		map.put("owmnAmt","당발송금금액");
		map.put("trDt","거래일자");
		map.put("sndgDt","발송일자");
		map.put("rcfmDt","기산일자");
		map.put("crcCnclDt","정정취소일자");
		map.put("crcCnclNm","정정취소사유");
		map.put("intquotSeq","고시회차");
		map.put("basicRate","매매기준율");
		map.put("prmRt","우대율");
		map.put("aplExrt","적용환율");
		map.put("dlnPlWna","매매손익원화금액");
		map.put("tusaTnslAmt","대미환산금액");
		map.put("rmprRnnoDscd","송금인실명번호구분코드");
		map.put("rmprRnno","송금인실명번호");
		map.put("rmprPspNo","송금인여권번호");
		map.put("rmprCustNo","송금인고객번호");
		map.put("rmprKrFirstNm","송금인한글명(성)");
		map.put("rmprKrLastNm","송금인한글명(이름)");
		map.put("rmprEnFirstNm","송금인영문명(성)");
		map.put("rmprEnLastNm","송금인영문명(이름)");
		map.put("rmprAdr1","송금인주소1");
		map.put("rmprAdr2","송금인주소2");
		map.put("rmprAdr3","송금인주소3");
		map.put("rmprTlno","송금인전화번호");
		map.put("rmprCellNo","송금인핸드폰번호");
		map.put("rmprNtntNtcd","송금인국적국가코드");
		map.put("rmprAmtyDscd","송금인거주성구분코드");
		map.put("rmprTrMnbdPccd","송금인거래주체특성코드");
		map.put("rmprSitNtcd","송금인소재지국가코드");
		map.put("rmprSitZip","송금인소재지우편번호");
		map.put("adreRnnoDscd","수취인실명번호구분코드");
		map.put("adreRnno","수취인실명번호");
		map.put("adreEnFirstNm","수취인영문명(성)");
		map.put("adreEnLastNm","수취인영문명(이름)");
		map.put("adreState","수취인주(STATE)");
		map.put("adreCty","수취인지급도시(CITY)");
		map.put("adreAdr1","수취인주소1");
		map.put("adreAdr2","수취인주소2");
		map.put("adreAdr3","수취인주소3");
		map.put("adreAcno","수취인계좌번호");
		map.put("adreNtcd","수취인국가코드");
		map.put("adreNtntNtcd","수취인국적국가코드");
		map.put("adreAmtyDscd","수취인거주성구분코드");
		map.put("adreTlno","수취인전화번호");
		map.put("rcvgBnkCd","수취인기관번호");
		map.put("feeCrcd","수수료통화코드");
		map.put("feeAmt","수수료외화금액");
		map.put("feeAmtWna","수수료원화금액");
		map.put("cndChgDt","조건변경일자");
		map.put("rmtApcDscd","송금신청구분코드");
		map.put("wnaAcno","원화계좌번호");
		map.put("acAmtWna","연동원화금액");
		map.put("altAmtWna","일반원화대체");
		map.put("cashWna","현금");
		map.put("drwbAmt","퇴결금액");
		map.put("hdyTrYn","휴일거래여부");
		map.put("closAfTrYn","마감후거래여부");
		map.put("frxcLdgrStcd","외환원장상태코드");
		map.put("firstDate","최초등록일자");
		map.put("firstTime","최초등록시간");
		map.put("lastDate","최종변경일자");
		map.put("lastTime","최종변경시간");
		
		return map;
	}
}
