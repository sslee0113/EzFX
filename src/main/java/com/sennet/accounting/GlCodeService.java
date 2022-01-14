package com.sennet.accounting;

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
public class GlCodeService {

	@Autowired
	private GlCodeDao glCodeDao;

	@Autowired
	private ModelMapper modelMapper;
	
	public int insertGlCode(GlCodeVo paramGlCodeVo) {

		GlCodeVo glCodeVo = modelMapper.map(paramGlCodeVo, GlCodeVo .class);
		String acsjCd = glCodeVo.getAcsjCd();
		// 기존 데이터가 존재할 시 PK 값을 제외한 다른 값을 업데이트한다.
		GlCodeVo GlCodeVo = glCodeDao.findOneGlCode(acsjCd);
		if (GlCodeVo != null) {
			log.error("acsjCd duplicated exception. {}", acsjCd);
			throw new DuplicatedException(acsjCd);
		}
	
		glCodeVo.setAcsjCd(paramGlCodeVo.getAcsjCd());
		glCodeVo.setAcsjNm(paramGlCodeVo.getAcsjNm());
		glCodeVo.setAcsjGrp(paramGlCodeVo.getAcsjGrp());
		glCodeVo.setHostAcsjCd(paramGlCodeVo.getHostAcsjCd());
		glCodeVo.setBokAcsjTcd(paramGlCodeVo.getBokAcsjTcd());
		glCodeVo.setAcsjOputNm(paramGlCodeVo.getAcsjOputNm());
		glCodeVo.setAstDbtTcd(paramGlCodeVo.getAstDbtTcd());
		glCodeVo.setEvSbjTcd(paramGlCodeVo.getEvSbjTcd());
		glCodeVo.setAstDbtYn(paramGlCodeVo.getAstDbtYn());
		glCodeVo.setOnlnTcd(paramGlCodeVo.getOnlnTcd());
		// 0-정상, 9-취소
		glCodeVo.setStatTcd("0");
		glCodeVo.setQryYn(paramGlCodeVo.getQryYn());
		glCodeVo.setQrySqn(paramGlCodeVo.getQrySqn());
		glCodeVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
		glCodeVo.setLastTime(StringUtil.currentDateString("HHmmss"));
		glCodeVo.setLastUser(paramGlCodeVo.getLastUser());

		log.info("등록 GlCodeVo : {}", glCodeVo.toString());		
		return glCodeDao.saveGlCode(glCodeVo);
	}

	
	// UPDATE
	public int update(String acsjCd, GlCodeVo paramGlCodeVo) {
		GlCodeVo glCodeVo = readByAcsjCd(acsjCd);
		glCodeVo.setAcsjNm(paramGlCodeVo.getAcsjNm());
		glCodeVo.setAcsjGrp(paramGlCodeVo.getAcsjGrp());
		glCodeVo.setHostAcsjCd(paramGlCodeVo.getHostAcsjCd());
		glCodeVo.setBokAcsjTcd(paramGlCodeVo.getBokAcsjTcd());
		glCodeVo.setAcsjOputNm(paramGlCodeVo.getAcsjOputNm());
		glCodeVo.setAstDbtTcd(paramGlCodeVo.getAstDbtTcd());
		glCodeVo.setEvSbjTcd(paramGlCodeVo.getEvSbjTcd());
		glCodeVo.setAstDbtYn(paramGlCodeVo.getAstDbtYn());
		glCodeVo.setOnlnTcd(paramGlCodeVo.getOnlnTcd());
		glCodeVo.setStatTcd(paramGlCodeVo.getStatTcd());
		glCodeVo.setQryYn(paramGlCodeVo.getQryYn());
		glCodeVo.setQrySqn(paramGlCodeVo.getQrySqn());
		glCodeVo.setLastDate(StringUtil.currentDateString("yyyyMMdd"));
		glCodeVo.setLastTime(StringUtil.currentDateString("HHmmss"));
		glCodeVo.setLastUser(paramGlCodeVo.getLastUser());
		return glCodeDao.saveGlCode(glCodeVo);
	}
	// getAcsjNm BY AcsjCd
	public String getAcsjNm(String acsjCd){
		GlCodeVo glCodeVo = glCodeDao.findOneGlCode(acsjCd);
		if (glCodeVo == null) {
			throw new NotFoundException(acsjCd);
		}		
		return glCodeVo.getAcsjNm();
	}	
	// GlCodeVo BY AcsjCd
	public GlCodeVo readByAcsjCd(String acsjCd){
		GlCodeVo glCodeVo = glCodeDao.findOneGlCode(acsjCd);
		if (glCodeVo == null) {
			throw new NotFoundException(acsjCd);
		}		
		return glCodeVo;
	}	
	// DELETE
	public int delete(String acsjCd) {
		GlCodeVo glCodeVo = readByAcsjCd(acsjCd);
		glCodeVo.setStatTcd("9");
		log.info("삭제 GlCodeVo : {}", glCodeVo.toString());		
		return glCodeDao.saveGlCode(glCodeVo);
		
	}
	// READ BY AcsjCd
	public List<GlCodeVo> searchListGlCode(String acsjCd,String acsjNm){
	    List<GlCodeVo> glCodeList = glCodeDao.selectListGlCode(acsjCd,acsjNm);
		if (glCodeList == null|| glCodeList.size()==0 ) {
			throw new NotFoundException(acsjCd);
		}		
		return glCodeList;
	}	

	
}
