package com.sennet.bizcommon.role;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.apache.ibatis.ognl.IteratorEnumeration;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.sennet.bizcommon.menu.MenuVo;
import com.sennet.common.StringUtil;
import com.sennet.exception.NotFoundException;

@Service
@Transactional
public class RoleService {

	@Autowired
	private RoleDao roleDao;

	@Autowired
	private ModelMapper modelMapper;
	
	private String currMenu="";
	public  String getCurrMenu()
	{
		return this.currMenu;
	}
	public  void setCurrMenu(String currmenu)
	{
		this.currMenu=currmenu;
	}
	
	// insert role
	public int saveTrRoleVoList(List<TrRoleVo> trRoleVoList) {
		// 로그인된 사용자의 정보 가져온다.
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = authentication.getName();

		Iterator<TrRoleVo> iter = trRoleVoList.iterator();
		boolean isDelete = false;
		TrRoleVo trRoleVo =null;
		while(iter.hasNext()){
			trRoleVo = iter.next();
			// 권한에 해당하는 모든 메뉴를 한번 삭제한다.
			if(!isDelete)
			{
				deleteRole(trRoleVo.getRoleCd());
				isDelete = true;
			}
			// 체크가 true인 것만 저장한다.
			if(trRoleVo.getChk()==null){continue;}
			if(trRoleVo.getChk().equals("true")){
				RoleVo roleVo = modelMapper.map(trRoleVo, RoleVo.class);
				roleVo.setFirstUserId( userId);
				roleVo.setFirstDatetime(StringUtil.currentDateString("yyyyMMddHHmmss"));
				roleVo.setLastUserId(userId);
				roleVo.setLastDatetime(StringUtil.currentDateString("yyyyMMddHHmmss"));
				roleDao.saveRole(roleVo);
			}
		}
		return 1;
	}
	// delete role
	public int deleteRole(String roleCd) {
		return roleDao.deleteRole(roleCd);
	}
	
	// 리스트 조회
	public List<TrRoleVo> searchListRole(String roleCd) {
		Map<String, Object> condition = new HashMap<String, Object>();		
		condition.put("roleCd", roleCd);
		return  roleDao.searchListRole(condition);
	}
}
