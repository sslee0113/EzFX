package com.sennet.accounting;

import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sennet.bizcommon.iflog.InterfaceLogService;
import com.sennet.common.StringUtil;
import com.sennet.exception.NotFoundException;
import com.sennet.exception.NotValidException;

import lombok.extern.slf4j.Slf4j;

@Service
//@Transactional
@Slf4j
public class GlMasterService {

	@Autowired
	private GlMasterDao glMasterDao;

	@Autowired
	private ModelMapper modelMapper;
	
	@Autowired
	private InterfaceLogService interfaceLogService;
	
	// Insert
	public int insertGlMaster(GlMasterVo paramVo) {

		GlMasterVo glMasterVo = modelMapper.map(paramVo, GlMasterVo.class);
		GlMasterVo glMasterVoTmp = glMasterDao.findOneGlMaster(glMasterVo.getActgTrDt(), glMasterVo.getActgTrSrno());
		if(glMasterVoTmp !=null){
			return -1;
		}
		glMasterVo.setActgTrDt(StringUtil.currentDateString("yyyyMMdd"));
		glMasterVo.setActgTrSrno(paramVo.getActgTrSrno());
		glMasterVo.setBzTcd(paramVo.getBzTcd());
		glMasterVo.setRefNo(paramVo.getRefNo());
		glMasterVo.setPrcTcd(paramVo.getPrcTcd());
		glMasterVo.setOrgActgTrDt(paramVo.getOrgActgTrDt());
		glMasterVo.setOrgActgTrSrno(paramVo.getOrgActgTrSrno());
		// 1-정상, 9-취소
		glMasterVo.setStatTcd("1");
		glMasterVo.setRegiDt(StringUtil.currentDateString("yyyyMMdd"));
		glMasterVo.setRegiTm(StringUtil.currentDateString("hhmmss"));

		interfaceLogService.insertInterfaceLog(glMasterVo);
		return glMasterDao.saveGlMaster(glMasterVo);
	}

	// READ ONE By key
	public GlMasterVo readByActgTrDtAndActgTrSrno(String actgTrDt, long actgTrSrno){

		GlMasterVo glMasterVo = glMasterDao.findOneGlMaster(actgTrDt, actgTrSrno);
		if (glMasterVo == null) {
			throw new NotFoundException(actgTrDt+", "+ actgTrSrno);
		}		
		return glMasterVo;
	}	
	
	// READ One BY REFNO and staTcd
	public GlMasterVo readByRefNo(String refNo, String statTcd){
		
		GlMasterVo vo = glMasterDao.findOneRefNoAndStatTcd(refNo, statTcd);
		
		if (vo==null){
			throw new NotFoundException(refNo);
		}		

		return vo;
	}
	public List<GlMasterVo> searchListGlMaster(String startDate, String endDate, String refNo){
		List<GlMasterVo> glGlMasterVoList = glMasterDao.searchListGlMaster(startDate,endDate,refNo);
		return glGlMasterVoList;
	}
	
	
	// READ MAX actTrSrno
	public long getMaxActTrSrno(){

		String actgTrDt = StringUtil.currentDateString("yyyyMMdd");
		GlMasterVo tmpVo = glMasterDao.findTop1ByActgTrDtOrderByActgTrSrnoDesc(actgTrDt);
		if(tmpVo==null){
			return 1;
		}
		return tmpVo.getActgTrSrno()+1;
	}
	
	// UPDATE
	public int updateGlMaster(String refNo, String statTcd){
		
		GlMasterVo glMasterVo = glMasterDao.findOneRefNoAndStatTcd(refNo, statTcd);
		
		if (glMasterVo==null){
			throw new NotFoundException("Gl Master Not found ["+refNo+"] ["+statTcd+"]");
		}		
		
		String today = StringUtil.currentDateString("yyyyMMdd");
		if(!glMasterVo.getActgTrDt().equals(today)){
			throw new NotValidException("취소는 당일 거래만 가능합니다. 거래일자:["+glMasterVo.getActgTrDt()+"]");
		}
		
		glMasterVo.setStatTcd("9");
		
		return glMasterDao.saveGlMaster(glMasterVo);
	}
	
}
