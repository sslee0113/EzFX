package com.sennet.exchange;

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
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.sennet.accounting.AccountingCnclPrcService;
import com.sennet.common.ErrorResponse;
import com.sennet.exception.NotFoundException;
import com.sennet.exception.NotValidException;
import com.sennet.remittance.RemittanceVo;
import com.sennet.userprofile.UserProfileService;


@Controller
@Transactional
public class ExchangeController {

    @Autowired
    private ExchangeService exchangeService;

    @Autowired
    private ModelMapper modelMapper;
    
    @Autowired
    private AccountingCnclPrcService cancel;
    
    @Autowired
    private UserProfileService userProfileService;
	
    //CREATE
    @RequestMapping(value = "/rest/exchange", method = POST)
    @ResponseBody
    public ResponseEntity<?> create(@RequestBody @Valid ExchangeVo paramVo, BindingResult result) throws Exception {
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("????????? ???????????????.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }

        ExchangeVo exchangeVo = modelMapper.map(paramVo, ExchangeVo.class);
        // ??????????????????
		// ???????????? ???????????? ????????? ????????????.
        paramVo.setBrno(userProfileService.getLoginUserBrno());
        int effectRows  = exchangeService.insertExchange(paramVo);
        
        if(effectRows == 1){
            return new ResponseEntity<ExchangeVo>(modelMapper.map(exchangeVo,ExchangeVo.class), HttpStatus.CREATED);
        }
        else{
        	ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("?????? ???????????? ????????? ??????.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.NOT_MODIFIED);
        }
    }
    
    
    //????????????, ????????????, ????????????, ???????????? ??????
    @RequestMapping(value = "/rest/exchangePreCalc", params = { "crcd", "prmRt", "pmnyAmt", "cnAmt", "efmDscd" }, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public ExchangeVo preCalc(@RequestParam("crcd") String crcd, @RequestParam("prmRt") BigDecimal prmRt,@RequestParam("pmnyAmt") BigDecimal pmnyAmt, @RequestParam("cnAmt") BigDecimal cnAmt,
    		@RequestParam("efmDscd") String efmDscd) throws Exception{
    	return exchangeService.preCalc(crcd,prmRt,pmnyAmt,cnAmt,efmDscd);
    }

    
    //UPDATE ONE
    @RequestMapping(value = "/rest/exchange/{refNo}", method = PUT)
    @ResponseBody
    public ResponseEntity<?> update(@PathVariable String refNo,  @RequestBody @Valid ExchangeVo exchangeVo,BindingResult result) {
            if (result.hasErrors()) {
                return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
            }
            // ??????????????? ??????????????? ?????? ????????? ?????????
            try{
    			cancel.cnclProc(refNo);
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

            int effectRows = exchangeService.updateExchange(refNo);

            if(effectRows ==1){
                return new ResponseEntity<ExchangeVo>(modelMapper.map(exchangeVo,ExchangeVo.class), HttpStatus.CREATED);
            }
            else{
            	ErrorResponse errorResponse = new ErrorResponse();
                errorResponse.setCode("bad.request");
                return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
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
    public ResponseEntity<?> handleException(Exception ex, HttpServletResponse response) throws IOException {
    	
    	ErrorResponse errorResponse = new ErrorResponse();
        errorResponse.setMessage("????????? ????????? ??????????????????. ??????????????? ???????????????. ????????????:"+ex.getMessage());
        errorResponse.setCode("bad.request");
        return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
    }
    
	// ??????????????????
    @RequestMapping(value = "/rest/exchangeSearchList", params = { "startDate", "endDate", "brno", "efmDscd","refNo" }, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<ExchangeVo> searchList(@RequestParam("startDate") String startDate, @RequestParam("endDate") String endDate,@RequestParam("brno") String brno, @RequestParam("efmDscd") String efmDscd,@RequestParam("refNo") String refNo) {
    	return exchangeService.searchList(startDate,endDate,brno,efmDscd,refNo);
    }

    
	// ???????????????????????? ???????????? ??????
    @RequestMapping(value = "/rest/exchange/{refNo}", method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<ExchangeVo> findExchangeList(@PathVariable String refNo) {
    	return exchangeService.searchList("","","","",refNo);
    }
}
