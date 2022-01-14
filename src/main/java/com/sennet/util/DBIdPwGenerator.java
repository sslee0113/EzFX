package com.sennet.util;

import com.sennet.common.StringUtil;
import com.sennet.gator.admin.client.util.DbconfigDecryptor;

import lombok.extern.slf4j.Slf4j;
@Slf4j
public class DBIdPwGenerator {

//	public static void main(String[] args) {
//		
//		if(args.length!=3){
//			
//			System.err.println("parameter error");
//			System.err.println("ex) DBIdPwGenerator [DB ID] [DB Password] [AESKeyPATH]");
//		
//			System.exit(0);
//		}
//		
//		String id = args[0];
//		String pw = args[1];
//		String aeskey = args[2];
//		
//		System.out.println("ID:"+id);
//		System.out.println("PW:"+pw);
//		System.out.println("aeskey:"+aeskey);
//		DbconfigDecryptor dbconfigDecryptor = new DbconfigDecryptor();
//		
//		if (!dbconfigDecryptor.initAESKey(aeskey)) { //"c:/temp/gator.aes")) {
//		} else {
//		}
//	
//		String encId = dbconfigDecryptor.encryptUserid(id);
//		String encPw = dbconfigDecryptor.encryptPassword(pw);
//		System.out.println("encrypted ID:"+encId);
//		System.out.println("encrypted PW:"+encPw);
//		
//	}

}
