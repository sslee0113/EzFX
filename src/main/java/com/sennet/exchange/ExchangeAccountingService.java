package com.sennet.exchange;

import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sennet.accounting.AccountingDetailVo;
import com.sennet.accounting.AccountingPrcService;
import com.sennet.accounting.AccountingVo;
import com.sennet.accounting.GlDetailService;
import com.sennet.accounting.GlDetailVo;
import com.sennet.accounting.GlMasterService;
import com.sennet.accounting.GlMasterVo;
import com.sennet.accounting.bs.BsService;
import com.sennet.accounting.bs.BsVo;
import com.sennet.bizcommon.currency.CurrencyService;
import com.sennet.bizcommon.currency.CurrencyVo;
import com.sennet.bizcommon.frgnexchrate.FrgnExchRateService;
import com.sennet.bizcommon.frgnexchrate.FrgnExchRateVo;
import com.sennet.common.AmountCalcUtil;
import com.sennet.common.StringUtil;
import com.sennet.exception.NotValidException;

import lombok.extern.slf4j.Slf4j;

@Service
//@Transactional
@Slf4j
public class ExchangeAccountingService {

	@Autowired
	CurrencyService currencyService;

	@Autowired
	FrgnExchRateService frgnExchRateService;
	
	@Autowired
	AccountingPrcService accountingPrc;

	@Autowired
	GlMasterService glMasterService;

	@Autowired
	GlDetailService glDetailService;

	@Autowired
	BsService bsService;
	
	
	public int procExchange(ExchangeVo paramExchageVo, String refNo) throws Exception{
		
		String bic = "CITICIAXXXX";
		
		// 공통적인 기본 값을 셋팅한다.
		AccountingVo accountingVo;
		
		String today = StringUtil.currentDateString("yyyyMMdd");
		// 환율정보
		FrgnExchRateVo frgnExchRateVo = frgnExchRateService.getFrgnExchRateVo(today, paramExchageVo.getCrcd());
		
		// 입력정보로 현재 환율회차 정보로 새로 계산한다.
		String crcd = paramExchageVo.getCrcd();  // 통화코드
		BigDecimal prmRt = paramExchageVo.getPrmRt();  
		BigDecimal pmnyAmt = paramExchageVo.getPmnyAmt();
		BigDecimal cnAmt = paramExchageVo.getCnAmt();
		String efmDscd = paramExchageVo.getEfmDscd(); // 환전구분코드

		
		ExchangeVo newExchangeVo;
		long actgTrSrno = glMasterService.getMaxActTrSrno();
		long actgTrSubSrno = 1;
		int row=1;
		
		try{

			newExchangeVo = this.calcExchange(crcd, prmRt, pmnyAmt, cnAmt, efmDscd);
			// GlMaster 데이터 생성
			accountingVo = setBasicData(paramExchageVo);
			actgTrSrno = createGlMaster(actgTrSrno, refNo);
			// GlDetail 데이터 생성
			if(newExchangeVo.getPmnyFrgAmt()!=null && newExchangeVo.getPmnyFrgAmt().compareTo(BigDecimal.ZERO)>0){
				/**
				 * 현찰 계정처리
				 */
				accountingVo = setBasicData(paramExchageVo);
				// 거래외화금액
				accountingVo.setTrFrc(newExchangeVo.getPmnyFrgAmt());
				// 환율회차
				accountingVo.setQuotSeq(frgnExchRateVo.getQuotSeq());
				// 매매기준율
				accountingVo.setMidRate(frgnExchRateVo.getMidRate());
				// 고시환율
				accountingVo.setQuotRate(frgnExchRateVo.getMidRate());
				// 우대율
				accountingVo.setPrmRt(paramExchageVo.getPrmRt());
				// 적용환율
				accountingVo.setAplyRate(newExchangeVo.getPmnyAplExrt());
				// 매매원화금액
				accountingVo.setDlnWna(AmountCalcUtil.getStlmWna(paramExchageVo.getPmnyFrgAmt(), frgnExchRateVo.getMidRate()));
				// 적용원화금액
				accountingVo.setAplyWna(newExchangeVo.getPmnyStlmWna());
				// 매매손익원화금액
				accountingVo.setDlnPlWna(newExchangeVo.getPmnyDlnPlWna());
				// 포지션외화금액
				accountingVo.setPosiFrc(newExchangeVo.getPmnyFrgAmt());

				// 포지션원화금액
				accountingVo.setPosiWna(accountingVo.getDlnWna());

				accountingVo.setBic(bic);

				List<AccountingDetailVo> pmnyList = accountingPrc.proc(accountingVo, row);
				
				// DB insert
				creatGlDetail(pmnyList, accountingVo, actgTrSrno, actgTrSubSrno);
				
				actgTrSubSrno = pmnyList.size()+1;
				
				row = pmnyList.get(pmnyList.size()-1).getRow()+1;
			}
			
			if(newExchangeVo.getCnFrgAmt()!=null && newExchangeVo.getCnFrgAmt().compareTo(BigDecimal.ZERO)>0){
				/**
				 * 주화 계정처리
				 */
				accountingVo = setBasicData(paramExchageVo);
				// 거래외화금액
				accountingVo.setTrFrc(newExchangeVo.getCnFrgAmt());
				// 환율회차
				accountingVo.setQuotSeq(frgnExchRateVo.getQuotSeq());
				// 매매기준율
				accountingVo.setMidRate(frgnExchRateVo.getMidRate());
				// 고시환율
				accountingVo.setQuotRate(frgnExchRateVo.getMidRate());
				// 우대율
				accountingVo.setPrmRt(paramExchageVo.getPrmRt());
				// 적용환율
				accountingVo.setAplyRate(newExchangeVo.getCnAplExrt());
				// 매매원화금액
				accountingVo.setDlnWna(AmountCalcUtil.getStlmWna(paramExchageVo.getCnFrgAmt(), frgnExchRateVo.getMidRate()));
				// 적용원화금액
				accountingVo.setAplyWna(newExchangeVo.getCnStlmWna());
				// 매매손익원화금액
				accountingVo.setDlnPlWna(newExchangeVo.getCnDlnPlWna());
				// 포지션외화금액
				accountingVo.setPosiFrc(newExchangeVo.getCnFrgAmt());
				// 포지션원화금액
				accountingVo.setPosiWna(accountingVo.getDlnWna());
				
				accountingVo.setBic(bic);

				List<AccountingDetailVo> cnList = accountingPrc.proc(accountingVo, row);
				// DB insert
				creatGlDetail(cnList, accountingVo, actgTrSrno, actgTrSubSrno);
			}

		}catch(Exception e){
			throw e;
		}
		return 1;
	}	
	
	/**
	 * 통화에 대한 고시환율, 우대율을 사용하여 지폐 및 주화 금액에 대한 원화금액과 거래이익을 계산해온다.
	 */
	public ExchangeVo preCalc(String crcd, BigDecimal prmRt, BigDecimal pmnyAmt, BigDecimal cnAmt, String efmDscd) throws Exception 
	{
    	ExchangeVo reponseExchangeVo = new ExchangeVo();
    	try{
    		ExchangeVo exchangeVo = calcExchange(crcd, prmRt, pmnyAmt, cnAmt, efmDscd);
    		reponseExchangeVo.setPmnyAmt(pmnyAmt);
    		reponseExchangeVo.setPmnyExrt(exchangeVo.getPmnyExrt());
    		reponseExchangeVo.setPmnyAplExrt(exchangeVo.getPmnyAplExrt());
    		reponseExchangeVo.setPmnyDlnPlWna(exchangeVo.getPmnyDlnPlWna());
    		reponseExchangeVo.setPmnyStlmWna(exchangeVo.getPmnyStlmWna());
    		reponseExchangeVo.setCnAmt(cnAmt);
    		reponseExchangeVo.setCnExrt(exchangeVo.getCnExrt());
    		reponseExchangeVo.setCnAplExrt(exchangeVo.getCnAplExrt());
    		reponseExchangeVo.setCnDlnPlWna(exchangeVo.getCnDlnPlWna());
    		reponseExchangeVo.setCnStlmWna(exchangeVo.getCnStlmWna()); 
    		reponseExchangeVo.setSumStlmWna(exchangeVo.getSumStlmWna());
    		reponseExchangeVo.setPrmRt(exchangeVo.getPrmRt());
    		reponseExchangeVo.setTusaTnslAmt(exchangeVo.getTusaTnslAmt());
    	}catch(Exception e){
    		throw e;
    	}
		return reponseExchangeVo;
	}
	
	/**
	 * ----------------------------------------------------------
	 *  절차
	 * ----------------------------------------------------------
	 * 1. 통화에 대한 고시환율정보를 조회한다.
	 * 2. 통화에 대한 기본정보를 가져온다.
	 * 3. 지폐 및 주화의 스프레드 값에 우대율을 곱해서 적용환율을 계산한다.
	 * 4. 계산된 적용환율로 원화금액을 계산한다.
	 * 5. 매매기준율을 사용한 원화금액과 적용환율로 계산한 원화금액의 차를 계산한다.
	 * 6. 지폐금액의 원화금액과 주화금액의 원화금액의 합계를 계산한다.
	 * 7. 대미환산금액을 계산한다.
	 * ----------------------------------------------------------
	 * 
	 * @param crcd 통화코드
	 * @param prmRt 우대율
	 * @param pmnyAmt 지폐금액
	 * @param cnAmt 주화금액
	 * @return 적용환율, 원화금액, 거래이익, 원화정산금액
	 */
	public ExchangeVo calcExchange(String crcd , BigDecimal prmRt, BigDecimal pmnyAmt, BigDecimal cnAmt, String efmDscd) throws Exception {
		
		ExchangeVo exchangeVo = new ExchangeVo();
		String today = StringUtil.currentDateString("yyyyMMdd");
		// 1. 통화에 대한 고시환율정보를 조회한다.
		FrgnExchRateVo frgnExchRateVo = frgnExchRateService.getFrgnExchRateVo(today, crcd);
		// 2. 통화에 대한 기본정보를 가져온다.
		CurrencyVo currencyVo = currencyService.findOneCurrency(crcd);

		// 3. 지폐 및 주화의 스프레드 값에 우대율을 곱해서 적용환율을 계산한다.
		BigDecimal pmnyAplExrt = AmountCalcUtil.getAplExrt(frgnExchRateVo.getMidRate(), currencyVo.getBasicSprdRate(), prmRt, crcd, efmDscd);
		BigDecimal cnAplExrt = AmountCalcUtil.getAplExrt(frgnExchRateVo.getMidRate(), currencyVo.getCoinSprdRate(), prmRt, crcd, efmDscd);

		// 4. 계산된 적용환율로 원화금액을 계산한다.
		BigDecimal pmnyStlmWna = AmountCalcUtil.getStlmWna(pmnyAmt, pmnyAplExrt);
		BigDecimal cnStlmWna = AmountCalcUtil.getStlmWna(cnAmt, cnAplExrt);

		// 5. 매매기준율을 사용한 원화금액과 적용환율로 계산한 원화금액의 차를 계산한다.
		BigDecimal pmnyDlnPlWna = AmountCalcUtil.getDlnPlWna(pmnyAmt, frgnExchRateVo.getMidRate(), pmnyAplExrt);
		BigDecimal cnDlnPlWna = AmountCalcUtil.getDlnPlWna(cnAmt, frgnExchRateVo.getMidRate(), cnAplExrt);
		
		// 6. 지폐금액의 원화금액과 주화금액의 합계를 계산한다.
		BigDecimal sumStlmWna = AmountCalcUtil.getSumStlmWna(pmnyStlmWna, cnStlmWna);
		
		// 7. 대미환산금액을 계산한다.
		BigDecimal tusaTnslAmt = AmountCalcUtil.getTusaTnslAmt(pmnyAmt, cnAmt, frgnExchRateVo.getUsdCrosRate());

		log.info("sumStlmWna:"+sumStlmWna.toString());
		
		exchangeVo.setPmnyFrgAmt(pmnyAmt);
		exchangeVo.setPmnyExrt(frgnExchRateVo.getCashBuyRate());
		exchangeVo.setPmnyAplExrt(pmnyAplExrt);
		exchangeVo.setPmnyDlnPlWna(pmnyDlnPlWna);
		exchangeVo.setPmnyStlmWna(pmnyStlmWna);

		exchangeVo.setCnFrgAmt(cnAmt);
		exchangeVo.setCnExrt(frgnExchRateVo.getCoinBuyRate());
		exchangeVo.setCnAplExrt(cnAplExrt);
		exchangeVo.setCnDlnPlWna(cnDlnPlWna);
		exchangeVo.setCnStlmWna(cnStlmWna);
		
		exchangeVo.setSumStlmWna(sumStlmWna);
		exchangeVo.setPrmRt(prmRt);
		exchangeVo.setTusaTnslAmt(tusaTnslAmt);

		return exchangeVo;
	}
	
	
	private AccountingVo setBasicData(ExchangeVo exchangeVo){
		
		AccountingVo accountingVo = new AccountingVo();

		// 거래점코드
		accountingVo.setTrBrno(exchangeVo.getBrno());
		// 상대점코드
		accountingVo.setOpTrBrno(exchangeVo.getBrno());
		// 주계정코드
		accountingVo.setMainAcsjNm("11101000"); // 외국통화
		// 상대계정코드
		accountingVo.setOpAcsjNm("11102000");   // 원화현금
		// 매입매도구분코드
		accountingVo.setBuySellType(exchangeVo.getEfmDscd());
		// 거래통화코드
		accountingVo.setTrCrd(exchangeVo.getCrcd());
		// 우대율
		accountingVo.setPrmRt(exchangeVo.getPrmRt());
		// 포지션발생여부
		accountingVo.setPosiYn("Y");
		
		if(exchangeVo.getAltWna().compareTo(BigDecimal.ZERO)!=0){
			accountingVo.setOpAcsjNm("21102000"); // 보통예금
		}
		return accountingVo;
	}
	
	/*
	
	private Accounting setBasicData(ExchangeDto.Create create){
		
		Accounting accounting = new Accounting();

		// 거래점코드
		accounting.setTrBrno(create.getBrno());
		// 상대점코드
		accounting.setOpTrBrno(create.getBrno());
		// 주계정코드
		accounting.setMainAcsjNm("11101000"); // 외국통화
		// 상대계정코드
		accounting.setOpAcsjNm("11102000"); // 원화현금
		// 매입매도구분코드
		accounting.setBuySellType(create.getEfmDscd());
		// 거래통화코드
		accounting.setTrCrd(create.getCrcd());
		// 우대율
		accounting.setPrmRt(create.getPrmRt());
		// 포지션발생여부
		accounting.setPosiYn("Y");
		
		if(create.getAltWna().compareTo(BigDecimal.ZERO)!=0){
			accounting.setOpAcsjNm("21102000"); // 보통예금
		}
		
		return accounting;
	}
	*/
	
	private long createGlMaster(long actgTrSrno, String refNo) throws Exception
	{
		GlMasterVo glMasterVo = new GlMasterVo();
		glMasterVo.setActgTrDt(StringUtil.currentDateString("yyyyMMdd"));
		glMasterVo.setActgTrSrno(actgTrSrno);
		glMasterVo.setBzTcd("CS"); 		// OR-당발송금 CS-외국통화매매
		glMasterVo.setRefNo(refNo);
		glMasterVo.setPrcTcd("1");			// 1-정상 8-취소대응 9-취소
		glMasterVo.setOrgActgTrDt("");
		glMasterVo.setOrgActgTrSrno(0);
		
		glMasterVo.setStatTcd("1");		// 1-정상 9-취소
		glMasterVo.setRegiDt(StringUtil.currentDateString("yyyyMMdd"));
		glMasterVo.setRegiTm(StringUtil.currentDateString("hhmmss"));
		
		int effectRows = glMasterService.insertGlMaster(glMasterVo);
		if(effectRows == 1){
			return actgTrSrno;
		}
		else{
			throw new NotValidException("외화분개기본입력시 오류 "+actgTrSrno);
		}
	}
	
	private void creatGlDetail(List<AccountingDetailVo> list, AccountingVo accountingVo, long actgTrSrno, long startActgTrSubSrno){
		
		AccountingDetailVo accountingDetailVo;
		GlDetailVo glDetailVo;
		
		Iterator<AccountingDetailVo> itr = list.iterator();
		while(itr.hasNext()){
			accountingDetailVo = itr.next();
			glDetailVo = new GlDetailVo();
			glDetailVo.setActgTrDt(StringUtil.currentDateString("yyyyMMdd"));
			glDetailVo.setActgTrSrno(actgTrSrno);
			glDetailVo.setActgTrSubSrno(startActgTrSubSrno++);
			glDetailVo.setBrno(accountingVo.getTrBrno());
			glDetailVo.setOppBrno(accountingVo.getOpTrBrno());
			glDetailVo.setCrdrTcd(accountingDetailVo.getCrdrTcd());
			glDetailVo.setCurrCd(accountingDetailVo.getCrd());
			glDetailVo.setBasicRate(accountingVo.getMidRate());
			glDetailVo.setExrRate(accountingVo.getAplyRate());
			
			glDetailVo.setAcctCd(accountingDetailVo.getAcsjNm());
			glDetailVo.setFrc(accountingDetailVo.getFrc());
			glDetailVo.setWon(accountingDetailVo.getWna());
			glDetailVo.setPosiYn(accountingDetailVo.getPosiYn());
			glDetailVo.setBankCd(accountingVo.getBic());
			glDetailVo.setRowNo(accountingDetailVo.getRow());
			
			// DETAIL 생성
			glDetailService.insertGlDetail(glDetailVo);
			
			// BS 잔액 생성
			if(!glDetailVo.getCurrCd().equalsIgnoreCase("KRW")){
				
				// BS 잔액 생성
				bsService.insertBs(getBsVo(glDetailVo));

				// 포지션 Y 경우에는 포지션 (29101000) 으로 한번 더 처리한다.
				if(glDetailVo.getPosiYn().equalsIgnoreCase("Y")){
					glDetailVo.setAcctCd("29101000");
					glDetailVo.setCrdrTcd(reverseCrdrTcd(glDetailVo.getCrdrTcd()));
					// BS 잔액 생성
					bsService.insertBs(getBsVo(glDetailVo));
				}
			}
		}
	}
	
	private BsVo getBsVo(GlDetailVo glDetailVo){
		BsVo bsVo = new BsVo();
		// 포지션 Y & KRW 인 경우에는 포지션 (29101000) 으로 처리한다.
		
		bsVo.setActgTrDt(StringUtil.currentDateString("yyyyMMdd"));
		bsVo.setBrno(glDetailVo.getBrno());
		bsVo.setAcsjCd(glDetailVo.getAcctCd());
		bsVo.setCurrCd(glDetailVo.getCurrCd());
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
		if(glDetailVo.getCrdrTcd().equalsIgnoreCase("C")){
			if(glDetailVo.getPosiYn().equalsIgnoreCase("Y")){
				bsVo.setPosiCrCnt(1);
				bsVo.setPosiCrFrc(glDetailVo.getFrc());
				bsVo.setPosiCrWon(glDetailVo.getWon());
			}else{
				bsVo.setAltCrCnt(1);
				bsVo.setAltCrFrc(glDetailVo.getFrc());
				bsVo.setAltCrWon(glDetailVo.getWon());
			}
		}else{
			if(glDetailVo.getPosiYn().equalsIgnoreCase("Y")){
				bsVo.setPosiDrCnt(1);
				bsVo.setPosiDrFrc(glDetailVo.getFrc());
				bsVo.setPosiDrWon(glDetailVo.getWon());
			}else{
				bsVo.setAltDrCnt(1);
				bsVo.setAltDrFrc(glDetailVo.getFrc());
				bsVo.setAltDrWon(glDetailVo.getWon());
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
