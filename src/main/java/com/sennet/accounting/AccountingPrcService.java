package com.sennet.accounting;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sennet.common.StringUtil;
import com.sennet.exchange.ExchangeService;
import com.sennet.remittance.RemittanceService;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class AccountingPrcService {
	
	//test
//	private final String position="포지션";
	private final String POSITION="Y";
	private final String POSITION_CD="29101000";
//	private final String frcHeadBranch="외화본지점";
	private final String FRC_HEAD_BRANCH_CD="28101000";
//	private final String frcDiffBranch="외화타점예치";
	private final String FRC_DIFF_BRANCH_CD="11201000";
//	private final String profit="거래이익";
	private final String PROFIT_CD="31101000";
	private final String FEE_CD="31102000";
//	private final String SUBSTITUTION="대체";
	private final String SUBSTITUTION="N";
	private final String CREDIT="C";
	private final String DEBIT="D";
	private final String KRW="KRW";

	/**
	 * 분개내역을 생성한다.
	 * 1.통화정보를 읽어온다.
	 * 2.환율정보를 읽어온다.
	 * 3.매매/적용/손익/포지션 원화금액을 계산한다.
	 * 4.데이터 조립
	 * @return accountingDetailVo
	 */
	public List<AccountingDetailVo> proc(AccountingVo accountingVo, int row) throws Exception{
		
		boolean isBuy=false;

		List<AccountingDetailVo> list = new ArrayList<AccountingDetailVo>();
		AccountingDetailVo accountingDetailVo;

		// 매입 / 매도 구분 B:매입, S:매도
		if(accountingVo.getBuySellType().equalsIgnoreCase("B")){
			isBuy = true;
		}
		
		//------------------------------------------------------------------------------------
		// 계정명    | 통화  | 외화금액  |  원화금액   |  구분   |  계정명    | 통화  | 외화금액  |  원화금액   |  구분   | 
		// 외국통화     USD      100    100,000    포지션  |   현금        KRW       0    100,000       포지션   
		// 주계정
		accountingDetailVo = new AccountingDetailVo();
		accountingDetailVo.setBrType(accountingVo.getTrBrno());				// 점구분
		accountingDetailVo.setCrdrTcd(getCrdrTcd(isBuy));					// 차대구분
		accountingDetailVo.setAcsjNm(accountingVo.getMainAcsjNm());			// 계정명
		accountingDetailVo.setCrd(accountingVo.getTrCrd());					// 통화
		accountingDetailVo.setFrc(accountingVo.getTrFrc());					// 외화금액
		accountingDetailVo.setWna(accountingVo.getDlnWna());					// 원화금액
		accountingDetailVo.setPosiYn(this.POSITION);						// 구분
		accountingDetailVo.setRow(row);										// ROW
		list.add(accountingDetailVo);
		
		log.info(accountingDetailVo.toString());
		
		// 주계정의 상대계정
		accountingDetailVo = new AccountingDetailVo();
		accountingDetailVo.setBrType(accountingVo.getTrBrno());				// 점구분
		accountingDetailVo.setCrdrTcd(getCrdrTcd(!isBuy));					// 차대구분
		accountingDetailVo.setAcsjNm(accountingVo.getOpAcsjNm());				// 계정명
		accountingDetailVo.setCrd(this.KRW);								// 통화
		accountingDetailVo.setFrc(BigDecimal.ZERO);							// 외화금액
		accountingDetailVo.setWna(accountingVo.getDlnWna());					// 원화금액
		accountingDetailVo.setPosiYn(this.POSITION);						// 구분
		accountingDetailVo.setRow(row);										// ROW
		list.add(accountingDetailVo);
		
		log.info(accountingDetailVo.toString());

		//-------------------------------------------------------------------------------------
		// 계정명    | 통화  | 외화금액  |  원화금액   |  구분   |  계정명    | 통화  | 외화금액  |   원화금액   |  구분   | 
		//  현금        KRW       0     19,000        대체   | 거래이익      KRW        0     19,000        대체  | 
		row++;
		// 주계정의 상대계정
		accountingDetailVo = new AccountingDetailVo();
		accountingDetailVo.setBrType(accountingVo.getTrBrno());				// 점구분
		accountingDetailVo.setCrdrTcd(this.DEBIT);							// 차대구분
		accountingDetailVo.setAcsjNm(accountingVo.getOpAcsjNm());				// 계정명
		accountingDetailVo.setCrd(this.KRW);								// 통화
		accountingDetailVo.setFrc(BigDecimal.ZERO);							// 외화금액
		accountingDetailVo.setWna(accountingVo.getDlnPlWna());				// 원화금액
		accountingDetailVo.setPosiYn(this.SUBSTITUTION);					// 구분
		accountingDetailVo.setRow(row);										// ROW
		list.add(accountingDetailVo);

		log.info(accountingDetailVo.toString());

		// 주계정
		accountingDetailVo = new AccountingDetailVo();
		accountingDetailVo.setBrType(accountingVo.getTrBrno());				// 점구분
		accountingDetailVo.setCrdrTcd(this.CREDIT);							// 차대구분
		accountingDetailVo.setAcsjNm(this.PROFIT_CD);						// 계정명
		accountingDetailVo.setCrd(this.KRW);								// 통화
		accountingDetailVo.setFrc(BigDecimal.ZERO);							// 외화금액
		accountingDetailVo.setWna(accountingVo.getDlnPlWna());				// 원화금액
		accountingDetailVo.setPosiYn(this.SUBSTITUTION);					// 구분
		accountingDetailVo.setRow(row);										// ROW
		list.add(accountingDetailVo);
		
		log.info(accountingDetailVo.toString());
		
		if(accountingVo.getFee()!=null && accountingVo.getFee().compareTo(BigDecimal.ZERO)>0){
		
			// 수수료가 존재할 경우
			//-------------------------------------------------------------------------------------
			// 계정명    | 통화  | 외화금액  |  원화금액   |  구분   |  계정명    | 통화  | 외화금액  |   원화금액   |  구분   | 
			//  현금        KRW       0      5,000        대체   |  수수료      KRW        0      5,000        대체  | 
			row++;
			// 주계정의 상대계정
			accountingDetailVo = new AccountingDetailVo();
			accountingDetailVo.setBrType(accountingVo.getTrBrno());			// 점구분
			accountingDetailVo.setCrdrTcd(this.DEBIT);						// 차대구분
			accountingDetailVo.setAcsjNm(accountingVo.getOpAcsjNm());			// 계정명
			accountingDetailVo.setCrd(this.KRW);							// 통화
			accountingDetailVo.setFrc(BigDecimal.ZERO);						// 외화금액
			accountingDetailVo.setWna(accountingVo.getFee());					// 원화금액
			accountingDetailVo.setPosiYn(this.SUBSTITUTION);				// 구분
			accountingDetailVo.setRow(row);									// ROW
			list.add(accountingDetailVo);

			log.info(accountingDetailVo.toString());

			// 주계정
			accountingDetailVo = new AccountingDetailVo();
			accountingDetailVo.setBrType(accountingVo.getTrBrno());			// 점구분
			accountingDetailVo.setCrdrTcd(this.CREDIT);						// 차대구분
			accountingDetailVo.setAcsjNm(this.FEE_CD);						// 계정명
			accountingDetailVo.setCrd(this.KRW);							// 통화
			accountingDetailVo.setFrc(BigDecimal.ZERO);						// 외화금액
			accountingDetailVo.setWna(accountingVo.getFee());					// 원화금액
			accountingDetailVo.setPosiYn(this.SUBSTITUTION);				// 구분
			accountingDetailVo.setRow(row);									// ROW
			list.add(accountingDetailVo);
			
			log.info(accountingDetailVo.toString());
		}

		// 상대점이 존재할 경우
		String trBrno = accountingVo.getTrBrno();
		String opTrBrno = accountingVo.getOpTrBrno();
		if(trBrno!=null && opTrBrno!=null && !opTrBrno.equals(trBrno)){

			//----------------------------------------------------------------------------------------
			//  계정명      | 통화  | 외화금액  |  원화금액   |  구분   |  계정명    | 통화  | 외화금액  |   원화금액   |  구분   | 
			// 외화본지점      USD      100    100,000      대체   | 외국통화      USD      100    100,000        대체  | 
			row++;
			// 주계정
			accountingDetailVo = new AccountingDetailVo();
			accountingDetailVo.setBrType(accountingVo.getTrBrno());				// 점구분
			accountingDetailVo.setCrdrTcd(getCrdrTcd(isBuy));					// 차대구분
			accountingDetailVo.setAcsjNm(this.FRC_HEAD_BRANCH_CD);				// 계정명
			accountingDetailVo.setCrd(accountingVo.getTrCrd());					// 통화
			accountingDetailVo.setFrc(accountingVo.getTrFrc());					// 외화금액
			accountingDetailVo.setWna(accountingVo.getDlnWna());					// 원화금액
			accountingDetailVo.setPosiYn(this.SUBSTITUTION);					// 구분
			accountingDetailVo.setRow(row);										// ROW
			list.add(accountingDetailVo);
			
			log.info(accountingDetailVo.toString());

			// 주계정의 상대계정
			accountingDetailVo = new AccountingDetailVo();
			accountingDetailVo.setBrType(accountingVo.getTrBrno());				// 점구분
			accountingDetailVo.setCrdrTcd(getCrdrTcd(!isBuy));					// 차대구분
			accountingDetailVo.setAcsjNm(accountingVo.getMainAcsjNm());			// 계정명
			accountingDetailVo.setCrd(accountingVo.getTrCrd());					// 통화
			accountingDetailVo.setFrc(accountingVo.getTrFrc());					// 외화금액
			accountingDetailVo.setWna(accountingVo.getDlnWna());					// 원화금액
			accountingDetailVo.setPosiYn(this.SUBSTITUTION);					// 구분
			accountingDetailVo.setRow(row);										// ROW
			list.add(accountingDetailVo);	

			log.info(accountingDetailVo.toString());

			// 상대점
			//----------------------------------------------------------------------------------------
			//     계정명      | 통화  | 외화금액  |  원화금액   |  구분   |   계정명    | 통화  | 외화금액  |   원화금액   |  구분   | 
			//  외화타점예치       USD      100    100,000        대체  | 외화본지점     USD      100    100,000       대체   |
			row++;
			// 주계정
			accountingDetailVo = new AccountingDetailVo();
			accountingDetailVo.setBrType(accountingVo.getOpTrBrno());				// 점구분
			accountingDetailVo.setCrdrTcd(getCrdrTcd(isBuy));					// 차대구분
			accountingDetailVo.setAcsjNm(this.FRC_DIFF_BRANCH_CD);				// 계정명
			accountingDetailVo.setCrd(accountingVo.getTrCrd());					// 통화
			accountingDetailVo.setFrc(accountingVo.getTrFrc());					// 외화금액
			accountingDetailVo.setWna(accountingVo.getDlnWna());					// 원화금액
			accountingDetailVo.setPosiYn(this.SUBSTITUTION);					// 구분
			accountingDetailVo.setRow(row);										// ROW
			list.add(accountingDetailVo);	
			
			log.info(accountingDetailVo.toString());

			// 주계정의 상대계정
			accountingDetailVo = new AccountingDetailVo();
			accountingDetailVo.setBrType(accountingVo.getOpTrBrno());				// 점구분
			accountingDetailVo.setCrdrTcd(getCrdrTcd(!isBuy));					// 차대구분
			accountingDetailVo.setAcsjNm(this.FRC_HEAD_BRANCH_CD);				// 계정명
			accountingDetailVo.setCrd(accountingVo.getTrCrd());					// 통화
			accountingDetailVo.setFrc(accountingVo.getTrFrc());					// 외화금액
			accountingDetailVo.setWna(accountingVo.getDlnWna());					// 원화금액
			accountingDetailVo.setPosiYn(this.SUBSTITUTION);					// 구분
			accountingDetailVo.setRow(row);										// ROW
			list.add(accountingDetailVo);

			log.info(accountingDetailVo.toString());
		}
		return list;
	}
	/*
	private String getPosiYn(String posiYn){
		if(posiYn.equalsIgnoreCase("Y")){
			return position;
		}else{
			return SUBSTITUTION;
		}
	}
	*/
	
	private String getCrdrTcd(boolean isBuy){
		
		if(isBuy){
			return this.DEBIT;
		}else{
			return this.CREDIT;
		}
	}
	
}
