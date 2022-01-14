package com.sennet.bizcommon.fee;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sennet.bizcommon.frgnexchrate.FrgnExchRateService;
import com.sennet.bizcommon.frgnexchrate.FrgnExchRateVo;
import com.sennet.common.StringUtil;
import com.sennet.exception.DuplicatedException;
import com.sennet.exception.NotFoundException;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class FeeService {

	@Autowired
	FrgnExchRateService frgnExchRateService;
	
	@Autowired
	private FeeDao feeDao;

	@Autowired
	private ModelMapper modelMapper;
	
	// insert Fee
	public int insertFee(FeeVo paramVo) {
		FeeVo feeVo = modelMapper.map(paramVo, FeeVo.class);
		
		long feeCd = paramVo.getFeeCd();
		String rmtKdcd = paramVo.getRmtKdcd();
		String ntcd = paramVo.getNtcd();
		String crcd = paramVo.getCrcd();
		String aplStrtDt = paramVo.getAplStrtDt();
		String aplEndDt = paramVo.getAplEndDt();
		BigDecimal newStrtAmt = paramVo.getAplStrtAmt();
		BigDecimal newEndAmt = paramVo.getAplEndAmt();
		
		Map<String, Object> amtList = new HashMap<String, Object>();
		amtList.put("rmtKdcd", rmtKdcd);
		amtList.put("ntcd", ntcd);
		amtList.put("crcd", crcd);
		
		List<FeeVo> feeAmtList = feeDao.findByRmtKdcdAndNtcdAndCrcd(amtList);	//findByOptions
		
		log.info("feeTest.size():" + feeAmtList.size());
		for(int i=0; i<feeAmtList.size(); i++){
			FeeVo amt = feeAmtList.get(i);
			BigDecimal amtStrt = amt.getAplStrtAmt();
			BigDecimal amtEnd = amt.getAplEndAmt();
			BigDecimal oldStrtAmt = feeVo.getAplStrtAmt();
			BigDecimal oldEndAmt = feeVo.getAplEndAmt();
			
			if((oldStrtAmt.compareTo(amtStrt) == -1 && oldEndAmt.compareTo(amtEnd) == 1)
			|| (oldStrtAmt.compareTo(amtStrt) == 1 || oldStrtAmt.compareTo(amtStrt) == 0) && (oldStrtAmt.compareTo(amtEnd) == -1 || oldStrtAmt.compareTo(amtEnd) == 0)
			|| (oldEndAmt.compareTo(amtStrt) == 1 || oldEndAmt.compareTo(amtStrt) == 0) && (oldEndAmt.compareTo(amtEnd) == -1 || oldEndAmt.compareTo(amtEnd) == 0)){
				log.error("대상금액이 기존 데이터와 중복됩니다. {},{},{},{},{},{}", rmtKdcd, ntcd, crcd, aplStrtDt, aplEndDt, newStrtAmt);
				throw new DuplicatedException("대상금액이 기존 데이터와 중복됩니다] " +rmtKdcd+", "+ntcd+", "+crcd+", "+newStrtAmt+", "+newEndAmt);
			}
		}
		
		FeeVo feeCdFind = feeDao.findTop1ByOrderByFeeCdDesc(feeCd);
		if(feeCdFind==null){
			feeCd = 1;
			feeVo.setFeeCd(feeCd);
		}
		else{
			feeCd = feeCdFind.getFeeCd()+1;
			feeVo.setFeeCd(feeCd);
		}
		feeVo.setRmtKdcd(paramVo.getRmtKdcd());
		feeVo.setNtcd(paramVo.getNtcd());
		feeVo.setCrcd(paramVo.getCrcd());
		feeVo.setAplStrtDt(paramVo.getAplStrtDt());
		feeVo.setAplEndDt(paramVo.getAplEndDt());
		feeVo.setAplStrtAmt(paramVo.getAplStrtAmt());
		feeVo.setAplEndAmt(paramVo.getAplEndAmt());
		feeVo.setFeeCrcd(paramVo.getFeeCrcd());
		feeVo.setFeeAmt(paramVo.getFeeAmt());
		
		// 로그인된 사용자의 정보 가져온다.
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = authentication.getName();
		feeVo.setFirstUserId(userId);
		feeVo.setFirstDate(StringUtil.currentDateString("yyyyMMdd"));
		feeVo.setFirstTime(StringUtil.currentDateString("HHmmss"));
		feeVo.setLastUserId(userId);
		feeVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
		feeVo.setLastTime(StringUtil.currentDateString("HHmmss"));
		
		return feeDao.saveFee(feeVo);
	}

	// Find One by PK
	public FeeVo findOneFee(long feeCd) {
		return feeDao.findOneFee(feeCd);
	}
	
	// Find ONE BY NTCD, CRCD, AMT
	public FeeVo getFeeForAmt(String rmtKdcd, String ntcd, String crcd, String today, BigDecimal amt){
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("rmtKdcd", rmtKdcd);// 송금종류코드
		map.put("ntcd", ntcd);		// 국가코드
		map.put("crcd", crcd);		// 통화코드
		map.put("today", today);	// 오늘날짜
		map.put("amt", amt);		// 송금금액
		
		FeeVo feeVo = feeDao.getFeeForAmt(map);
		if (feeVo == null) {
			throw new NotFoundException(rmtKdcd+","+ntcd+","+crcd+","+today+","+amt);
		}		
		return feeVo;
	}
	
	// update Fee
	public int updateFee(FeeVo paramVo) {
		FeeVo feeVo = feeDao.findOneFee(paramVo.getFeeCd());
		if (feeVo == null) {
			throw new NotFoundException(paramVo.getFeeCd());
		}

		String rmtKdcd = paramVo.getRmtKdcd();
		String ntcd = paramVo.getNtcd();
		String crcd = paramVo.getCrcd();
		String aplStrtDt = paramVo.getAplStrtDt();
		String aplEndDt = paramVo.getAplEndDt();
		BigDecimal newStrtAmt = paramVo.getAplStrtAmt();	// 수정할 시작금액
		BigDecimal newEndAmt = paramVo.getAplEndAmt();		// 수정할 종료금액
		
		Map<String, Object> amtList = new HashMap<String, Object>();
		amtList.put("rmtKdcd", rmtKdcd);
		amtList.put("ntcd", ntcd);
		amtList.put("crcd", crcd);
		
		List<FeeVo> feeAmtList = feeDao.findByRmtKdcdAndNtcdAndCrcd(amtList);	//findByOptions
		
		log.info("feeTest.size():" + feeAmtList.size());
		for(int i=0; i<feeAmtList.size(); i++){
			FeeVo amt = feeAmtList.get(i);
			BigDecimal amtStrt = amt.getAplStrtAmt();			// 시작금액 기존데이터 
			BigDecimal amtEnd = amt.getAplEndAmt();				// 종료금액 기존데이터
			BigDecimal oldStrtAmt = feeVo.getAplStrtAmt();		// 선택한 레코드 기존데이터
			BigDecimal oldEndAmt = feeVo.getAplEndAmt();		// 선택한 레코드 기존데이터
			if(oldStrtAmt.compareTo(amtStrt) == 0 && oldEndAmt.compareTo(amtEnd) == 0){
				continue;
			}
			else if((newStrtAmt.compareTo(amtStrt) == -1 && newEndAmt.compareTo(amtEnd) == 1)
			|| (newStrtAmt.compareTo(amtStrt) == 1 || newStrtAmt.compareTo(amtStrt) == 0) && (newStrtAmt.compareTo(amtEnd) == -1 || newStrtAmt.compareTo(amtEnd) == 0)
			|| (newEndAmt.compareTo(amtStrt) == 1 || newEndAmt.compareTo(amtStrt) == 0) && (newEndAmt.compareTo(amtEnd) == -1 || newEndAmt.compareTo(amtEnd) == 0)){
				log.error("대상금액이 기존 데이터와 중복됩니다. {},{},{},{},{},{}", rmtKdcd, ntcd, crcd, aplStrtDt, aplEndDt, newStrtAmt);
				throw new DuplicatedException("대상금액이 기존 데이터와 중복됩니다] " +rmtKdcd+", "+ntcd+", "+crcd+", "+newStrtAmt+", "+newEndAmt);
			}
		}

		feeVo.setRmtKdcd(paramVo.getRmtKdcd());
		feeVo.setNtcd(paramVo.getNtcd());
		feeVo.setCrcd(paramVo.getCrcd());
		feeVo.setAplStrtDt(paramVo.getAplStrtDt());
		feeVo.setAplEndDt(paramVo.getAplEndDt());
		feeVo.setAplStrtAmt(paramVo.getAplStrtAmt());
		feeVo.setAplEndAmt(paramVo.getAplEndAmt());
		feeVo.setFeeCrcd(paramVo.getFeeCrcd());
		feeVo.setFeeAmt(paramVo.getFeeAmt());
		
		// 로그인된 사용자의 정보 가져온다.
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = authentication.getName();
		feeVo.setLastUserId(userId);
		feeVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
		feeVo.setLastTime(StringUtil.currentDateString("HHmmss"));
		
		return feeDao.saveFee(feeVo);
	}
	
	// 리스트 조회
	public List<FeeVo> searchListFee(String rmtKdcd, String ntcd, String crcd, String aplStrtDt, String aplEndDt, String aplStrtAmt, String aplEndAmt) {
		Map<String, Object> condition = new HashMap<String, Object>();		
		condition.put("rmtKdcd", rmtKdcd);
		condition.put("ntcd", ntcd);
		condition.put("crcd", crcd);
		condition.put("aplStrtDt", aplStrtDt);
		condition.put("aplEndDt", aplEndDt);
		condition.put("aplStrtAmt", aplStrtAmt);
		condition.put("aplEndAmt", aplEndAmt);
		
		return feeDao.searchListFee(condition);	
	}
	
	/**
	 * 1.수수료대상금액에 대한 수수료 정보를 가져온다.
	 * 2.KRW 가 아닐 경우 현재 매매기준율을 기준으로 원화금액을 계산한다.
	 * 
	 * @param rmtKdcd 송금종류
	 * @param crcd 통화코드
	 * @param ntcd 국가코드
	 * @param amt 수수료대상금액
	 * @return 수수료계산 결과
	 */
	public BigDecimal getFeeAmt(String rmtKdcd, String crcd, String ntcd, BigDecimal amt){
		
		// 1.수수료대상금액에 대한 수수료 정보를 가져온다.
		String today = StringUtil.currentDateString("yyyyMMdd");
		FrgnExchRateVo frgnExchRateVo = frgnExchRateService.getFrgnExchRateVo(today,crcd);

		FeeVo feeVo = this.getFeeForAmt(rmtKdcd, ntcd, crcd, today, amt);
		if(feeVo == null){
			throw new NotFoundException("["+ntcd+"],["+crcd+"],["+amt+"] 에 대한 수수료가 존재하지 않습니다.");
		}
		else{
			// KRW 일 경우
			if(feeVo.getFeeCrcd().equalsIgnoreCase("KRW")){
				return feeVo.getFeeAmt();
			}
			// KRW 가 아닐 경우 현재 매매기준율을 기준으로 원화금액을 계산한다.
			else{
				BigDecimal won = feeVo.getFeeAmt().multiply(frgnExchRateVo.getMidRate());
				return won;
			}
		}
	}

}