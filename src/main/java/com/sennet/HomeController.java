package com.sennet;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {


	@RequestMapping(value = "/", method = GET)
	public String index() {return "login";}
	
	@RequestMapping(value = "/login", method = GET)
	public String login() {return "login";}

	// 외국통화매입
	@RequestMapping(value = "/exchange/exchangeBuy", method = GET)
	public String exchangeBuy() {
		return "/exchange/exchangeBuy"; 
	}

	// 외국통화매입 With RefNo
	@RequestMapping(value = "/exchange/exchangeBuy/{refNo}", method = GET)
	public String exchangeBuy(@PathVariable String refNo, Model model) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("refNo", refNo);

		model.addAttribute("map", map);

		return "/exchange/exchangeBuy";
	}

	// 외국통화매도
	@RequestMapping(value = "/exchange/exchangeSell", method = GET)
	public String exchangeSell() {return "/exchange/exchangeSell";}

	// 환전목록조회
	@RequestMapping(value = "/exchange/exchangeList", method = GET)
	public String exchangeList() {return "/exchange/exchangeList";}

	// 해외송금
	@RequestMapping(value = "/remittance/remittance", method = GET)
	public String remittance() {return "/remittance/remittance";}
	
	// 외국통화매입 With RefNo
	@RequestMapping(value = "/remittance/remittance/{refNo}", method = GET)
	public String remittance(@PathVariable String refNo, Model model) {
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("refNo", refNo);

		model.addAttribute("map", map);

		return "/remittance/remittance";
	}

	// 해외송금목록조회
	@RequestMapping(value = "/remittance/remittanceList", method = GET)
	public String remittanceList() {return "/remittance/remittanceList";}

	// 해외송금 집계조회
	@RequestMapping(value = "/remittance/remittanceTotal", method = GET)
	public String remittanceTotal() {return "/remittance/remittanceTotal";}

	// 통화 관리
	@RequestMapping(value = "/bizcommon/currency", method = GET)
	public String currency() {return "/bizcommon/currency";}

	// 영업점 관리
	@RequestMapping(value = "/bizcommon/branch", method = GET)
	public String branch() {return "/bizcommon/branch";}
	
	// 국가 관리
	@RequestMapping(value = "/bizcommon/country", method = GET)
	public String country() {return "/bizcommon/country";}
	
	// 외환고객 관리
	@RequestMapping(value = "/bizcommon/customer", method = GET)
	public String customer() {return "/bizcommon/customer";}
	
	// 환율정보조회
	@RequestMapping(value = "/bizcommon/frgnExchRate", method = GET)
	public String frgnExchRate() {return "/bizcommon/frgnExchRate";}

	// 환율고시
	@RequestMapping(value = "/bizcommon/frgnExchRateNotice", method = GET)
	public String frgnExchRateNotice() {return "/bizcommon/frgnExchRateNotice";}

	// 주소관리
	@RequestMapping(value = "/bizcommon/zipcode", method = GET)
	public String zipcode() {return "/bizcommon/zipcode";}
	
	// 주소관리
	@RequestMapping(value = "/inc/zipcodeWindow", method = GET)
	public String zipcodeWindow() {return "/inc/zipcodeWindow";}
	
	//userProfile
	@RequestMapping(value = "/bizcommon/userProfile", method = GET)
	public String userProfile() {return "/bizcommon/userProfile";}
	
	// 수수료 관리
	@RequestMapping(value = "/bizcommon/fee", method = GET)
	public String fee() {return "/bizcommon/fee";}

	// IF로그 조회
	@RequestMapping(value = "/bizcommon/ifLog", method = GET)
	public String ifLog() {return "/bizcommon/ifLog";}

	// 계정처리내역조회
	@RequestMapping(value = "/accounting/glList", method = GET)
	public String glList() {return "/accounting/glList";}

	// BS 조회
	@RequestMapping(value = "/accounting/bsList", method = GET)
	public String bsList() {return "/accounting/bsList";}
	
	// glCode
	@RequestMapping(value = "/accounting/glCode", method = GET)
	public String glCode() {return "/accounting/glCode";}
	
	// 공통코드
	@RequestMapping(value = "/bizcommon/commonCode", method = GET)
	public String commonCode() {return "/bizcommon/commonCode";}
	
	// 공통코드상세
	@RequestMapping(value = "/bizcommon/commonDcode", method = GET)
	public String commonDcode() {return "/bizcommon/commonDcode";}
	
	// 메뉴관리
	@RequestMapping(value = "/bizcommon/menu", method = GET)
	public String menu() {return "/bizcommon/menu";}
	// 권한관리
	@RequestMapping(value = "/bizcommon/role", method = GET)
	public String role() {return "/bizcommon/role";}

	// 사용자 암호관리
	@RequestMapping(value = "/bizcommon/password", method = GET)
	public String password() {return "/bizcommon/password";}
	
	// 사용자 개인정보관리
	@RequestMapping(value = "/bizcommon/userInfo", method = GET)
	public String userInfo() {return "/bizcommon/userInfo";}
	
	//account_password_update_Expired
	@RequestMapping(value = "/expired/password", method = GET)
	public String passwordExpired() {return "passwordexpired";}	
	
	//event
	@RequestMapping(value = "/admin/event", method = GET)
	public String webaccesslog() {return "event";}	
	
	//error
	@RequestMapping(value = "/error/sessionexpired", method = GET)
	public String sessionexpired() {return "/error/sessionexpired";}
	
	@RequestMapping(value = "/error/sessioninvalid", method = GET)
	public String sessiontimeout() {return "/error/sessioninvalid";}	
	
	@RequestMapping(value = "/error/403", method = GET)	
	public String error403() {return "/error/403";}		
	
	@RequestMapping(value = "/error/404", method = GET)	
	public String error404() {return "/error/404";}
	
	@RequestMapping(value = "/error/405", method = GET)	
	public String error405() {return "redirect:/error/404";}		
	
	@RequestMapping(value = "/error/500", method = GET)	
	public String error500() {return "/error/500";}	
	
	@RequestMapping(value = "/error/600", method = GET)	
	public String error600() {return "/error/600";}	
	
	@RequestMapping(value = "/error/700", method = GET)	
	public String error700() {return "/error/700";}

	@RequestMapping(value = "/error/800", method = GET)	
	public String error800() {return "/error/800";}
	
	@RequestMapping(value = "/error/900", method = GET)
	public String error900() {return "/error/900";}	

	@RequestMapping(value = "/error/901", method = GET)	
	public String error901() {return "/error/901";}
	
	@RequestMapping(value = "/error/902", method = GET)	
	public String error902() {return "/error/902";}	
	
	
	
	
}
