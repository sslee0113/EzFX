package com.sennet.webaccesslog;

import static org.springframework.web.bind.annotation.RequestMethod.POST;

import javax.validation.Valid;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sennet.common.ErrorResponse;


@Controller
public class WebAccessLogController {

    @Autowired
    private WebAccessLogService service;
    @Autowired
    private ModelMapper modelMapper;
    
    //CREATE
    @RequestMapping(value = "/rest/event", method = POST)
    @ResponseBody
    public ResponseEntity<?> create(@RequestBody @Valid WebAccessLogVo webAccessLogVo, BindingResult result) {
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }

        WebAccessLogVo tmpVo = service.insertWebAccessLog(webAccessLogVo);
        if(tmpVo!=null){
            return new ResponseEntity<WebAccessLogVo>(modelMapper.map(tmpVo, WebAccessLogVo.class), HttpStatus.CREATED);
        }
        else{
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
    }
}
