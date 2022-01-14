package com.sennet.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import com.sennet.common.SennetProperty;
import com.sennet.userprofile.UserProfileService;
import com.sennet.userprofile.UserProfileVo;

import lombok.extern.slf4j.Slf4j;

@Configuration
@Slf4j
public class CustomFailureHandler implements AuthenticationFailureHandler {

//	@Autowired
//	private AccountService service;
	@Autowired
	private UserProfileService userProfileService;

	@Autowired
	private SennetProperty prop;

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,AuthenticationException authenticationException) throws IOException, ServletException {

		if (authenticationException instanceof BadCredentialsException) {

			String userName = request.getParameter("username");
			log.info(" id :{}  " , request.getParameter("username") + " login failed");

			if (prop.getIdlock().equals("true")) {

				try {
					UserProfileVo userProfileVo = userProfileService.updateBadCount(userName);
					response.sendRedirect(request.getContextPath() + "/login?error&count=" + userProfileVo.getBadCount());
					return;
				} catch (Exception e) {
					response.sendRedirect(request.getContextPath() + "/login?error");
					return;
				}

			}

			response.sendRedirect(request.getContextPath() + "/login?error");
			return;
		} else {
			response.sendRedirect(request.getContextPath() + "/error/902");
		}
	}
}
