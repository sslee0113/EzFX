package com.sennet.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.sennet.common.StringUtil;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class Scheduler {
	
//	@Scheduled(fixedDelay = 10000)
//	@Scheduled(cron = "1 * * * * ?")
	@Scheduled(cron = "${cron.info}")
	public void simplePrintln(){
	    log.info(StringUtil.currentDateString());
	}

}
