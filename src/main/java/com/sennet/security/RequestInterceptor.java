package com.sennet.security;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.sennet.common.SennetProperty;
import com.sennet.webaccesslog.WebAccessLogService;
import com.sennet.webaccesslog.WebAccessLogVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
public class RequestInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	SennetProperty prop;

	@Autowired
	WebAccessLogService webAccessLogService;

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

		super.afterCompletion(request, response, handler, ex);
	}

	@Override
	public void afterConcurrentHandlingStarted(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		super.afterConcurrentHandlingStarted(request, response, handler);
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)
			throws Exception {

		super.postHandle(request, response, handler, modelAndView);
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		if (request.getRequestURI().contains("rest")) {
			log.info("접속 IP:{}, 접속자:{}, 요청 화면:{}, 요청 이벤트:{}", request.getRemoteAddr(), request.getRemoteUser(),
					request.getRequestURI().replace("/rest/", ""),
					request.getMethod().replace("POST", "등록").replace("GET", "조회").replace("PUT", "수정").replace("DELETE", "삭제"));

		}

		if (prop.getIpblock().equals("true")) {

			if (request.getRemoteAddr().contains(prop.getAllowip().replace("*", "")) || prop.getAllowip().equals("*")) {
				// TODO 알고리즘 수정해야 함. 차차 고민해 볼것!
			} else {
				log.error("IP block : {}", request.getRemoteAddr());
				if (request.getRequestURI().contains("error")) {
				} else {
					response.sendRedirect("/error/700");
					return true;
				}
			}
		}

		if (request.getRemoteUser() != null) {
			if (request.getRequestURI().equals("/") || request.getRequestURI().contains("error")) {
			} else {
				if (prop.getAccesslog().equals("true") && request.getRequestURI().contains("rest")) {

					WebAccessLogVo webAccessLogVo = new WebAccessLogVo();
					webAccessLogVo.setUserName(request.getRemoteUser());
					webAccessLogVo.setUserAddr(request.getRemoteAddr());
					webAccessLogVo.setRequestUri(request.getRequestURI());
					webAccessLogVo.setRequestMethod(request.getMethod());
					webAccessLogService.insertWebAccessLog(webAccessLogVo);
				}
			}
		}
		return super.preHandle(request, response, handler);
	}

}
