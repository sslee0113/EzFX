package com.sennet.accounting;

import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sennet.accounting.bs.BsService;
import com.sennet.accounting.bs.BsVo;
import com.sennet.common.StringUtil;
import com.sennet.exchange.ExchangeService;
import com.sennet.remittance.RemittanceService;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class AccountingCnclPrcService {
	
	@Autowired
    private GlMasterService glMasterService;
	
	@Autowired
	private GlDetailService glDetailService;
	
	@Autowired
	BsService bsService;

	private final String NORMAL="1"; // 정상

	
	/**
	 * 1. 회계원장 읽어오기
	 * 2. 회계원장 마스터원장 업데이트
	 * 3. 회계원장 마스터 생성
	 * 4. 모든 금액을 마이너스로 회계원장 서브 생성
	 * 
	 * @param refNo
	 * @throws Exception
	 */
	public void cnclProc(String refNo) throws Exception{
		
		// 1. 회계원장 읽어오기
		GlMasterVo vo = this.glMasterService.readByRefNo(refNo, this.NORMAL);
		List<GlDetailVo> glDetailVoList = this.glDetailService.findByActgTrDtAndActgTrSrnoOrderByActgTrSubSrnoAsc(vo.getActgTrDt(), vo.getActgTrSrno());
		
		// 2. 회계원장 마스터원장 업데이트
		glMasterService.updateGlMaster(refNo, this.NORMAL);
		
		// 3. 회계원장 마스터 생성
		long actgTrSrno = glMasterService.getMaxActTrSrno();
		this.insertGlMaster(vo, actgTrSrno);
		
		// 4. 모든 금액을 마이너스로 회계원장 서브 생성
		GlDetailVo glDetailVo;
		GlDetailVo detailNewVo;
		Iterator<GlDetailVo> itr = glDetailVoList.iterator();
		BigDecimal minus = new BigDecimal("-1");
		int row=0;

		while(itr.hasNext()){
			row++;
			glDetailVo = itr.next();
			detailNewVo = new GlDetailVo();
			detailNewVo.setActgTrDt(StringUtil.currentDateString("yyyyMMdd"));
			detailNewVo.setActgTrSrno(actgTrSrno);
			detailNewVo.setActgTrSubSrno(row);
			detailNewVo.setBrno(glDetailVo.getBrno());
			detailNewVo.setOppBrno(glDetailVo.getOppBrno());
			detailNewVo.setCrdrTcd(glDetailVo.getCrdrTcd());
			detailNewVo.setCurrCd(glDetailVo.getCurrCd());
			detailNewVo.setBasicRate(glDetailVo.getBasicRate());
			detailNewVo.setExrRate(glDetailVo.getExrRate());
			detailNewVo.setAcctCd(glDetailVo.getAcctCd());
			detailNewVo.setFrc(glDetailVo.getFrc().multiply(minus)); // -1 을 곱해서 마이너스 금액으로 만든다.
			detailNewVo.setWon(glDetailVo.getWon().multiply(minus)); // -1 을 곱해서 마이너스 금액으로 만든다.
			detailNewVo.setPosiYn(glDetailVo.getPosiYn());
			detailNewVo.setBankCd(glDetailVo.getBankCd());
			detailNewVo.setRowNo(glDetailVo.getRowNo());

			glDetailService.insertGlDetail(detailNewVo);
		
			// BS 잔액 생성
			if(!detailNewVo.getCurrCd().equalsIgnoreCase("KRW")){
				// BS 잔액 생성
				bsService.insertBs(getBsOfGlDetail(detailNewVo));
				// 포지션 Y 경우에는 포지션 (29101000) 으로 한번 더 처리한다.
				if(detailNewVo.getPosiYn().equalsIgnoreCase("Y")){
					detailNewVo.setAcctCd("29101000");
					detailNewVo.setCrdrTcd(reverseCrdrTcd(detailNewVo.getCrdrTcd()));
					// BS 잔액 생성
					bsService.insertBs(getBsOfGlDetail(detailNewVo));
				}
			}
		}
	}
	private void insertGlMaster(GlMasterVo paramVo, long actgTrSrno) throws Exception{
        GlMasterVo glMasterVo = new GlMasterVo();
        glMasterVo.setActgTrDt(StringUtil.currentDateString("yyyyMMdd"));
        glMasterVo.setActgTrSrno(actgTrSrno);
        glMasterVo.setBzTcd(paramVo.getBzTcd());
        glMasterVo.setRefNo(paramVo.getRefNo());
        glMasterVo.setPrcTcd("9");			// 1-정상 8-취소대응 9-취소
        glMasterVo.setOrgActgTrDt(paramVo.getActgTrDt());
        glMasterVo.setOrgActgTrSrno(paramVo.getActgTrSrno());
        glMasterVo.setStatTcd("1");		// 1-정상 9-취소
        glMasterVo.setRegiDt(StringUtil.currentDateString("yyyyMMdd"));
        glMasterVo.setRegiTm(StringUtil.currentDateString("hhmmss"));
		this.glMasterService.insertGlMaster(glMasterVo);
	}

	private BsVo getBsOfGlDetail(GlDetailVo paramVo){
		BsVo bsVo = new BsVo();
		// 포지션 Y & KRW 인 경우에는 포지션 (29101000) 으로 처리한다.
		bsVo.setActgTrDt(StringUtil.currentDateString("yyyyMMdd"));
		bsVo.setBrno(paramVo.getBrno());
		bsVo.setAcsjCd(paramVo.getAcctCd());
		bsVo.setCurrCd(paramVo.getCurrCd());
		// 0 으로 초기화
		bsVo.setDybfFrcBala(BigDecimal.ZERO);
		bsVo.setDybfWonBala(BigDecimal.ZERO);
		bsVo.setPosiCrCnt(0);
		bsVo.setPosiCrFrc(BigDecimal.ZERO);
		bsVo.setPosiCrWon(BigDecimal.ZERO);
		bsVo.setAltCrCnt(0);
		bsVo.setAltCrFrc(BigDecimal.ZERO);
		bsVo.setAltCrWon(BigDecimal.ZERO);
		bsVo.setPosiDrCnt(0);
		bsVo.setPosiDrFrc(BigDecimal.ZERO);
		bsVo.setPosiDrWon(BigDecimal.ZERO);
		bsVo.setAltDrCnt(0);
		bsVo.setAltDrFrc(BigDecimal.ZERO);
		bsVo.setAltDrWon(BigDecimal.ZERO);
		bsVo.setCnclPosiCrCnt(0);
		bsVo.setCnclPosiCrFrc(BigDecimal.ZERO);
		bsVo.setCnclPosiCrWon(BigDecimal.ZERO);
		bsVo.setCnclPosiDrCnt(0);
		bsVo.setCnclPosiDrFrc(BigDecimal.ZERO);
		bsVo.setCnclPosiDrWon(BigDecimal.ZERO);
		bsVo.setCnclAltCrCnt(0);
		bsVo.setCnclAltCrFrc(BigDecimal.ZERO);
		bsVo.setCnclAltCrWon(BigDecimal.ZERO);
		bsVo.setCnclAltDrCnt(0);
		bsVo.setCnclAltDrFrc(BigDecimal.ZERO);
		bsVo.setCnclAltDrWon(BigDecimal.ZERO);

		// 지정된 값 셋팅
		if(paramVo.getCrdrTcd().equalsIgnoreCase("C")){
			if(paramVo.getPosiYn().equalsIgnoreCase("Y")){
				bsVo.setCnclPosiCrCnt(1);
				bsVo.setCnclPosiCrFrc(paramVo.getFrc().abs());
				bsVo.setCnclPosiCrWon(paramVo.getWon().abs());
			}else{
				bsVo.setCnclAltCrCnt(1);
				bsVo.setCnclAltCrFrc(paramVo.getFrc().abs());
				bsVo.setCnclAltCrWon(paramVo.getWon().abs());
			}
		}else{
			if(paramVo.getPosiYn().equalsIgnoreCase("Y")){
				bsVo.setCnclPosiDrCnt(1);
				bsVo.setCnclPosiDrFrc(paramVo.getFrc().abs());
				bsVo.setCnclPosiDrWon(paramVo.getWon().abs());
			}else{
				bsVo.setCnclAltDrCnt(1);
				bsVo.setCnclAltDrFrc(paramVo.getFrc().abs());
				bsVo.setCnclAltDrWon(paramVo.getWon().abs());
			}
		}
		return bsVo;
	}
	
	private String reverseCrdrTcd(String crdrTcd){
		if(crdrTcd!=null && crdrTcd.equals("C")){
			return "D";
		}else
		if(crdrTcd!=null && crdrTcd.equals("D")){
			return "C";
		}
		
		return "";
	}
}
