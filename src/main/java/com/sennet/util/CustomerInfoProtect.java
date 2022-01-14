package com.sennet.util;

import com.sennet.gator.admin.client.util.KeyUtil;

public class CustomerInfoProtect {
	public static final int USERID_DUMMY = 2;
	public static final int PASSWORD_DUMMY = 4;
	private String info;

	public boolean initAESKey() {
		if (KeyUtil.getStringEncrypter() == null) {
			return KeyUtil.makeStringEncrypter();
		}
		return true;
	}

	public boolean initAESKey(String filePath) {
		if (KeyUtil.getStringEncrypter() == null) {
			return KeyUtil.makeStringEncrypter(filePath);
		}
		return true;
	}

	public String getInfo() {
		return this.info;
	}

	public String encryptInfo(String text) {
		return KeyUtil.encryptUseridPassword(text, 2);
	}

	public String decryptInfo(String text) {
		return KeyUtil.decryptUseridPassword(text, 2);
	}
}
