package com.sennet.accounting.bs;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sennet.common.StringUtil;
import com.sennet.exception.NotFoundException;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class BsService {
	@Autowired
	private ModelMapper modelMapper;
	@Autowired
	BsDao bsDao;
	
	// Insert
	public int insertBs(BsVo paramVo) {
		BsVo bsVo = modelMapper.map(paramVo, BsVo.class);
		BsVo findBsVo = bsDao.findOneBs(bsVo.getActgTrDt(),bsVo.getBrno(), bsVo.getAcsjCd(),bsVo.getCurrCd());
		if (findBsVo !=null) {
			bsVo.setActgTrDt(StringUtil.currentDateString("yyyyMMdd"));
			bsVo.setBrno(findBsVo.getBrno());
			bsVo.setAcsjCd(findBsVo.getAcsjCd());
			bsVo.setCurrCd(findBsVo.getCurrCd());
			bsVo.setPosiCrCnt(findBsVo.getPosiCrCnt()+paramVo.getPosiCrCnt());
			bsVo.setPosiCrFrc(findBsVo.getPosiCrFrc().add(paramVo.getPosiCrFrc()));
			bsVo.setPosiCrWon(findBsVo.getPosiCrWon().add(paramVo.getPosiCrWon()));
			bsVo.setPosiDrCnt(findBsVo.getPosiDrCnt()+paramVo.getPosiDrCnt());
			bsVo.setPosiDrFrc(findBsVo.getPosiDrFrc().add(paramVo.getPosiDrFrc()));
			bsVo.setPosiDrWon(findBsVo.getPosiDrWon().add(paramVo.getPosiDrWon()));
			bsVo.setAltCrCnt(findBsVo.getAltCrCnt()+paramVo.getAltCrCnt());
			bsVo.setAltCrFrc(findBsVo.getAltCrFrc().add(paramVo.getAltCrFrc()));
			bsVo.setAltCrWon(findBsVo.getAltCrWon().add(paramVo.getAltCrWon()));
			bsVo.setAltDrCnt(findBsVo.getAltDrCnt()+paramVo.getAltDrCnt());
			bsVo.setAltDrFrc(findBsVo.getAltDrFrc().add(paramVo.getAltDrFrc()));
			bsVo.setAltDrWon(findBsVo.getAltDrWon().add(paramVo.getAltDrWon()));
			bsVo.setCnclPosiCrCnt(findBsVo.getCnclPosiCrCnt()+paramVo.getCnclPosiCrCnt());
			bsVo.setCnclPosiCrFrc(findBsVo.getCnclPosiCrFrc().add(paramVo.getCnclPosiCrFrc()));
			bsVo.setCnclPosiCrWon(findBsVo.getCnclPosiCrWon().add(paramVo.getCnclPosiCrWon()));
			bsVo.setCnclPosiDrCnt(findBsVo.getCnclPosiDrCnt()+paramVo.getCnclPosiDrCnt());
			bsVo.setCnclPosiDrFrc(findBsVo.getCnclPosiDrFrc().add(paramVo.getCnclPosiDrFrc()));
			bsVo.setCnclPosiDrWon(findBsVo.getCnclPosiDrWon().add(paramVo.getCnclPosiDrWon()));
			bsVo.setCnclAltCrCnt(findBsVo.getCnclAltCrCnt()+paramVo.getCnclAltCrCnt());
			bsVo.setCnclAltCrFrc(findBsVo.getCnclAltCrFrc().add(paramVo.getCnclAltCrFrc()));
			bsVo.setCnclAltCrWon(findBsVo.getCnclAltCrWon().add(paramVo.getCnclAltCrWon()));
			bsVo.setCnclAltDrCnt(findBsVo.getCnclAltDrCnt()+paramVo.getCnclAltDrCnt());
			bsVo.setCnclAltDrFrc(findBsVo.getCnclAltDrFrc().add(paramVo.getCnclAltDrFrc()));
			bsVo.setCnclAltDrWon(findBsVo.getCnclAltDrWon().add(paramVo.getCnclAltDrWon()));
			
		}else{
			// 전날 잔액 가져오기
			List<BsResponseVo> bsResponseList = getDybfBala(paramVo);
			BigDecimal frc = BigDecimal.ZERO;
			BigDecimal won = BigDecimal.ZERO;
			if(bsResponseList.size()>0){
				if(bsResponseList.get(0).getFrc()!=null){
					frc = new BigDecimal(bsResponseList.get(0).getFrc());
				}
				if(bsResponseList.get(0).getWon()!=null){
					won = new BigDecimal(bsResponseList.get(0).getWon());
				}
			}
			bsVo.setActgTrDt(StringUtil.currentDateString("yyyyMMdd"));
			bsVo.setBrno(paramVo.getBrno());
			bsVo.setAcsjCd(paramVo.getAcsjCd());
			bsVo.setCurrCd(paramVo.getCurrCd());
			bsVo.setDybfFrcBala(frc);
			bsVo.setDybfWonBala(won);
			bsVo.setPosiCrCnt(paramVo.getPosiCrCnt());
			bsVo.setPosiCrFrc(paramVo.getPosiCrFrc());
			bsVo.setPosiCrWon(paramVo.getPosiCrWon());
			bsVo.setPosiDrCnt(paramVo.getPosiDrCnt());
			bsVo.setPosiDrFrc(paramVo.getPosiDrFrc());
			bsVo.setPosiDrWon(paramVo.getPosiDrWon());
			bsVo.setAltCrCnt(paramVo.getAltCrCnt());
			bsVo.setAltCrFrc(paramVo.getAltCrFrc());
			bsVo.setAltCrWon(paramVo.getAltCrWon());
			bsVo.setAltDrCnt(paramVo.getAltDrCnt());
			bsVo.setAltDrFrc(paramVo.getAltDrFrc());
			bsVo.setAltDrWon(paramVo.getAltDrWon());
			bsVo.setCnclPosiCrCnt(paramVo.getCnclPosiCrCnt());
			bsVo.setCnclPosiCrFrc(paramVo.getCnclPosiCrFrc());
			bsVo.setCnclPosiCrWon(paramVo.getCnclPosiCrWon());
			bsVo.setCnclPosiDrCnt(paramVo.getCnclPosiDrCnt());
			bsVo.setCnclPosiDrFrc(paramVo.getCnclPosiDrFrc());
			bsVo.setCnclPosiDrWon(paramVo.getCnclPosiDrWon());
			bsVo.setCnclAltCrCnt(paramVo.getCnclAltCrCnt());
			bsVo.setCnclAltCrFrc(paramVo.getCnclAltCrFrc());
			bsVo.setCnclAltCrWon(paramVo.getCnclAltCrWon());
			bsVo.setCnclAltDrCnt(paramVo.getCnclAltDrCnt());
			bsVo.setCnclAltDrFrc(paramVo.getCnclAltDrFrc());
			bsVo.setCnclAltDrWon(paramVo.getCnclAltDrWon());
		}
		log.info("등록 bs : {}", bsVo.toString());		
		return bsDao.insertBs(bsVo);
	}
	// 전날잔액 가져오기
	private List<BsResponseVo> getDybfBala(BsVo paramVo){

		BsVo bsVo = new BsVo();
		bsVo.setAcsjCd(paramVo.getAcsjCd());
		bsVo.setActgTrDt(StringUtil.currentDateString("yyyyMMdd"));
		bsVo.setBrno(paramVo.getBrno());
		bsVo.setCurrCd(paramVo.getCurrCd());
		return bsDao.findLastBs(bsVo);
	}
	
	// READ Response List
	public List<BsResponseVo> searchListBs(String actgTrDt, String brno) {
		BsVo bsVo = new BsVo();
		bsVo.setActgTrDt(actgTrDt);
		bsVo.setBrno(brno);
		List<BsResponseVo> bsResponseList = bsDao.searchListBs(bsVo);;
		return bsResponseList;
	}	
	public List<BsResponseSumVo> readAllSum(String actgTrDt,String brno){
    	BsVo bsVo = new BsVo();
    	bsVo.setActgTrDt(actgTrDt);
    	bsVo.setBrno(brno);
        return bsDao.findBsSumList(bsVo);

	}
	
}
