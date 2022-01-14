package com.sennet.accounting.bs;

import lombok.Data;

@Data
public class BsResponseSumVo {
	
	private String currCd; 
	private String dr; 
	private String cr; 
	private String sum;
}
