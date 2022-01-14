package com.sennet.bizcommon.frgnexchratenotice;

import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.GET;

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

import com.sennet.bizcommon.country.CountryVo;
import com.sennet.common.ErrorResponse;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class FrgnExchRateNoticeController {

	@Autowired
    private FrgnExchRateNoticeService frgnExchRateNoticeService;
	
    @Autowired
    private ModelMapper modelMapper;
    
    //CREATE
    @ResponseBody
    @RequestMapping(value = "/rest/frgnexchratenotice", method = POST)
//    public ResponseEntity create(@RequestBody @Valid FrgnExchRateNoticeDto.Create create,
    public ResponseEntity<?> create(@RequestBody @Valid List<FrgnExchRateNoticeVo> voList,BindingResult result) {
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        int effectRows = frgnExchRateNoticeService.insertExchRateNotice(voList);
        if(effectRows==1){
            return new ResponseEntity<FrgnExchRateNoticeVo>(modelMapper.map(voList.get(0), FrgnExchRateNoticeVo.class), HttpStatus.CREATED);
        }
        else{
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
    }
    
 // READ Notice currency list
    @RequestMapping(value = "/rest/frgnexchratenotice/{valDate}", method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<FrgnExchRateNoticeVo> findByValDateOrderByCurrCodeAsc(@PathVariable String valDate) {
    	
    	FrgnExchRateNoticeVo frgnExchRateNoticeVo = new FrgnExchRateNoticeVo();
    	frgnExchRateNoticeVo.setValDate(valDate);
    	
    	List<FrgnExchRateNoticeVo> list = frgnExchRateNoticeService.findByValDateOrderByCurrCodeAsc(frgnExchRateNoticeVo);
        
    	return list;
    }
}
