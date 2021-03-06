package com.sennet.remittance;

import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.PUT;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.sennet.accounting.AccountingCnclPrcService;
import com.sennet.common.ErrorMsg;
import com.sennet.common.ErrorResponse;
import com.sennet.exception.NotFoundException;
import com.sennet.exception.NotValidException;
import com.sennet.userprofile.UserProfileService;

import lombok.extern.slf4j.Slf4j;


@Controller
@Transactional
@Slf4j
public class RemittanceController {

    @Autowired
    private RemittanceService remittanceService;

    @Autowired
    private ModelMapper modelMapper;
    
    @Autowired
    private AccountingCnclPrcService accountingCnclPrcService;
    
    @Autowired
    private UserProfileService userProfileService;
	
    
    // Insert
    @RequestMapping(value = "/rest/remittance", method = POST)
    @ResponseBody
    public ResponseEntity<?> insertRemittance(@RequestBody @Valid RemittanceVo remittanceVo, BindingResult result) {
    	RemittanceVo resultRemittanceVo = null;
    	if (result.hasErrors()) {

        	ErrorMsg errMsg = new ErrorMsg();
            return new ResponseEntity<ErrorResponse>(errMsg.getBindingResultErrMsg("OR", result), HttpStatus.BAD_REQUEST);
        }
        try{
        	
        	remittanceVo.setTrBrno(userProfileService.getLoginUserBrno());
        	remittanceVo.setFeeAmt(BigDecimal.ZERO);
        	remittanceVo.setFeeAmtWna(BigDecimal.ZERO);
        	remittanceVo.setDrwbAmt(BigDecimal.ZERO);
        	remittanceVo.setHdyTrYn("N");
        	remittanceVo.setClosAfTrYn("N");

        	resultRemittanceVo= remittanceService.insertRemittance(remittanceVo);
			
			if(resultRemittanceVo ==null){
	        	ErrorResponse errorResponse = new ErrorResponse();
	            errorResponse.setMessage("???????????? ?????? ????????? ??????????????????. ??????????????? ???????????????.");
	            errorResponse.setCode("bad.request");
	            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
	        }
        }catch(Exception e){
        	
        	TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
        	
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage(e.getMessage());
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        return new ResponseEntity<RemittanceVo>(modelMapper.map(resultRemittanceVo, RemittanceVo.class), HttpStatus.CREATED);
    }
    
 
    
    //READ ALL ABOUT TRDT AND REF_NO
    @RequestMapping(value = "/rest/remittance", params = { "startDate", "endDate", "refNo" }, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<RemittanceVo> readAll(@RequestParam("startDate") String startDate, @RequestParam("endDate") String endDate, @RequestParam("refNo") String refNo) {

        List<RemittanceVo> remittanceVoList = remittanceService.getRemittanceVoList(startDate,endDate,refNo);
        return remittanceVoList;
    }  
    
    /*
    
	// ??????????????????
    @RequestMapping(value = "/rest/remittanceList", params = { "startDate", "endDate", "trBrno" }, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public RemittanceDto.ResponseList readList(@RequestParam("startDate") String startDate, @RequestParam("endDate") String endDate, 
    		@RequestParam("trBrno") String trBrno) {

        List<Remittance> allRemittance;
        
		if(trBrno != null && !trBrno.equals("")){

			allRemittance = repository.findByTrDtBetweenAndTrBrnoOrderByTrDtAscRefNoAsc(startDate, endDate, trBrno);
		}else{
			
			allRemittance = repository.findByTrDtBetweenOrderByTrDtAscRefNoAsc(startDate, endDate);
		}

        java.lang.reflect.Type targetListType = new TypeToken<List<RemittanceDto.Response>>() {}.getType();
        List<RemittanceDto.Response> content = modelMapper.map(allRemittance, targetListType);        
        
        RemittanceDto.ResponseList responseList = new RemittanceDto.ResponseList();
        responseList.setTotal(content.size());
        responseList.setRows(content);
        
    	return responseList;   	
    }  
    */
    
    //????????????, ????????????, ????????????, ???????????? ??????
    @RequestMapping(value = "/rest/remittancePreCalc", params = { "rmtKdcd", "ntcd", "crcd", "prmRt", "owmnAmt" }, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public RemittanceVo preCalc(
    		@RequestParam("rmtKdcd") String rmtKdcd,      // ????????????
    		@RequestParam("ntcd") String ntcd,            // ????????????
    		@RequestParam("crcd") String crcd,            // ????????????
    		@RequestParam("prmRt") BigDecimal prmRt,      // ?????????
    		@RequestParam("owmnAmt") BigDecimal owmnAmt)  // ??????????????????
    				throws Exception{

    	return remittanceService.getRemittancePreCalc(rmtKdcd,ntcd,crcd,prmRt,owmnAmt);   	
    }   

    //????????????, ????????????, ????????????, ???????????? ??????
    @RequestMapping(value = "/rest/remittanceTotal", params = { "trBrno","trDt", "crcd" }, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<RemittanceTotalVo> readTotalList(@RequestParam("trBrno") String trBrno , @RequestParam("trDt") String trDt, @RequestParam("crcd") String crcd) throws Exception{

		return remittanceService.getRemittanceTotal (trBrno,trDt, crcd);
    }   
    
	// ??????????????????
    @RequestMapping(value = "/rest/remittanceSubList", params = { "trBrno", "trDt", "crcd" }, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<RemittanceVo> readList(@RequestParam("trBrno") String trBrno,@RequestParam("trDt") String trDt, @RequestParam("crcd") String crcd) {
		return remittanceService.getRemittanceSubList (trBrno,trDt, crcd);
    }  
    
	// READ One
    @RequestMapping(value = "/rest/remittance/{refNo}", method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<RemittanceVo> readrefNoOne(@PathVariable String refNo) {
        
        return remittanceService.readrefNoOne(refNo) ;
    }
   
    //UPDATE ONE
    @RequestMapping(value = "/rest/remittance/{refNo}", method = PUT)
    @ResponseBody
    public ResponseEntity<?> update(@PathVariable String refNo, @RequestBody @Valid RemittanceVo remittanceVo, BindingResult result) {
        if (result.hasErrors()) {
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }
        // ??????????????? ??????????????? ?????? ????????? ?????????
        try{
        	accountingCnclPrcService.cnclProc(refNo);
        }catch(NotValidException nve){
        	ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage(nve.getParam());
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }catch(Exception e){
        	ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage(e.getMessage());
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        int effectRows = remittanceService.update(refNo);
        if(effectRows==1){
            return new ResponseEntity<RemittanceVo>(modelMapper.map(remittanceVo, RemittanceVo.class),HttpStatus.OK);
        }
        else{
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }
    }   
    
    // ????????? ???????????? ?????? ???????????? ???????????? ????????? ExceptionHandler ??? ????????????.
    @ExceptionHandler(NotFoundException.class)
    public ResponseEntity<?> handleNotFoundException(NotFoundException ex,
        HttpServletResponse response) throws IOException {
    	
    	ErrorResponse errorResponse = new ErrorResponse();
        errorResponse.setMessage(ex.getName());
        errorResponse.setCode("bad.request");
        return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
    }
    
    // ????????? ???????????? ?????? ???????????? ???????????? ????????? ExceptionHandler ??? ????????????.
    @ExceptionHandler(NotValidException.class)
    public ResponseEntity<?> handleNotFoundException(NotValidException ex,
        HttpServletResponse response) throws IOException {
    	
    	ErrorResponse errorResponse = new ErrorResponse();
        errorResponse.setMessage(ex.getParam());
        errorResponse.setCode("bad.request");
        
        return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
    } 
    
    // ?????? 
    @ExceptionHandler(Exception.class)
    public ResponseEntity<?> handleException(Exception ex,
        HttpServletResponse response) throws IOException {
    	
    	ErrorResponse errorResponse = new ErrorResponse();
        errorResponse.setMessage("????????? ????????? ??????????????????. ??????????????? ???????????????. ????????????:"+ex.getMessage());
        errorResponse.setCode("bad.request");
        return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
    }
}
