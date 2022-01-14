package com.sennet.bizcommon.commondcode;

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


@Controller
public class CommonDcodeController {

    @Autowired
    private CommonDcodeService service;

    @Autowired
    private ModelMapper modelMapper;
	
    //CREATE
    @RequestMapping(value = "/rest/CommonDcode", method = POST)
    @ResponseBody
    public ResponseEntity<?> create(@RequestBody @Valid CommonDcodeVo paramVo, BindingResult result) {
		CommonDcodeVo CommonDcodeVo = modelMapper.map(paramVo, CommonDcodeVo.class);
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        int effectRows = service.insertCommonDcode(paramVo);
        // insert Row 없음
        if(effectRows!=1){
            return new ResponseEntity<CommonDcodeVo>(modelMapper.map(CommonDcodeVo,CommonDcodeVo.class), HttpStatus.NOT_MODIFIED);
        }
        else{
            return new ResponseEntity<CommonDcodeVo>(modelMapper.map(CommonDcodeVo,CommonDcodeVo.class), HttpStatus.OK);
        	
        }
    }

    //UPDATE ONE
    @RequestMapping(value = "/rest/CommonDcode", method = PUT)
    @ResponseBody
    public ResponseEntity<?> update(@RequestBody @Valid CommonDcodeVo paramVo, BindingResult result) {
		CommonDcodeVo CommonDcodeVo = modelMapper.map(paramVo, CommonDcodeVo.class);
    	if (result.hasErrors()) {
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }
        int effectRows = service.updateCommonDcode(CommonDcodeVo);
        // update Row 없음
        if(effectRows!=1){
            return new ResponseEntity<CommonDcodeVo>(modelMapper.map(CommonDcodeVo,CommonDcodeVo.class), HttpStatus.NOT_MODIFIED);
        }
        // 정상수행
        else{
            return new ResponseEntity<CommonDcodeVo>(modelMapper.map(CommonDcodeVo,CommonDcodeVo.class), HttpStatus.OK);
        	
        }
    }
    //delete ONE
    @RequestMapping(value = "/rest/CommonDcode", method = DELETE)
    @ResponseBody
    public ResponseEntity<?> delete(@RequestBody @Valid CommonDcodeVo paramVo, BindingResult result) {
		CommonDcodeVo CommonDcodeVo = modelMapper.map(paramVo, CommonDcodeVo.class);
    	if (result.hasErrors()) {
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }
        int effectRows = service.deleteCommonDcode(CommonDcodeVo);
        // delete Row 없음
        if(effectRows!=1){
            return new ResponseEntity<CommonDcodeVo>(modelMapper.map(CommonDcodeVo,CommonDcodeVo.class), HttpStatus.NOT_FOUND);
        }
        // 정상수행
        else{
            return new ResponseEntity<CommonDcodeVo>(modelMapper.map(CommonDcodeVo,CommonDcodeVo.class), HttpStatus.OK);
        }
    } 
    

	// search List CommonDcode from gcode
    @RequestMapping(value = "/rest/searchListCommonDcode", params = { "gcode"}, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<CommonDcodeVo> searchListCommonDcode(@RequestParam("gcode") String gcode) {
    	return service.searchListCommonDcode(gcode);
    } 
    
}
