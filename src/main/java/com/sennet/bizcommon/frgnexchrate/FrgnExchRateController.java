package com.sennet.bizcommon.frgnexchrate;

import static org.springframework.web.bind.annotation.RequestMethod.DELETE;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.sennet.common.ErrorResponse;


@Controller
public class FrgnExchRateController {

	@Autowired
    private FrgnExchRateService frgnExchRateService;

    @Autowired
    private ModelMapper modelMapper;
	
  //CREATE
    @RequestMapping(value = "/rest/FrgnExchRate", method = POST)
    @ResponseBody
    public ResponseEntity<?> insert(@RequestBody @Valid FrgnExchRateVo paramVo, BindingResult result) {
		FrgnExchRateVo frgnExchRateVo = modelMapper.map(paramVo, FrgnExchRateVo.class);
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        int effectRows = frgnExchRateService.insertFrgnExchRate(paramVo);
        // insert Row 없음
        if(effectRows!=1){
            return new ResponseEntity<FrgnExchRateVo>(modelMapper.map(frgnExchRateVo,FrgnExchRateVo.class), HttpStatus.NOT_MODIFIED);
        }
        else{
            return new ResponseEntity<FrgnExchRateVo>(modelMapper.map(frgnExchRateVo,FrgnExchRateVo.class), HttpStatus.CREATED);
        	
        }
    }
	// search FrgnExchRate
    @RequestMapping(value = "/rest/searchListFrgnExchRate", params = {"startDate","endDate","quotSeq"}, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<FrgnExchRateVo> searchListFrgnExchRate(@RequestParam("startDate") String startDate, @RequestParam("endDate") String endDate, @RequestParam("quotSeq") int quotSeq) {
    	return frgnExchRateService.searchListFrgnExchRate(startDate, endDate, quotSeq);
    }
    
}
