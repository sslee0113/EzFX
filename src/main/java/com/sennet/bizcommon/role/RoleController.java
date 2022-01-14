package com.sennet.bizcommon.role;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

import java.util.List;

import javax.validation.Valid;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.sennet.common.ErrorResponse;


@Controller
public class RoleController {

    @Autowired
    private RoleService roleService;

    @Autowired
    private ModelMapper modelMapper;
	
    //save trRoleVoList list
    @RequestMapping(value = "/rest/role", method = POST)
    @ResponseBody
    public ResponseEntity<?> saveList(@RequestBody @Valid List<TrRoleVo> trRoleVoList, BindingResult result) {
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        int effectRow = roleService.saveTrRoleVoList(trRoleVoList);
        // insert Row 없음
        if(effectRow != 1){
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        else{
        	TrRoleVo vo = new TrRoleVo();
            return new ResponseEntity<TrRoleVo>(modelMapper.map(vo,TrRoleVo.class), HttpStatus.CREATED);
        }
    }

    // search CommonDcode
    @RequestMapping(value = "/rest/role/searchListRole", params = {"roleCd"}, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<TrRoleVo> searchListRole(@RequestParam("roleCd") String roleCd) {
    	return roleService.searchListRole(roleCd);
    } 

    
}
