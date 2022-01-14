package com.sennet.bizcommon.currency;

import static org.springframework.web.bind.annotation.RequestMethod.DELETE;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.PUT;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.validation.Valid;

import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
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
public class CurrencyController {

    @Autowired
    private CurrencyService currencyService;

    @Autowired
    private ModelMapper modelMapper;
	
  //CREATE
    @RequestMapping(value = "/rest/Currency", method = POST)
    @ResponseBody
    public ResponseEntity<?> insert(@RequestBody @Valid CurrencyVo paramVo, BindingResult result) {
		CurrencyVo currencyVo = modelMapper.map(paramVo, CurrencyVo.class);
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        int effectRows = currencyService.insertCurrency(paramVo);
        // insert Row 없음
        if(effectRows!=1){
            return new ResponseEntity<CurrencyVo>(modelMapper.map(currencyVo,CurrencyVo.class), HttpStatus.NOT_MODIFIED);
        }
        else{
            return new ResponseEntity<CurrencyVo>(modelMapper.map(currencyVo,CurrencyVo.class), HttpStatus.CREATED);
        	
        }
    }
    
  //READ ALL CURRCODE
    @RequestMapping(value = "/rest/currCodeList", method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<CurrencyCodeResponseVo> readList() {
    	return currencyService.currCodeList();
    }

    //UPDATE ONE
    @RequestMapping(value = "/rest/Currency", method = PUT)
    @ResponseBody
    public ResponseEntity<?> update(@RequestBody @Valid CurrencyVo paramVo, BindingResult result) {
		CurrencyVo currencyVo = modelMapper.map(paramVo, CurrencyVo.class);
    	if (result.hasErrors()) {
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }
        int effectRows = currencyService.updateCurrency(currencyVo);
        // update Row 없음
        if(effectRows!=1){
            return new ResponseEntity<CurrencyVo>(modelMapper.map(currencyVo,CurrencyVo.class), HttpStatus.NOT_MODIFIED);
        }
        // 정상수행
        else{
            return new ResponseEntity<CurrencyVo>(modelMapper.map(currencyVo,CurrencyVo.class), HttpStatus.OK);
        	
        }
    } 
    
    //DELETE ONE
    @RequestMapping(value = "/rest/Currency/{currCode}", method = DELETE)
    @ResponseBody
    public ResponseEntity<?> delete(@PathVariable("currCode") String currCode) {
    	CurrencyVo vo = new CurrencyVo();
		CurrencyVo currencyVo = modelMapper.map(vo, CurrencyVo.class);
        int effectRows = currencyService.delete(currCode);
        // 수정 없음.
        if(effectRows!=1){
            return new ResponseEntity<CurrencyVo>(modelMapper.map(currencyVo,CurrencyVo.class), HttpStatus.NOT_MODIFIED);
        }
        // 정상수행
        else{
            return new ResponseEntity<CurrencyVo>(modelMapper.map(currencyVo,CurrencyVo.class), HttpStatus.OK);
        }
    }
	// search Currency
    @RequestMapping(value = "/rest/searchListCurrency", params = {"currCode"}, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<CurrencyVo> searchListCurrency(@RequestParam("currCode") String currCode) {
    	return currencyService.searchListCurrency(currCode);
    }
    
}
