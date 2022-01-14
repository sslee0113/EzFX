package com.sennet.accounting;

import static org.springframework.web.bind.annotation.RequestMethod.DELETE;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.sennet.common.ErrorResponse;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class AccountingController {

	@Autowired
    private GlCodeService glCodeService;
	
	@Autowired
    private GlMasterService glMasterService;
	
	@Autowired
    private GlDetailService glDetailService;
    @Autowired
    private ModelMapper modelMapper;
    
    //Insert GlCode
    @RequestMapping(value = "/rest/accountingGlCode", method = POST)
    @ResponseBody
    public ResponseEntity<?> accountingGlCode(@RequestBody @Valid GlCodeVo paramVo, BindingResult result) {
    	GlCodeVo glCodeVo = modelMapper.map(paramVo, GlCodeVo.class);
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        
        
        
        int effectRows = glCodeService.insertGlCode(glCodeVo);
        // insert Row 없음
        if(effectRows==1){
            return new ResponseEntity<GlCodeVo>(modelMapper.map(glCodeVo,GlCodeVo.class), HttpStatus.CREATED);
        }
        else{
            return new ResponseEntity<GlCodeVo>(modelMapper.map(glCodeVo,GlCodeVo.class), HttpStatus.NOT_MODIFIED);
        }
    }
    
    //Insert GlMaster
    @RequestMapping(value = "/rest/accountingGlMaster", method = POST)
    @ResponseBody
    public ResponseEntity<?> glMasterCreate(@RequestBody @Valid GlMasterVo paramVo, BindingResult result) {
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        GlMasterVo glMasterVo = modelMapper.map(paramVo, GlMasterVo.class);
        int effetRows = glMasterService.insertGlMaster(glMasterVo);
        if(effetRows == 1)
        {
            return new ResponseEntity<GlMasterVo>(modelMapper.map(glMasterVo, GlMasterVo.class), HttpStatus.CREATED);
        }
        else
        {
            return new ResponseEntity<GlMasterVo>(modelMapper.map(glMasterVo, GlMasterVo.class), HttpStatus.NOT_MODIFIED);
        }
    }   

    //Insert GlDetail
    @RequestMapping(value = "/rest/accountingGlDetail", method = POST)
    @ResponseBody
    public ResponseEntity<?> glDetailInsert(@RequestBody @Valid GlDetailVo paramVo, BindingResult result) {
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        GlDetailVo glDetailVo = modelMapper.map(paramVo, GlDetailVo.class);
        int effetRows = glDetailService.insertGlDetail(glDetailVo);
        if(effetRows == 1)
        {
            return new ResponseEntity<GlDetailVo>(modelMapper.map(glDetailVo, GlDetailVo.class), HttpStatus.CREATED);
        }
        else
        {
            return new ResponseEntity<GlDetailVo>(modelMapper.map(glDetailVo, GlDetailVo.class), HttpStatus.NOT_MODIFIED);
        }
    }

    //READ GlCode UPDATE ONE
    @RequestMapping(value = "/rest/accountingGlCode/{acsjCd}", method = PUT)
    @ResponseBody
    public ResponseEntity<?> update(@PathVariable String acsjCd,@RequestBody @Valid GlCodeVo paramGlCodeVo, BindingResult result) {
        if (result.hasErrors()) {
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }

        int effectRows = glCodeService.update(acsjCd, paramGlCodeVo);
        if(effectRows == 1)
        {
            return new ResponseEntity<GlCodeVo>(modelMapper.map(paramGlCodeVo, GlCodeVo.class), HttpStatus.CREATED);
        }
        else
        {
            return new ResponseEntity<GlCodeVo>(modelMapper.map(paramGlCodeVo, GlCodeVo.class), HttpStatus.NOT_MODIFIED);
        }
    }
    
    // GlCode DELETE ONE
    @RequestMapping(value = "/rest/accountingGlCode/{acsjCd}", method = DELETE)
    @ResponseBody
    public ResponseEntity<?> delete(@PathVariable String acsjCd) {
    	GlCodeVo glCodeVo = glCodeService.readByAcsjCd(acsjCd);
        int effectRows = glCodeService.delete(acsjCd);
        if(effectRows == 1)
        {
            return new ResponseEntity<GlCodeVo>(modelMapper.map(glCodeVo, GlCodeVo.class), HttpStatus.CREATED);
        }
        else
        {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("해당코드("+acsjCd+")를 찾을수 없습니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.NOT_FOUND);
        }
    }

    //search GlCode List
    @RequestMapping(value = "/rest/accountingGlCode", params = {"acsjCd", "acsjNm"}, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<GlCodeVo> searchListGlCode (@RequestParam("acsjCd") String acsjCd, @RequestParam("acsjNm") String acsjNm) {
    	return glCodeService.searchListGlCode(acsjCd,acsjNm);
    } 
	// search GlMaster List
    @RequestMapping(value = "/rest/accountingGlMasterList", params = { "startDate", "endDate", "refNo" }, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<GlMasterVo> searchListGlMaster(@RequestParam("startDate") String startDate, @RequestParam("endDate") String endDate, @RequestParam("refNo") String refNo ) {
    	return glMasterService.searchListGlMaster(startDate,endDate,refNo);
    }  
    
	// search GlDetailJournalizeVo List
    @RequestMapping(value = "/rest/accountingGlDetailList", params = { "actgTrDt", "actgTrSrno" }, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<GlDetailJournalizeVo> readGlDetailList(@RequestParam("actgTrDt") String actgTrDt, @RequestParam("actgTrSrno") long actgTrSrno) {
    	return glDetailService.getGlDetailList(actgTrDt, actgTrSrno) ;
    }  
}
