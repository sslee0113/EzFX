package com.sennet.bizcommon.menu;

import static org.springframework.web.bind.annotation.RequestMethod.DELETE;


import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.PUT;

import java.util.List;

import javax.validation.Valid;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import com.sennet.common.ErrorResponse;
import com.sennet.exception.NotFoundException;


@Controller
public class MenuController {

    @Autowired
    private MenuService menuService;

    @Autowired
    private ModelMapper modelMapper;
	
    //CREATE
    @RequestMapping(value = "/rest/menu", method = POST)
    @ResponseBody
    public ResponseEntity<?> insert(@RequestBody @Valid MenuVo paramVo, BindingResult result) {
		MenuVo menuVo = modelMapper.map(paramVo, MenuVo.class);
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        int effectRows = menuService.insertMenu(paramVo);
        // insert Row 없음
        if(effectRows==1){
            return new ResponseEntity<MenuVo>(modelMapper.map(menuVo,MenuVo.class), HttpStatus.CREATED);
        }
        else{
            return new ResponseEntity<MenuVo>(modelMapper.map(menuVo,MenuVo.class), HttpStatus.NOT_MODIFIED);
        }
    }

    //UPDATE ONE
    @RequestMapping(value = "/rest/menu", method = PUT)
    @ResponseBody
    public ResponseEntity<?> update(@RequestBody @Valid MenuVo paramVo, BindingResult result) {
		MenuVo menuVo = modelMapper.map(paramVo, MenuVo.class);
    	if (result.hasErrors()) {
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }
        int effectRows = menuService.updateMenu(menuVo);
        // update Row 없음
        if(effectRows!=1){
            return new ResponseEntity<MenuVo>(modelMapper.map(menuVo,MenuVo.class), HttpStatus.NOT_MODIFIED);
        }
        // 정상수행
        else{
            return new ResponseEntity<MenuVo>(modelMapper.map(menuVo,MenuVo.class), HttpStatus.OK);
        	
        }
    } 
    
    //DELETE ONE
    @RequestMapping(value = "/rest/menu/{menuId}", method = DELETE)
    @ResponseBody
    public ResponseEntity<?> delete(@PathVariable("menuId") String menuId) {
        MenuVo resultmenuVo = menuService.deleteMenu(menuId);
        // update Row 없음
        if(resultmenuVo == null){
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("해당코드를 삭제하지 못했습니다.");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.NOT_FOUND);
        }
        // 정상수행
        else{
            return new ResponseEntity<MenuVo>(modelMapper.map(resultmenuVo,MenuVo.class), HttpStatus.OK);
        }
    }
	// search CommonDcode
    @RequestMapping(value = "/rest/menu/searchListMenu", params = {"menuName"}, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<MenuVo> searchListMenu(@RequestParam("menuName") String menuName) {
    	return menuService.searchListMenu(menuName);
    } 

    
}
