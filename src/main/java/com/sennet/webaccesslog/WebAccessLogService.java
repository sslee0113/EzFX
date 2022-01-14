package com.sennet.webaccesslog;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sennet.common.StringUtil;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class WebAccessLogService {

	@Autowired
	private WebAccessLogDao webAccessLogDao;

	// CREATE
	public WebAccessLogVo insertWebAccessLog(WebAccessLogVo webAccessLogVo) {
		if(webAccessLogVo.getRequestMethod()==null){
			webAccessLogVo.setRequestMethod("");
		}
		webAccessLogVo.setUuid(UUID.randomUUID().toString().replaceAll("-", ""));
		webAccessLogVo.setValDate(StringUtil.currentDateString("yyyyMMdd"));
		webAccessLogVo.setValTime(StringUtil.currentDateString("HHmmss"));
		webAccessLogVo.setRequestUri(webAccessLogVo.getRequestUri().replace("/rest/", ""));
		webAccessLogVo.setRequestMethod(webAccessLogVo.getRequestMethod().replace("POST", "등록").replace("GET", "조회").replace("PUT", "수정").replace("DELETE", "삭제"));
		if( webAccessLogDao.insertWebAccessLog(webAccessLogVo) == 1)
		{
			return webAccessLogVo;
		}
		else{
			return null;
		}
	}
}
