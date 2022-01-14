package com.sennet.accounting;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sennet.common.StringUtil;
import com.sennet.exception.DuplicatedException;
import com.sennet.exception.NotFoundException;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class GlDetailService {

	@Autowired
	private GlDetailDao glDetailDao;

	@Autowired
	private GlCodeService glCodeService;
	@Autowired
	private ModelMapper modelMapper;
	
	// CREATE
	public int insertGlDetail(GlDetailVo paramVo) {

		GlDetailVo glDetailVo = modelMapper.map(paramVo, GlDetailVo.class);
		
		String actgTrDt = glDetailVo.getActgTrDt();
		long actgTrSrno = glDetailVo.getActgTrSrno();
		long actgTrSubSrno = glDetailVo.getActgTrSubSrno();

		GlDetailVo tmpVo = glDetailDao.findOneGlDetail(actgTrDt, actgTrSrno, actgTrSubSrno);
		if (tmpVo != null) {
			log.error("acsjCd, actgTrSrno, actgTrSubSrno duplicated exception. {}", actgTrDt, actgTrSrno, actgTrSubSrno);
			throw new DuplicatedException(actgTrDt+", "+ actgTrSrno +", "+ actgTrSubSrno);
		}
		glDetailVo.setActgTrDt(StringUtil.currentDateString("yyyyMMdd"));
		glDetailVo.setActgTrSrno(paramVo.getActgTrSrno());
		glDetailVo.setActgTrSubSrno(paramVo.getActgTrSubSrno());
		glDetailVo.setBrno(paramVo.getBrno());
		glDetailVo.setOppBrno(paramVo.getOppBrno());
		glDetailVo.setCrdrTcd(paramVo.getCrdrTcd());
		glDetailVo.setCurrCd(paramVo.getCurrCd());
		glDetailVo.setBasicRate(paramVo.getBasicRate());
		glDetailVo.setExrRate(paramVo.getExrRate());
		glDetailVo.setAcctCd(paramVo.getAcctCd());
		glDetailVo.setFrc(paramVo.getFrc());
		glDetailVo.setWon(paramVo.getWon());
		glDetailVo.setPosiYn(paramVo.getPosiYn());
		glDetailVo.setBankCd(paramVo.getBankCd());
		glDetailVo.setRowNo(paramVo.getRowNo());
		
		return glDetailDao.saveGlDetail(glDetailVo);
	}

	// READ One
	public GlDetailVo readByActgTrDtAndActgTrSrnoAndActgTrSubSrno(String actgTrDt, long actgTrSrno, long actgTrSubSrno){

		GlDetailVo glDetailVo = glDetailDao.findOneGlDetail(actgTrDt, actgTrSrno, actgTrSubSrno);
		if (glDetailVo == null) {
			throw new NotFoundException(actgTrDt+", "+ actgTrSrno +", "+ actgTrSubSrno);
		}		
		return glDetailVo;
	}	
	
	// READ ALL BY actgTrDt, actgTrSrno
	public List<GlDetailVo>findByActgTrDtAndActgTrSrnoOrderByActgTrSubSrnoAsc(String actgTrDt, long actgTrSrno){

		List<GlDetailVo> list = glDetailDao.findByActgTrDtAndActgTrSrnoOrderByActgTrSubSrnoAsc(actgTrDt, actgTrSrno);
		if (list.size() == 0){
			throw new NotFoundException(actgTrDt+", "+ actgTrSrno);
		}		
		return list;
	}
	
	List<GlDetailVo> allGlDetailList;
	
	
	public List<GlDetailJournalizeVo> getGlDetailList(String actgTrDt, long actgTrSrno){
		List<GlDetailVo> glDetailVoList = glDetailDao.findByActgTrDtAndActgTrSrnoOrderByActgTrSubSrnoAsc(actgTrDt, actgTrSrno);
		return this.getGlDetailList(glDetailVoList);
	}
	
	public List<GlDetailJournalizeVo> getGlDetailList(List<GlDetailVo> allGlDetail){
		
		List<GlDetailJournalizeVo> list = new ArrayList<GlDetailJournalizeVo>();
		GlDetailJournalizeVo glDetailList;
		GlDetailVo glDetailVo;

		// 마지막 데이터의 rowNo 를 가져와서 리스트 사이즈를 정한다.
		int maxRowNo = allGlDetail.get(allGlDetail.size()-1).getRowNo();
		
		for(int i=0; i<maxRowNo; i++){
			glDetailList = new GlDetailJournalizeVo();
			list.add(glDetailList);
		}
		
		int idx=0;
		Iterator<GlDetailVo> itr = allGlDetail.iterator();
		while(itr.hasNext()){
			
			glDetailVo = itr.next();
			
			idx = glDetailVo.getRowNo()-1;

			list.get(idx).setActgTrDt(glDetailVo.getActgTrDt());
			list.get(idx).setActgTrSrno(glDetailVo.getActgTrSrno());
			list.get(idx).setBrno(glDetailVo.getBrno());
			list.get(idx).setOppBrno(glDetailVo.getOppBrno());
			list.get(idx).setRowNo(glDetailVo.getRowNo());
			list.get(idx).setBankCd(glDetailVo.getBankCd());
			list.get(idx).setBasicRate(glDetailVo.getBasicRate());
			list.get(idx).setExrRate(glDetailVo.getExrRate());
			list.get(idx).setPosiYn(getPosiYn(glDetailVo.getPosiYn()));
			
			if(glDetailVo.getCrdrTcd().equalsIgnoreCase("D")){
				
				list.get(idx).setDCurrCd(glDetailVo.getCurrCd());
				list.get(idx).setDAcctCd(glCodeService.getAcsjNm(glDetailVo.getAcctCd()));
				list.get(idx).setDFrc(getAmt(glDetailVo.getFrc()));
				list.get(idx).setDWon(getAmt(glDetailVo.getWon()));
				
			}else
			if(glDetailVo.getCrdrTcd().equalsIgnoreCase("C")){

				list.get(idx).setCCurrCd(glDetailVo.getCurrCd());
				list.get(idx).setCAcctCd(glCodeService.getAcsjNm(glDetailVo.getAcctCd()));
				list.get(idx).setCFrc(getAmt(glDetailVo.getFrc()));
				list.get(idx).setCWon(getAmt(glDetailVo.getWon()));
			}
		}
		return list;
	}
	
	private String getPosiYn(String posiYn){
		
		if(posiYn!=null && posiYn.equalsIgnoreCase("Y")){
			return "포지션";
		}else{
			return "대체";
		}
	}
	
	private BigDecimal getAmt(BigDecimal amt){
		
		if(amt==null){
			return BigDecimal.ZERO;
		}else
			return amt;
	
	}
}
