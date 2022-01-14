package com.sennet.security;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.sennet.bizcommon.commondcode.CommonDcodeVo;
import com.sennet.userprofile.UserProfileVo;

public class CustomUserDetails extends User {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4333451638832376907L;

	public CustomUserDetails(UserProfileVo vo,List<CommonDcodeVo> menuList) {
		super(vo.getUserName(), vo.getPassword(), authorities(vo,menuList));
	}
	private static Collection<? extends GrantedAuthority> authorities(UserProfileVo vo,List<CommonDcodeVo> menuList) {
		List<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
		authorities.add(new CustomGrantedAuthority(vo,menuList));
		return authorities;
	}
}
