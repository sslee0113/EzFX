package com.sennet.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.sennet.common.SennetProperty;
import com.sennet.common.StringUtil;
import com.sennet.userprofile.UserProfileService;
import com.sennet.userprofile.UserProfileVo;
import com.sennet.webaccesslog.WebAccessLogService;
import com.sennet.webaccesslog.WebAccessLogVo;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Configuration

public class CustomSuccessHandler implements AuthenticationSuccessHandler{

	@Autowired
	SennetProperty prop;
	
//    @Autowired
//    private AccountService service;	

	@Autowired
	private UserProfileService userProfileService;

    @Autowired
    private WebAccessLogService webAccessLogService;
	
	@Override	
	public void onAuthenticationSuccess(HttpServletRequest request,	HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		UserProfileVo userProfileVo = userProfileService.findOneUserProfile(authentication.getName());
		
		if (prop.getIdlock().equals("true")) {
			//log.info("id locked option is true. value is {}",prop.getIdblockcount());
			if (userProfileVo.getBadCount() >= prop.getIdblockcount()) {
				log.info("id locked!! blockvalue is {}, badcount is {}",prop.getIdblockcount(),userProfileVo.getBadCount());
				response.sendRedirect(request.getContextPath() + "/error/600");
				return;
			}
		}
		userProfileService.updateInitCount(authentication.getName(),0);
		
		
		if (prop.getAccountipblock().equals("true")) {
			if (request.getRemoteAddr().contains(userProfileVo.getWhiteIp().replace("*", ""))|| userProfileVo.getWhiteIp().equals("*")) 
			{
				log.info("Account IP Check OK, {}", request.getRemoteAddr().toString());
			}
			else 
			{
				log.info("Account IP Check Failed : {}",request.getRemoteAddr());
				response.sendRedirect("/error/800");
				return;
			}
		}
		
		if (prop.getAccountpasswordexpiredcheck().equals("true")) {
			
			String compareDate = StringUtil.getPastMonthDateString("yyyy-MM-dd HH:mm:ss", prop.getAccountpasswordexpiredinterval());
			
			if (userProfileVo.getBadCountdate().compareTo(compareDate) > 0) 
			{
			}
			else
			{
				userProfileService.updateAccountAddExpired(authentication.getName());
				if (!userProfileVo.getRole().contains("EXPIRED")) {
					response.sendRedirect("/error/901");
					return;					
				}
				log.info("Password Expired : {}", authentication.getName());				
				response.sendRedirect("/error/900");
				return;				
			}
									
		}
		if (prop.getAccesslog().equals("true")) {
			WebAccessLogVo webAccessLogVo = new WebAccessLogVo();
			webAccessLogVo.setUserName(authentication.getName());
			webAccessLogVo.setUserAddr(request.getRemoteAddr());
			webAccessLogVo.setRequestUri(request.getRequestURI().replace("/", ""));
			webAccessLogVo.setRequestMethod(request.getMethod());
			webAccessLogService.insertWebAccessLog(webAccessLogVo);
		}
		log.info("login success ! username is {}, useraddr is  {}, userRole is {}", authentication.getName(),request.getRemoteAddr(),userProfileVo.getRole());
		if (prop.getSessiontimeoutblock().equals("true")) {
			log.info("session timeout  option is true. value is {} second",prop.getSessiontimeoutsecound());
			request.getSession().setMaxInactiveInterval(prop.getSessiontimeoutsecound());	
		}	
		// 초기 페이지 설정
		response.sendRedirect(request.getContextPath() + "/remittance/remittance");
	}
}