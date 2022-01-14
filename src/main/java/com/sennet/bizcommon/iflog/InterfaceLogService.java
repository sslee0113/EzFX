package com.sennet.bizcommon.iflog;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sennet.accounting.GlMasterVo;
import com.sennet.bizcommon.zipcode.ZipcodeVo;
import com.sennet.common.StringUtil;
import com.sennet.exchange.ExchangeVo;
import com.sennet.remittance.RemittanceVo;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class InterfaceLogService {

	@Autowired
	private InterfaceLogDao interfaceLogDao;
	
	// Insert
	public int insertInterfaceLog(Object object) {
		
		
		InterfaceLogVo interfaceLogVo = new InterfaceLogVo(); 

		String bizType;
		// 환전
		if(object instanceof ExchangeVo){

			ExchangeVo exchangeVo = (ExchangeVo)object;
			
			bizType = exchangeVo.getRefNo().substring(0, 2);
			interfaceLogVo.setIfNo(exchangeVo.getRefNo());
			interfaceLogVo.setBizType(bizType);
			interfaceLogVo.setStaCd(exchangeVo.getFrxcLdgrStcd());

		}else
		// 송금
		if(object instanceof RemittanceVo){
			
			RemittanceVo rmt = (RemittanceVo)object;
			
			bizType = rmt.getRefNo().substring(0, 2);
			interfaceLogVo.setIfNo(rmt.getRefNo());
			interfaceLogVo.setBizType(bizType);
			interfaceLogVo.setStaCd(rmt.getFrxcLdgrStcd());
			
		}else
		// 회계
		if(object instanceof GlMasterVo){
			
			GlMasterVo gm = (GlMasterVo)object;
			interfaceLogVo.setIfNo(gm.getActgTrDt()+gm.getActgTrSrno());
			interfaceLogVo.setBizType("GL");
			interfaceLogVo.setStaCd(gm.getStatTcd());

		}else{
			return -1;
		}
		
		interfaceLogVo.setTrYn("N");
		interfaceLogVo.setTrDate(StringUtil.currentDateString("yyyyMMdd"));
		interfaceLogVo.setTrTime(StringUtil.currentDateString("HHmmss"));
		interfaceLogVo.setFirstDate(StringUtil.currentDateString("yyyyMMdd"));
		interfaceLogVo.setFirstTime(StringUtil.currentDateString("HHmmss"));
		interfaceLogVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
		interfaceLogVo.setLastTime(StringUtil.currentDateString("HHmmss"));

		return interfaceLogDao.saveInterfaceLog(interfaceLogVo);
	}

	// PK
	public InterfaceLogVo findOneInterfaceLog(String ifNo,String staCd) {
		Map<String, Object> condition = new HashMap<String, Object>();		
		condition.put("ifNo", ifNo);
		condition.put("staCd", staCd);
		return interfaceLogDao.findOneInterfaceLog(condition);		
	}	
	
	// Update
	public int updateInterfaceLog(Object object) {
		
		String ifNo, staCd;
		if(object instanceof ExchangeVo){

			ExchangeVo exchange = (ExchangeVo)object;
			ifNo = exchange.getRefNo();
			staCd = exchange.getFrxcLdgrStcd();

		}else
		if(object instanceof RemittanceVo){
			
			RemittanceVo rmt = (RemittanceVo)object;
			ifNo = rmt.getRefNo();
			staCd = rmt.getFrxcLdgrStcd();
			
		}else
		if(object instanceof GlMasterVo){
			
			GlMasterVo gm = (GlMasterVo)object;
			ifNo = gm.getActgTrDt()+gm.getActgTrSrno();
			staCd = gm.getStatTcd();
		}else{
			return -1;
		}

		// 수정할 Interface log 조회
		InterfaceLogVo interfaceLogVo = this.findOneInterfaceLog(ifNo,staCd);
		if(interfaceLogVo == null){
			return -1;
		}
		interfaceLogVo.setTrYn("Y");
		interfaceLogVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
		interfaceLogVo.setLastTime(StringUtil.currentDateString("HHmmss"));
		return interfaceLogDao.saveInterfaceLog(interfaceLogVo);
	}
	
	public PageImpl<InterfaceLogVo> searchListInterfaceLogPageable(String startDate,String endDate,String trYn,String bizType,Pageable pageable) {
		int totalCount = 0;
		Map<String, Object> condition = new HashMap<String, Object>();		
		condition.put("startDate", startDate);
		condition.put("endDate", endDate);
		condition.put("trYn", trYn);
		condition.put("bizType", bizType);
		condition.put("start", pageable.getOffset());
		condition.put("end", pageable.getOffset()+pageable.getPageSize());
		List<InterfaceLogVo> interfaceLogList =  interfaceLogDao.searchListZipcodePageable(condition);
		if(interfaceLogList.size()>0){
			totalCount = ((InterfaceLogVo)interfaceLogList.get(0)).getTotalCount();
		}
        return new PageImpl<InterfaceLogVo>(interfaceLogList, pageable,totalCount);
	}
}
 