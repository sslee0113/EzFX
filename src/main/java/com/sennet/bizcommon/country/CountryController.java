package com.sennet.bizcommon.country;

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

import com.sennet.bizcommon.currency.CurrencyCodeResponseVo;
import com.sennet.common.ErrorResponse;


@Controller
public class CountryController {

	@Autowired
    private CountryService countryService;

    @Autowired
    private ModelMapper modelMapper;
	
  //CREATE
    @RequestMapping(value = "/rest/Country", method = POST)
    @ResponseBody
    public ResponseEntity<?> insert(@RequestBody @Valid CountryVo paramVo, BindingResult result) {
		CountryVo countryVo = modelMapper.map(paramVo, CountryVo.class);
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        int effectRows = countryService.insertCountry(paramVo);
        // insert Row 없음
        if(effectRows!=1){
            return new ResponseEntity<CountryVo>(modelMapper.map(countryVo,CountryVo.class), HttpStatus.NOT_MODIFIED);
        }
        else{
            return new ResponseEntity<CountryVo>(modelMapper.map(countryVo,CountryVo.class), HttpStatus.CREATED);
        	
        }
    }
    
    //READ ALL CTRYCODE
    @RequestMapping(value = "/rest/ctryCodeList", method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<CountryCodeResponseVo> readCtryList() {
    	return countryService.ctryCodeList();
    }
    
    //READ ALL CURRCODE
    @RequestMapping(value = "/rest/ctryCurrCodeList", method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<CountryCodeResponseVo> readCurrList() {
    	return countryService.ctryCurrCodeList();
    }

    //UPDATE ONE
    @RequestMapping(value = "/rest/Country", method = PUT)
    @ResponseBody
    public ResponseEntity<?> update(@RequestBody @Valid CountryVo paramVo, BindingResult result) {
		CountryVo countryVo = modelMapper.map(paramVo, CountryVo.class);
    	if (result.hasErrors()) {
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }
        int effectRows = countryService.updateCountry(countryVo);
        // update Row 없음
        if(effectRows!=1){
            return new ResponseEntity<CountryVo>(modelMapper.map(countryVo,CountryVo.class), HttpStatus.NOT_MODIFIED);
        }
        // 정상수행
        else{
            return new ResponseEntity<CountryVo>(modelMapper.map(countryVo,CountryVo.class), HttpStatus.OK);
        	
        }
    } 
    
    //DELETE ONE
    @RequestMapping(value = "/rest/Country/{ctryCode}", method = DELETE)
    @ResponseBody
    public ResponseEntity<?> delete(@PathVariable("ctryCode") String ctryCode) {
    	CountryVo vo = new CountryVo();
		CountryVo countryVo = modelMapper.map(vo, CountryVo.class);
        int effectRows = countryService.delete(ctryCode);
        // 수정 없음.
        if(effectRows!=1){
            return new ResponseEntity<CountryVo>(modelMapper.map(countryVo,CountryVo.class), HttpStatus.NOT_MODIFIED);
        }
        // 정상수행
        else{
            return new ResponseEntity<CountryVo>(modelMapper.map(countryVo,CountryVo.class), HttpStatus.OK);
        }
    }
	// search Country
    @RequestMapping(value = "/rest/searchListCountry", params = {"ctryCode"}, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<CountryVo> searchListCountry(@RequestParam("ctryCode") String ctryCode) {
    	return countryService.searchListCountry(ctryCode);
    }

}
