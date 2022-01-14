package com.sennet.bizcommon.fee;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.sennet.common.ErrorResponse;

@Controller
public class FeeController {

	@Autowired
    private FeeService service;

    @Autowired
    private ModelMapper modelMapper;
	
  //CREATE
    @RequestMapping(value = "/rest/Fee", method = POST)
    @ResponseBody
    public ResponseEntity<?> insert(@RequestBody @Valid FeeVo paramVo, BindingResult result) {
		FeeVo feeVo = modelMapper.map(paramVo, FeeVo.class);
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        int effectRows = service.insertFee(paramVo);
        // insert Row 없음
        if(effectRows!=1){
            return new ResponseEntity<FeeVo>(modelMapper.map(feeVo,FeeVo.class), HttpStatus.NOT_MODIFIED);
        }
        else{
            return new ResponseEntity<FeeVo>(modelMapper.map(feeVo,FeeVo.class), HttpStatus.CREATED);
        	
        }
    }

    //UPDATE ONE
    @RequestMapping(value = "/rest/Fee", method = PUT)
    @ResponseBody
    public ResponseEntity<?> update(@RequestBody @Valid FeeVo paramVo, BindingResult result) {
		FeeVo feeVo = modelMapper.map(paramVo, FeeVo.class);
    	if (result.hasErrors()) {
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }
        int effectRows = service.updateFee(feeVo);
        // update Row 없음
        if(effectRows!=1){
            return new ResponseEntity<FeeVo>(modelMapper.map(feeVo,FeeVo.class), HttpStatus.NOT_MODIFIED);
        }
        // 정상수행
        else{
            return new ResponseEntity<FeeVo>(modelMapper.map(feeVo,FeeVo.class), HttpStatus.OK);
        	
        }
    }
    
	// search Fee
    @RequestMapping(value = "/rest/searchListFee", params = {"rmtKdcd", "ntcd", "crcd", "aplStrtDt", "aplEndDt", "aplStrtAmt", "aplEndAmt"}, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<FeeVo> searchListFee(
    		@RequestParam("rmtKdcd") String rmtKdcd,
    		@RequestParam("ntcd") String ntcd,
    		@RequestParam("crcd") String crcd,
    		@RequestParam("aplStrtDt") String aplStrtDt,
    		@RequestParam("aplEndDt") String aplEndDt,
    		@RequestParam("aplStrtAmt") String aplStrtAmt,
    		@RequestParam("aplEndAmt") String aplEndAmt
    		) {
    	return service.searchListFee(rmtKdcd,ntcd,crcd,aplStrtDt,aplEndDt,aplStrtAmt,aplEndAmt);
    }
    
}
