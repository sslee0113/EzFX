package com.sennet.security;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.sennet.bizcommon.commondcode.CommonDcodeService;
import com.sennet.bizcommon.commondcode.CommonDcodeVo;
import com.sennet.bizcommon.role.RoleService;
import com.sennet.bizcommon.role.TrRoleVo;
import com.sennet.userprofile.UserProfileDao;
import com.sennet.userprofile.UserProfileVo;


@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    UserProfileDao userProfileDao;
    @Autowired
    CommonDcodeService commonDcodeServiceDao;
    @Autowired
    RoleService roleService;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
    	UserProfileVo userProfileVo = userProfileDao.findOneUserProfile(username);
    	List<CommonDcodeVo> menuList = commonDcodeServiceDao.searchListCommonDcode("MENU_CD");
        if (userProfileVo == null) {
            throw new UsernameNotFoundException(username);
        }
        else{
        	List<TrRoleVo> trRoleVoList = roleService.searchListRole(userProfileVo.getRole());
        	userProfileVo.setTrRoleVoList(trRoleVoList);
        }
        return new CustomUserDetails(userProfileVo,menuList);
    }
}
