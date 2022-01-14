package com.sennet.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;

import com.sennet.common.SennetProperty;
import com.sennet.webaccesslog.WebAccessLogService;
import com.sennet.webaccesslog.WebAccessLogVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
public class CustomLogoutSuccessHandler extends SimpleUrlLogoutSuccessHandler {

	@Autowired
	SennetProperty prop;

	@Autowired
	private WebAccessLogService webAccessLogService;

	@Override
	public void onLogoutSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {

		if (authentication.getName() != null) {
			if (prop.getAccesslog().equals("true")) {
				WebAccessLogVo webAccessLogVo = new WebAccessLogVo();
				webAccessLogVo.setUserName(authentication.getName());
				webAccessLogVo.setUserAddr(request.getRemoteAddr());
				webAccessLogVo.setRequestUri(request.getRequestURI().replace("/", ""));
				webAccessLogVo.setRequestMethod(request.getMethod());

				webAccessLogService.insertWebAccessLog(webAccessLogVo);
				log.info("logout success ! username is {}, useraddr is  {}", authentication.getName(), request.getRemoteAddr());
			}
		}

		setDefaultTargetUrl("/");
		super.onLogoutSuccess(request, response, authentication);
	}

}
