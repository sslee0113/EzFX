package com.sennet.webaccesslog;

import lombok.Data;

@Data
public class WebAccessLogVo {
	
	private String uuid;
	private String valDate;
	private String valTime;
	private String userName;
	private String userAddr;
	private String requestUri;
	private String requestMethod;

}
