package com.sennet.security;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.util.Assert;

import com.sennet.bizcommon.commondcode.CommonDcodeVo;
import com.sennet.bizcommon.role.TrRoleVo;
import com.sennet.common.StringUtil;
import com.sennet.userprofile.UserProfileVo;

/**
 * Basic concrete implementation of a {@link GrantedAuthority}.
 *
 * <p>
 * Stores a {@code String} representation of an authority granted to the
 * {@link org.springframework.security.core.Authentication Authentication} object.
 *
 * @author lee soung soo
 */
public final class CustomGrantedAuthority implements GrantedAuthority {

	private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;
	private final String role;

	private final UserProfileVo _userProfileVo;
	private final List<CommonDcodeVo>  _menuList;

	public CustomGrantedAuthority(UserProfileVo vo, List<CommonDcodeVo> menuList) {
		Assert.hasText(vo.getRole(), "A granted authority textual representation is required");
		this.role = vo.getRole();

		this._userProfileVo = vo;
		this._menuList = menuList;
	}

	public String getAuthority() {
		return role;
	}

	public List<TrRoleVo> getTrRoleVoList() {
		return _userProfileVo.getTrRoleVoList();
	}
	
	// 선택된 메뉴
	public String getDcode(String uri) {
		Iterator<TrRoleVo> itr = getTrRoleVoList().iterator();
		while(itr.hasNext()){
			TrRoleVo vo = itr.next();
			// 선택된메뉴는 Plain false
			if(StringUtil.getPlainMenu(uri, vo.getMenuUrl()).equals("false")){
				return vo.getDcode();
			}
		}
		return "";
	}
	public List<TrRoleVo> getMenuTrRoleVoList(String MiddleMenuName) {
		List<TrRoleVo> trRoleVoList = new ArrayList<TrRoleVo>();
		Iterator<TrRoleVo> itr = getTrRoleVoList().iterator();
		while(itr.hasNext()){
			TrRoleVo vo = itr.next();
			if(vo.getChk()==null) continue;
			if(vo.getDcodeName().equals(MiddleMenuName)){
				trRoleVoList.add(vo);
			}
		}
		return  trRoleVoList;
	}
	public List<CommonDcodeVo> getMenuList() {
		return _menuList;
	}

	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj instanceof CustomGrantedAuthority) {
			return role.equals(((CustomGrantedAuthority) obj).role);
		}

		return false;
	}

	public int hashCode() {
		return this.role.hashCode();
	}

	public String toString() {
		return this.role;
	}
}
