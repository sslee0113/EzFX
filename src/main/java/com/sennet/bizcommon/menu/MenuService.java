package com.sennet.bizcommon.menu;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.sennet.common.StringUtil;
import com.sennet.exception.DuplicatedException;
import com.sennet.exception.NotFoundException;

@Service
@Transactional
public class MenuService {

	@Autowired
	private MenuDao menuDao;

	@Autowired
	private ModelMapper modelMapper;
	
	// insert menu
	public int insertMenu(MenuVo paramVo) {
		MenuVo menuVo = modelMapper.map(paramVo, MenuVo.class);
		MenuVo tempVo = findOneMenu(menuVo.getMenuId());
		if(tempVo!=null){
			throw new DuplicatedException("DuplicatedException key : ["+paramVo.getMenuId()+"]");
		}
		menuVo.setMenuId(paramVo.getMenuId());
		menuVo.setViewSeq(paramVo.getViewSeq());
		menuVo.setMenuUrl(paramVo.getMenuUrl());
		menuVo.setMenuName(paramVo.getMenuName());
		menuVo.setMenuCd(paramVo.getMenuCd());
		// 로그인된 사용자의 정보 가져온다.
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = authentication.getName();
		menuVo.setFirstUserId( userId);
		menuVo.setFirstDatetime(StringUtil.currentDateString("yyyyMMddHHmmss"));
		menuVo.setLastUserId(userId);
		menuVo.setLastDatetime(StringUtil.currentDateString("yyyyMMddHHmmss"));
		return menuDao.saveMenu(menuVo);
	}

	// Find One by PK
	public MenuVo findOneMenu(String menuId) {
		return menuDao.findOneMenu(menuId);
	}
	// update menu
	public int updateMenu(MenuVo paramVo) {
		MenuVo menuVo = menuDao.findOneMenu(paramVo.getMenuId());
		if (menuVo == null) {
			throw new NotFoundException(paramVo.getMenuId());
		}		
		menuVo.setViewSeq(paramVo.getViewSeq());
		menuVo.setMenuUrl(paramVo.getMenuUrl());
		menuVo.setMenuName(paramVo.getMenuName());
		menuVo.setMenuCd(paramVo.getMenuCd());
		// 로그인된 사용자의 정보 가져온다.
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		String userId = authentication.getName();
		menuVo.setLastUserId(userId);
		menuVo.setLastDatetime(StringUtil.currentDateString("yyyyMMddHHmmss"));
		
		return menuDao.saveMenu(menuVo);
	}

	// delete menu
	public MenuVo deleteMenu(String menuId) {
		MenuVo menuVo = menuDao.findOneMenu(menuId);
		if (menuVo == null) {
			throw new NotFoundException(menuId);
		}
		int effectRows = menuDao.deleteMenu(menuId);
		if(effectRows==1){
			return menuVo;
		}
		else{
			return null;
		}
	}
	
	// 리스트 조회
	public List<MenuVo> searchListMenu(String menuName) {
		Map<String, Object> condition = new HashMap<String, Object>();		
		condition.put("menuName", menuName);
		return menuDao.searchListMenu(condition);	
	}

}
