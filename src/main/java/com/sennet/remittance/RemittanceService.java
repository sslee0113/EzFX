package com.sennet.remittance;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.sennet.bizcommon.iflog.InterfaceLogService;
import com.sennet.common.StringUtil;
import com.sennet.exception.DuplicatedException;
import com.sennet.exception.NotFoundException;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class RemittanceService {

    @Autowired
	private RemittanceAccountingService remittanceAccountingService;
	
	@Autowired
	private InterfaceLogService interfaceLogService;

	@Autowired
	private RemittanceDao remittanceDao;

	@Autowired
	private ModelMapper modelMapper;

	
	public String getRefNo(String brno){
		// REF번호 구성 : OC + 점(3) + 년월(4) + 일련번호(6)
		int nextKey = remittanceDao.getRemittanceSeq();
		return "OC"+brno+StringUtil.currentDateString("yyyyMM").substring(2,6)+String.format("%06d", nextKey);
	}

	// insert Remittance
	public RemittanceVo insertRemittance(RemittanceVo paramRemittanceVo) throws Exception {
		
		RemittanceVo remittanceVo = modelMapper.map(paramRemittanceVo, RemittanceVo.class);

		String refNo = this.getRefNo(paramRemittanceVo.getTrBrno());
		RemittanceVo tmp = remittanceDao.findOneRemittance(refNo);
		
		// 해당 refNo 이미사용중
		if(tmp!=null){
			throw new DuplicatedException(refNo);
		}
		remittanceVo.setRefNo(refNo);
		remittanceVo.setTrBrno(paramRemittanceVo.getTrBrno());
		remittanceVo.setRmtKdcd(paramRemittanceVo.getRmtKdcd());
		remittanceVo.setCrcd(paramRemittanceVo.getCrcd());
		remittanceVo.setOwmnAmt(paramRemittanceVo.getOwmnAmt());
		remittanceVo.setTrDt(StringUtil.currentDateString("yyyyMMdd"));
		remittanceVo.setSndgDt(paramRemittanceVo.getSndgDt());
		remittanceVo.setRcfmDt(paramRemittanceVo.getRcfmDt());
		remittanceVo.setCrcCnclDt(paramRemittanceVo.getCrcCnclDt());
		
		remittanceVo.setCrcCnclNm(paramRemittanceVo.getCrcCnclNm());
		remittanceVo.setQuotSeq(paramRemittanceVo.getQuotSeq());
		remittanceVo.setBasicRate(paramRemittanceVo.getBasicRate());
		remittanceVo.setPrmRt(paramRemittanceVo.getPrmRt());
		remittanceVo.setAplExrt(paramRemittanceVo.getAplExrt());
		remittanceVo.setDlnPlWna(paramRemittanceVo.getDlnPlWna());
		remittanceVo.setTusaTnslAmt(paramRemittanceVo.getTusaTnslAmt());
		remittanceVo.setRmprRnnoDscd(paramRemittanceVo.getRmprRnnoDscd());
		remittanceVo.setRmprRnno(paramRemittanceVo.getRmprRnno());
		remittanceVo.setRmprPspNo(paramRemittanceVo.getRmprPspNo());
		remittanceVo.setRmprCustNo(paramRemittanceVo.getRmprCustNo());
		remittanceVo.setRmprKrFirstNm(paramRemittanceVo.getRmprKrFirstNm());
		remittanceVo.setRmprKrLastNm(paramRemittanceVo.getRmprKrLastNm());
		remittanceVo.setRmprEnFirstNm(paramRemittanceVo.getRmprEnFirstNm());
		remittanceVo.setRmprEnLastNm(paramRemittanceVo.getRmprEnLastNm());
		remittanceVo.setRmprAdr1(paramRemittanceVo.getRmprAdr1());
		remittanceVo.setRmprAdr2(paramRemittanceVo.getRmprAdr2());
		remittanceVo.setRmprAdr3(paramRemittanceVo.getRmprAdr3());
		remittanceVo.setRmprTlno(paramRemittanceVo.getRmprTlno());
		remittanceVo.setRmprCellNo(paramRemittanceVo.getRmprCellNo());
		remittanceVo.setRmprNtntNtcd(paramRemittanceVo.getRmprNtntNtcd());
		remittanceVo.setRmprAmtyDscd(paramRemittanceVo.getRmprAmtyDscd());
		remittanceVo.setRmprTrMnbdPccd(paramRemittanceVo.getRmprTrMnbdPccd());
		remittanceVo.setRmprSitNtcd(paramRemittanceVo.getRmprSitNtcd());
		remittanceVo.setRmprSitZip(paramRemittanceVo.getRmprSitZip());
		remittanceVo.setAdreRnnoDscd(paramRemittanceVo.getAdreRnnoDscd());
		remittanceVo.setAdreRnno(paramRemittanceVo.getAdreRnno());
		remittanceVo.setAdreEnFirstNm(paramRemittanceVo.getAdreEnFirstNm());
		remittanceVo.setAdreEnLastNm(paramRemittanceVo.getAdreEnLastNm());
		remittanceVo.setAdreState(paramRemittanceVo.getAdreState());
		remittanceVo.setAdreCty(paramRemittanceVo.getAdreCty());
		remittanceVo.setAdreAdr1(paramRemittanceVo.getAdreAdr1());
		remittanceVo.setAdreAdr2(paramRemittanceVo.getAdreAdr2());
		remittanceVo.setAdreAdr3(paramRemittanceVo.getAdreAdr3());
		remittanceVo.setAdreAcno(paramRemittanceVo.getAdreAcno());
		remittanceVo.setAdreNtcd(paramRemittanceVo.getAdreNtcd());
		remittanceVo.setAdreNtntNtcd(paramRemittanceVo.getAdreNtntNtcd());
		remittanceVo.setAdreAmtyDscd(paramRemittanceVo.getAdreAmtyDscd());
		remittanceVo.setAdreTlno(paramRemittanceVo.getAdreTlno());
		remittanceVo.setRcvgBnkCd(paramRemittanceVo.getRcvgBnkCd());
		remittanceVo.setFeeCrcd(paramRemittanceVo.getFeeCrcd());
		remittanceVo.setFeeAmt(paramRemittanceVo.getFeeAmt());
		remittanceVo.setFeeAmtWna(paramRemittanceVo.getFeeAmtWna());
		remittanceVo.setCndChgDt(paramRemittanceVo.getCndChgDt());
		remittanceVo.setRmtApcDscd(paramRemittanceVo.getRmtApcDscd());
		remittanceVo.setWnItrlkAct(paramRemittanceVo.getWnItrlkAct());
		remittanceVo.setWnItrlkAmt(paramRemittanceVo.getWnItrlkAmt());
		remittanceVo.setAltWna(paramRemittanceVo.getAltWna());
		remittanceVo.setCashWna(paramRemittanceVo.getCashWna());
		remittanceVo.setDrwbAmt(paramRemittanceVo.getDrwbAmt());
		remittanceVo.setHdyTrYn(paramRemittanceVo.getHdyTrYn());
		remittanceVo.setClosAfTrYn(paramRemittanceVo.getClosAfTrYn());
		// 1-정상, 9-취소
		remittanceVo.setFrxcLdgrStcd("1");
		remittanceVo.setFirstDate(StringUtil.currentDateString("yyyyMMdd"));
		remittanceVo.setFirstTime(StringUtil.currentDateString("HHmmss"));
		remittanceVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
		remittanceVo.setLastTime(StringUtil.currentDateString("HHmmss"));
		
		try{
			// interface log
			int effectRowsOfInterfaceLog = interfaceLogService.insertInterfaceLog(remittanceVo);
			
			// 송금저장
			int effectRowsOfRemittance =  remittanceDao.saveRemittance(remittanceVo);
			
			// 계정처리 
			int effectRowsremittanceAccounting =  remittanceAccountingService.procRemittance(remittanceVo, remittanceVo.getRefNo());
		}
		catch(Exception e){
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			StringWriter sw = new StringWriter();
			PrintWriter pw = new PrintWriter(sw);
			e.printStackTrace(pw);
			String sStackTrace = sw.toString(); // stack trace as a string
			log.error(sStackTrace);
			throw e;
		}
		return remittanceVo;
	}	
	
	// READ BY REFNO
	public List<RemittanceVo> readrefNoOne(String refNo) {
		RemittanceVo remittanceVo = remittanceDao.findOneRemittance(refNo);
		if (remittanceVo == null) {
			throw new NotFoundException(refNo);
		}		
		else{
			List<RemittanceVo> list = new ArrayList<RemittanceVo>();
			list.add(remittanceVo);
			return list;
		}
	}
	// get list 
	public List<RemittanceVo> getRemittanceVoList(String startDate, String endDate,String refNo) {
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("startDate", startDate);
		condition.put("endDate", endDate);
		condition.put("refNo", refNo);
		return remittanceDao.searchListRemittance(condition);
	}	
	
	// get Total List 
	public List<RemittanceTotalVo> getRemittanceTotal(String trBrno,String trDt, String crcd) {
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("trBrno", trBrno);
		condition.put("trDt", trDt);
		condition.put("crcd", crcd);
		return remittanceDao.getRemittanceTotal(condition);
	}	
	// get Sub List 
	public List<RemittanceVo> getRemittanceSubList(String trBrno,String trDt, String crcd) {
		Map<String, Object> condition = new HashMap<String, Object>();
		condition.put("trBrno", trBrno);
		condition.put("trDt", trDt);
		condition.put("crcd", crcd);
		return remittanceDao.searchListRemittance(condition);
	}	

	// get preCalc 
	public RemittanceVo getRemittancePreCalc(String rmtKdcd,String ntcd, String crcd,BigDecimal prmrt,BigDecimal owmnAmt) throws Exception{
		/**
		 * 통화에 대한 고시환율, 우대율을 사용하여 지폐 및 주화 금액에 대한 원화금액과 거래이익을 계산해온다.
		 */
		
		RemittanceVo responseVo = new RemittanceVo();
		try{

			RemittanceVo calcResultVo = remittanceAccountingService.calcRemittance(rmtKdcd, crcd, ntcd, prmrt, owmnAmt);
			responseVo.setOwmnAmt(owmnAmt);
			responseVo.setCashWna(calcResultVo.getCashWna());               // 현금
			responseVo.setDlnPlWna(calcResultVo.getDlnPlWna());             // 매매손익원화금액
			responseVo.setAplExrt(calcResultVo.getAplExrt());               // 적용환율
			responseVo.setBasicRate(calcResultVo.getBasicRate());           // 매매기준율
			responseVo.setPrmRt(calcResultVo.getPrmRt());                   // 우대율
			responseVo.setTusaTnslAmt(calcResultVo.getTusaTnslAmt());       // 대미환산금액 
			responseVo.setQuotSeq(calcResultVo.getQuotSeq());               // 고시회차
			responseVo.setFeeAmtWna(calcResultVo.getFeeAmtWna());           // 수수료원화금액
			
		}catch(Exception e){
			throw e;
		}
		return responseVo;
	}	
	
	// UPDATE
	public int update(String refNo) {
		RemittanceVo remittanceVo = remittanceDao.findOneRemittance(refNo);
		if (remittanceVo == null) {
			throw new NotFoundException(refNo);
		}		
		remittanceVo.setFrxcLdgrStcd("9");
		remittanceVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
		remittanceVo.setLastTime(StringUtil.currentDateString("HHmmss"));

		return remittanceDao.saveRemittance(remittanceVo);
	}
	
}
