package com.sennet.exchange;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.math.BigDecimal;
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
import com.sennet.exception.NotFoundException;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class ExchangeService {

	@Autowired
	private ExchangeDao exchangeDao;

	@Autowired
	private ModelMapper modelMapper;
	
	@Autowired
	private InterfaceLogService interfaceLogService;

    @Autowired
	private ExchangeAccountingService exchangeAccounting;
    
	
	private String getRefNo(String bizType,String brno){
		// REF번호 구성 : CB + 점(3) + 년월(4) + 일련번호(6)
		String searchRefNo = bizType+brno+StringUtil.currentDateString("yyyyMM").substring(2,6);
		long maxKey = exchangeDao.getExchangeSeq();
		String refNo = searchRefNo + String.format("%06d", maxKey);
		return refNo;
	}
	
	// insert
	public int insertExchange(ExchangeVo paramVo) throws Exception 
	{
		ExchangeVo exchangeVo = modelMapper.map(paramVo,ExchangeVo.class);
		
		String refNo = getRefNo("C"+paramVo.getEfmDscd(), paramVo.getBrno());
		
		if(exchangeDao.findOneExchange(refNo)!=null){
			return -1;
		}
		exchangeVo.setRefNo(refNo);
		exchangeVo.setFrxcLdgrStcd("1");// 1-정상, 9-취소
		exchangeVo.setEfmDscd(paramVo.getEfmDscd());// B:매입,S:매도
		exchangeVo.setTrDt(StringUtil.currentDateString("yyyyMMdd"));
		exchangeVo.setRcfmDt(paramVo.getRcfmDt());
		exchangeVo.setRnnoDscd(paramVo.getRnnoDscd());
		exchangeVo.setRnno(paramVo.getRnno());
		exchangeVo.setPspNo(paramVo.getPspNo());
		exchangeVo.setCustNo(paramVo.getCustNo());
		exchangeVo.setCustNm(paramVo.getCustNm());
		exchangeVo.setCrcd(paramVo.getCrcd());
		exchangeVo.setEfmAmt(paramVo.getEfmAmt());
		exchangeVo.setPmnyAmt(paramVo.getPmnyAmt());
		exchangeVo.setCnAmt(paramVo.getCnAmt());
		exchangeVo.setAmtyDscd(paramVo.getAmtyDscd());
		exchangeVo.setNtntNtcd(paramVo.getNtntNtcd());
		exchangeVo.setUsNtcd(paramVo.getUsNtcd());
		exchangeVo.setTrMnbdPccd(paramVo.getTrMnbdPccd());
		exchangeVo.setIntdRscd(paramVo.getIntdRscd());
		exchangeVo.setBrno(paramVo.getBrno());
		exchangeVo.setCrcCnclDt(paramVo.getCrcCnclDt());
		exchangeVo.setCrcCnclNm(paramVo.getCrcCnclNm());
		exchangeVo.setPmnyExrt(paramVo.getPmnyExrt());
		exchangeVo.setCnExrt(paramVo.getCnExrt());
		exchangeVo.setPrmRt(paramVo.getPrmRt());
		exchangeVo.setWnItrlkAmt(paramVo.getWnItrlkAmt());
		exchangeVo.setWnItrlkAct(paramVo.getWnItrlkAct());
		exchangeVo.setAltWna(paramVo.getAltWna());
		exchangeVo.setCashWna(paramVo.getCashWna());
		exchangeVo.setPmnyAplExrt(paramVo.getPmnyAplExrt());
		exchangeVo.setCnAplExrt(paramVo.getCnAplExrt());
		exchangeVo.setPmnyDlnPlWna(paramVo.getPmnyDlnPlWna());
		exchangeVo.setCnDlnPlWna(paramVo.getCnDlnPlWna());
		exchangeVo.setPmnyStlmWna(paramVo.getPmnyStlmWna());
		exchangeVo.setCnStlmWna(paramVo.getCnStlmWna());
		exchangeVo.setTusaTnslAmt(paramVo.getTusaTnslAmt());
		exchangeVo.setFirstDate(StringUtil.currentDateString("yyyyMMdd"));
		exchangeVo.setFirstTime(StringUtil.currentDateString("HHmmss"));
		exchangeVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
		exchangeVo.setLastTime(StringUtil.currentDateString("HHmmss"));
		
		try{
			// interface log
			int effectRowsOfInterfaceLog = interfaceLogService.insertInterfaceLog(exchangeVo);
			
			// 송금저장
			int effectRowsOfExchange =  exchangeDao.saveExchange(exchangeVo);
			
			// 계정처리 
			int effectRowsremittanceAccounting =  exchangeAccounting.procExchange(exchangeVo, exchangeVo.getRefNo());
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
		return 1;
	}

	// find one
	public ExchangeVo findOneExchange(String refNo) {
		ExchangeVo exchangeVo = exchangeDao.findOneExchange(refNo);
		if (exchangeVo == null) {
			throw new NotFoundException(refNo);
		}		
		return exchangeVo;
	}	

	// UPDATE
	public int updateExchange(String refNo) {
		ExchangeVo exchangeVo = exchangeDao.findOneExchange(refNo);
		exchangeVo.setFrxcLdgrStcd("9");
		exchangeVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
		exchangeVo.setLastTime(StringUtil.currentDateString("HHmmss"));
		return exchangeDao.saveExchange(exchangeVo);
	}

	public List<ExchangeVo> searchList(String startDate, String endDate,String brno, String efmDscd,String refNo) {
		Map<String, Object> condition = new HashMap<String, Object>();		
		condition.put("startDate", startDate);
		condition.put("endDate", endDate);
		condition.put("brno", brno);
		condition.put("efmDscd", efmDscd);
		condition.put("refNo", refNo);
		return exchangeDao.searchListExchange(condition);	
	}
	public ExchangeVo preCalc(String crcd, BigDecimal prmRt, BigDecimal pmnyAmt, BigDecimal cnAmt, String efmDscd) throws Exception
	{
		return exchangeAccounting.preCalc(crcd, prmRt, pmnyAmt, cnAmt, efmDscd);
	}
}
