package com.sennet.accounting.bs;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;

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

import com.sennet.bizcommon.commoncode.CommonCodeVo;
import com.sennet.common.ErrorResponse;


@Controller
public class BsController {

    @Autowired
    private BsService bsService;

    @Autowired
    private ModelMapper modelMapper;
	
    @Autowired
    private BsDao bsDao;
    
    //CREATE
    @RequestMapping(value = "/rest/bs", method = POST)
    @ResponseBody
    public ResponseEntity<?> insertBs(@RequestBody @Valid BsVo paramVo, BindingResult result) {
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        BsVo bsVo = modelMapper.map(paramVo, BsVo.class);
        int effectRows =  bsService.insertBs(paramVo);
        if(effectRows==1){
            return new ResponseEntity<BsVo>(modelMapper.map(bsVo,BsVo.class), HttpStatus.CREATED);
        }
        // insert Row 없음
        else{
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("저장 실패.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
    }
 
    
    //READ ALL
    @RequestMapping(value = "/rest/bs", params = { "actgTrDt", "brno" }, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<BsResponseVo> readAll(@RequestParam("actgTrDt") String actgTrDt, @RequestParam("brno") String brno) {
        
        return bsService.searchListBs(actgTrDt,brno);
    }  
    
    //READ ALL FOR SUM
    @RequestMapping(value = "/rest/bsSum", params = { "actgTrDt", "brno" }, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<BsResponseSumVo> readAllSum(@RequestParam("actgTrDt") String actgTrDt, @RequestParam("brno") String brno) {
    	return bsService.readAllSum(actgTrDt, brno);
        
    }  
}
