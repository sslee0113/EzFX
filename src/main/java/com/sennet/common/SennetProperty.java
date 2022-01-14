package com.sennet.common;

import lombok.Data;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;

@ConfigurationProperties(prefix="sennet")
@Configuration
@Data
public class SennetProperty {
	private String dburl;
	private String dbid;
	private String dbpassword;
	private String driverclassname;
	private String concurrentsessionblock;
	private int concurrentsession;
	private String ipblock;
	private String allowip;	
	private String sessiontimeoutblock;
	private int sessiontimeoutsecound;
	private String idlock;
	private int idcheckcount;
	private int idblockcount;
	private String accesslog;
	private String accountipblock;
	private String accountpasswordexpiredcheck;
	private int accountpasswordexpiredinterval;
	private String keypath;
	private String ediserverip;
	private String ediserverport;
	private String start11;
	private String start12;
	private String start13;
	private String start14;
	private String start15;
	private String start16;
	private String restart21;
	private String restart22;
	private String stop31;
	private String stop32;
	private String stop33;
	private String stop34;
	private String stop35;
	private String stop36;
	private String stop37;
	private String stop38;
	private String backup;
	private String delete;
	private String status;
	private String dashboardkftc;
	private String dashboardktnet;
}
