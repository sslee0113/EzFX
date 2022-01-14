package com.sennet.remittance;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

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
import com.sennet.bizcommon.fee.FeeService;
import com.sennet.bizcommon.frgnexchrate.FrgnExchRateService;
import com.sennet.bizcommon.frgnexchrate.FrgnExchRateVo;
import com.sennet.common.AmountCalcUtil;
import com.sennet.common.StringUtil;
import com.sennet.exception.NotValidException;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class RemittanceAccountingService {

	@Autowired
	FrgnExchRateService frgnExchRateService;

	@Autowired
	AccountingPrcService accountingPrcService;

	@Autowired
	CurrencyService currencyService;

	@Autowired
	
	GlMasterService glMasterService;

	@Autowired
	GlDetailService glDetailService;

	@Autowired
	BsService bsService;
	
	@Autowired
	private FeeService feeService;

	
	private final String PROFIT_CD="31101000";
	private final String FEE_CD="31102000";
	private final String OP_BRNO="111";

	public int procRemittance(RemittanceVo remittanceVo, String refNo) throws Exception{
		
		String bic = "CITICIAXXXX";
		
		// 공통적인 기본 값을 셋팅한다.
		AccountingVo accountingVo;
		
		String today = StringUtil.currentDateString("yyyyMMdd");
		// 환율정보
		FrgnExchRateVo frgnExchRateVo = frgnExchRateService.getFrgnExchRateVo(today, remittanceVo.getCrcd());
		
		// 입력정보로 현재 환율회차 정보로 새로 계산한다.
		String rmtKdcd = remittanceVo.getRmtKdcd();
		String crcd = remittanceVo.getCrcd();
		String ntcd = remittanceVo.getAdreNtcd();
		BigDecimal owmnAmt = remittanceVo.getOwmnAmt();
		BigDecimal prmRt = remittanceVo.getPrmRt();
		RemittanceVo newRemittanceVo;
		
		long actgTrSrno = glMasterService.getMaxActTrSrno();
		long actgTrSubSrno = 1;
		int row=1;
		
		try{

			newRemittanceVo = this.calcRemittance(rmtKdcd, crcd, ntcd, prmRt, owmnAmt);

			// GlMaster 데이터 생성
			accountingVo = setBasicData(remittanceVo);
			actgTrSrno = insertGlMaster(actgTrSrno, refNo);
			
			// GlDetail 데이터 생성
			/**
			 * 송금금액 원금 계정처리
			 */
			accountingVo = setBasicData(remittanceVo);
			// 거래외화금액
			accountingVo.setTrFrc(remittanceVo.getOwmnAmt());
			// 환율회차
			accountingVo.setQuotSeq(frgnExchRateVo.getQuotSeq());
			// 매매기준율
			accountingVo.setMidRate(frgnExchRateVo.getMidRate());
			// 고시환율
			accountingVo.setQuotRate(frgnExchRateVo.getTtSellRate());
			// 우대율
			accountingVo.setPrmRt(remittanceVo.getPrmRt());
			// 적용환율
			accountingVo.setAplyRate(newRemittanceVo.getAplExrt());
			// 매매원화금액
			accountingVo.setDlnWna(AmountCalcUtil.getStlmWna(remittanceVo.getOwmnAmt(), frgnExchRateVo.getMidRate()));
			// 적용원화금액
			accountingVo.setAplyWna(newRemittanceVo.getCashWna());
			// 매매손익원화금액
			accountingVo.setDlnPlWna(newRemittanceVo.getDlnPlWna());
			// 포지션외화금액
			accountingVo.setPosiFrc(remittanceVo.getOwmnAmt());
			// 포지션원화금액
			accountingVo.setPosiWna(accountingVo.getDlnWna());
			// 수수료
			accountingVo.setFee(newRemittanceVo.getFeeAmtWna());

			accountingVo.setBic(bic);

			List<AccountingDetailVo> pmnyList = accountingPrcService.proc(accountingVo, row);
			
			// DB insert
			creatGlDetail(pmnyList, accountingVo, actgTrSrno, actgTrSubSrno);
			
			actgTrSubSrno = pmnyList.size()+1;
			
			row = pmnyList.get(pmnyList.size()-1).getRow()+1;
			
			// 수수표
//			if(newCreate.getCnFrgAmt()!=null && newCreate.getCnFrgAmt().compareTo(BigDecimal.ZERO)>0){
//				/**
//				 * 주화 계정처리
//				 */
//				accounting = setBasicData(create);
//				// 거래외화금액
//				accounting.setTrFrc(newCreate.getCnFrgAmt());
//				// 환율회차
//				accounting.setQuotSeq(frgnExchRate.getQuotSeq());
//				// 매매기준율
//				accounting.setMidRate(frgnExchRate.getMidRate());
//				// 고시환율
//				accounting.setQuotRate(frgnExchRate.getMidRate());
//				// 우대율
//				accounting.setPrmRt(create.getPrmRt());
//				// 적용환율
//				accounting.setAplyRate(newCreate.getCnAplExrt());
//				// 매매원화금액
//				accounting.setDlnWna(amountCalc.getStlmWna(create.getCnFrgAmt(), frgnExchRate.getMidRate()));
//				// 적용원화금액
//				accounting.setAplyWna(newCreate.getCnStlmWna());
//				// 매매손익원화금액
//				accounting.setDlnPlWna(newCreate.getCnDlnPlWna());
//				// 포지션외화금액
//				accounting.setPosiFrc(newCreate.getCnFrgAmt());
//				// 포지션원화금액
//				accounting.setPosiWna(accounting.getDlnWna());
//				
//				accounting.setBic(bic);
//
//				List<AccountingList> cnList = accountingPrc.proc(accounting, row);
//				// DB insert
//				creatGlDetail(cnList, accounting, actgTrSrno, actgTrSubSrno);
//			}
//
		}catch(Exception e){
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
	
	/**
	 * ----------------------------------------------------------
	 *  절차
	 * ----------------------------------------------------------
	 * 1. 통화에 대한 고시환율정보를 조회한다.
	 * 2. 통화에 대한 기본정보를 가져온다.
	 * 3. 통화와 금액에 대한 수수료를 가져온다.
	 * 4. 전신환스프레드 값에 우대율을 곱해서 적용환율을 계산한다.
	 * 5. 계산된 적용환율로 원화금액을 계산한다.
	 * 6. 매매기준율을 사용한 원화금액과 적용환율로 계산한 원화금액의 차를 계산한다.
	 * 7. 대미환산금액을 계산한다.
	 * ----------------------------------------------------------
	 * 
	 * @param crcd 통화코드
	 * @param prmRt 우대율
	 * @param owmnAmt 당발송금금액
	 * @return 적용환율, 원화금액, 거래이익, 원화정산금액
	 */
	public RemittanceVo calcRemittance(String rmtKdcd, String crcd, String ntcd, BigDecimal prmRt, BigDecimal owmnAmt) throws Exception {
		
		RemittanceVo remittanceVo = new RemittanceVo();
		
		String today = StringUtil.currentDateString("yyyyMMdd");
		
		// 1. 통화에 대한 고시환율정보를 조회한다.
		FrgnExchRateVo frgnExchRateVo = frgnExchRateService.getFrgnExchRateVo(today, crcd);

		// 2. 통화에 대한 기본정보를 가져온다.
		CurrencyVo currencyVo = currencyService.findOneCurrency(crcd);

		// 3. 통화와 금액에 대한 수수료를 가져온다.
		BigDecimal feeAmtWna = feeService.getFeeAmt(rmtKdcd, crcd, ntcd, owmnAmt);

		// 4. 전신환 스프레드 값에 우대율을 곱해서 적용환율을 계산한다.
		BigDecimal aplExrt = AmountCalcUtil.getAplExrt(frgnExchRateVo.getMidRate(), currencyVo.getTtSprdRate(), prmRt, crcd, "S");

		// 5. 계산된 적용환율로 원화금액을 계산한다.
		BigDecimal stlmWna = AmountCalcUtil.getStlmWna(owmnAmt, aplExrt);

		// 6. 매매기준율을 사용한 원화금액과 적용환율로 계산한 원화금액의 차를 계산한다.
		BigDecimal dlnPlWna = AmountCalcUtil.getDlnPlWna(owmnAmt, frgnExchRateVo.getMidRate(), aplExrt);
		
		// 7. 대미환산금액을 계산한다.
		BigDecimal tusaTnslAmt = AmountCalcUtil.getTusaTnslAmt(owmnAmt, BigDecimal.ZERO, frgnExchRateVo.getUsdCrosRate());

		remittanceVo.setCashWna(stlmWna.add(feeAmtWna)); // 원화금액 + 수수료
		remittanceVo.setDlnPlWna(dlnPlWna);
		remittanceVo.setAplExrt(aplExrt);
		remittanceVo.setBasicRate(frgnExchRateVo.getTtSellRate());
		remittanceVo.setPrmRt(prmRt);
		remittanceVo.setTusaTnslAmt(tusaTnslAmt);
		remittanceVo.setQuotSeq(frgnExchRateVo.getQuotSeq());
		remittanceVo.setFeeAmtWna(feeAmtWna);
		return remittanceVo;
	}	
	
	
	private AccountingVo setBasicData(RemittanceVo remittanceVo){
		
		AccountingVo accountingVo = new AccountingVo();

		// 거래점코드
		accountingVo.setTrBrno(remittanceVo.getTrBrno());
		// 상대점코드
		accountingVo.setOpTrBrno(this.OP_BRNO); // 외환센터(?)
		// 주계정코드
		accountingVo.setMainAcsjNm("11101000"); // 외국통화
		// 상대계정코드
		accountingVo.setOpAcsjNm("11102000"); // 원화현금
		// 매입매도구분코드
		accountingVo.setBuySellType("S"); // 매입 / 매도 구분 B:매입, S:매도
		// 거래통화코드
		accountingVo.setTrCrd(remittanceVo.getCrcd());
		// 우대율
		accountingVo.setPrmRt(remittanceVo.getPrmRt());
		// 포지션발생여부
		accountingVo.setPosiYn("Y");

		if(remittanceVo.getWnItrlkAmt().compareTo(BigDecimal.ZERO)!=0){
			accountingVo.setOpAcsjNm("21102000"); // 보통예금
		}
		
		return accountingVo;
	}
	
	private long insertGlMaster(long actgTrSrno, String refNo) throws Exception{
		
		GlMasterVo glMasterVo = new GlMasterVo();
			
		glMasterVo.setActgTrDt(StringUtil.currentDateString("yyyyMMdd"));
		glMasterVo.setActgTrSrno(actgTrSrno);
		glMasterVo.setBzTcd("OR"); 		// OR-당발송금 CS-외국통화매매
		glMasterVo.setRefNo(refNo);
		glMasterVo.setPrcTcd("1");			// 1-정상 8-취소대응 9-취소
		glMasterVo.setOrgActgTrDt("");
		glMasterVo.setOrgActgTrSrno(0);
		glMasterVo.setStatTcd("1");		// 1-정상 9-취소
		glMasterVo.setRegiDt(StringUtil.currentDateString("yyyyMMdd"));
		glMasterVo.setRegiTm(StringUtil.currentDateString("hhmmss"));
		
		int effectRows =  glMasterService.insertGlMaster(glMasterVo);
		if(effectRows==1){
			return actgTrSrno;
		}
		else {
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
			}else
			// 거래매매이익, 송금수수료 BS 잔액 생성
			if(glDetailVo.getAcctCd().equalsIgnoreCase(this.PROFIT_CD)|| glDetailVo.getAcctCd().equalsIgnoreCase(this.FEE_CD)){
				// BS 잔액 생성

				bsService.insertBs(getBsVo(glDetailVo));
			}
			
		}
	}
	
	private BsVo getBsVo(GlDetailVo glDetailVo){
		BsVo bsVo = new BsVo();
		
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
