package com.sennet.bizcommon.iflog;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.PUT;

import java.util.List;

import javax.validation.Valid;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.sennet.bizcommon.customer.CustomerVo;
import com.sennet.common.ErrorResponse;


@Controller
public class InterfaceLogController {

    @Autowired
    private InterfaceLogService interfaceLogService;

    @Autowired
    private ModelMapper modelMapper;
	
    //CREATE
    @RequestMapping(value = "/rest/InterfaceLog", method = POST)
    @ResponseBody
    public ResponseEntity<?> insertInterfaceLog(@RequestBody @Valid InterfaceLogVo paramVo, BindingResult result) {
		InterfaceLogVo InterfaceLogVo = modelMapper.map(paramVo, InterfaceLogVo.class);
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        int effectRows = interfaceLogService.insertInterfaceLog(paramVo);
        // insert Row 없음
        if(effectRows!=1){
            return new ResponseEntity<InterfaceLogVo>(modelMapper.map(InterfaceLogVo,InterfaceLogVo.class), HttpStatus.NOT_MODIFIED);
        }
        else{
            return new ResponseEntity<InterfaceLogVo>(modelMapper.map(InterfaceLogVo,InterfaceLogVo.class), HttpStatus.CREATED);
        	
        }
    }

    //UPDATE ONE
    @RequestMapping(value = "/rest/InterfaceLog", method = PUT)
    @ResponseBody
    public ResponseEntity<?> update(@RequestBody @Valid InterfaceLogVo paramVo, BindingResult result) {
		InterfaceLogVo interfaceLogVo = modelMapper.map(paramVo, InterfaceLogVo.class);
    	if (result.hasErrors()) {
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }
        int effectRows = interfaceLogService.updateInterfaceLog(interfaceLogVo);
        // update Row 없음
        if(effectRows!=1){
            return new ResponseEntity<InterfaceLogVo>(modelMapper.map(interfaceLogVo,InterfaceLogVo.class), HttpStatus.NOT_MODIFIED);
        }
        // 정상수행
        else{
            return new ResponseEntity<InterfaceLogVo>(modelMapper.map(interfaceLogVo,InterfaceLogVo.class), HttpStatus.OK);
        }
    }
    
    //ReadAll
    @RequestMapping(value = "/rest/searchListInterfaceLog", params = { "startDate", "endDate", "trYn", "bizType" }, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public PageImpl<InterfaceLogVo> searchListInterfaceLog(
    		@RequestParam("startDate") String startDate,
    		@RequestParam("endDate") String endDate,
    		@RequestParam("trYn") String trYn,
    		@RequestParam("bizType") String bizType, 
    		Pageable pageable) {
        return interfaceLogService.searchListInterfaceLogPageable(startDate, endDate, trYn, bizType,pageable);
    }
    
}
