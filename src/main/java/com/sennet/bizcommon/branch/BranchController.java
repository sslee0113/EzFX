package com.sennet.bizcommon.branch;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.sennet.common.ErrorResponse;


@Controller
public class BranchController {

	@Autowired
    private BranchService service;

    @Autowired
    private ModelMapper modelMapper;
	
  //CREATE
    @RequestMapping(value = "/rest/Branch", method = POST)
    @ResponseBody
    public ResponseEntity<?> insert(@RequestBody @Valid BranchVo paramVo, BindingResult result) {
		BranchVo branchVo = modelMapper.map(paramVo, BranchVo.class);
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        int effectRows = service.insertBranch(paramVo);
        // insert Row 없음
        if(effectRows!=1){
            return new ResponseEntity<BranchVo>(modelMapper.map(branchVo,BranchVo.class), HttpStatus.NOT_MODIFIED);
        }
        else{
            return new ResponseEntity<BranchVo>(modelMapper.map(branchVo,BranchVo.class), HttpStatus.CREATED);
        	
        }
    }

    //UPDATE ONE
    @RequestMapping(value = "/rest/Branch", method = PUT)
    @ResponseBody
    public ResponseEntity<?> update(@RequestBody @Valid BranchVo paramVo, BindingResult result) {
		BranchVo branchVo = modelMapper.map(paramVo, BranchVo.class);
    	if (result.hasErrors()) {
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }
        int effectRows = service.updateBranch(branchVo);
        // update Row 없음
        if(effectRows!=1){
            return new ResponseEntity<BranchVo>(modelMapper.map(branchVo,BranchVo.class), HttpStatus.NOT_MODIFIED);
        }
        // 정상수행
        else{
            return new ResponseEntity<BranchVo>(modelMapper.map(branchVo,BranchVo.class), HttpStatus.OK);
        	
        }
    } 
    
    //DELETE ONE
    @RequestMapping(value = "/rest/Branch/{brno}", method = DELETE)
    @ResponseBody
    public ResponseEntity<?> delete(@PathVariable("brno") String brno) {
    	BranchVo vo = new BranchVo();
		BranchVo branchVo = modelMapper.map(vo, BranchVo.class);
        int effectRows = service.delete(brno);
        // 수정 없음.
        if(effectRows!=1){
            return new ResponseEntity<BranchVo>(modelMapper.map(branchVo,BranchVo.class), HttpStatus.NOT_MODIFIED);
        }
        // 정상수행
        else{
            return new ResponseEntity<BranchVo>(modelMapper.map(branchVo,BranchVo.class), HttpStatus.OK);
        }
    }
	// search Branch
    @RequestMapping(value = "/rest/searchListBranch", params = {"brno", "korName"}, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<BranchVo> searchListBranch(@RequestParam("brno") String brno, @RequestParam("korName") String korName) {
    	return service.searchListBranch(brno, korName);
    }

}