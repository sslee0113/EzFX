package com.sennet.bizcommon.customer;

import static org.springframework.web.bind.annotation.RequestMethod.DELETE;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import static org.springframework.web.bind.annotation.RequestMethod.POST;
import static org.springframework.web.bind.annotation.RequestMethod.PUT;

import java.util.Iterator;
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
import com.sennet.util.CustomerInfoProtect;

import lombok.extern.slf4j.Slf4j;

@Controller
public class CustomerController {

	@Autowired
    private CustomerService service;

    @Autowired
    private ModelMapper modelMapper;
	
  //CREATE
    @RequestMapping(value = "/rest/Customer", method = POST)
    @ResponseBody
    public ResponseEntity<?> insert(@RequestBody @Valid CustomerVo paramVo, BindingResult result) {
		CustomerVo customerVo = modelMapper.map(paramVo, CustomerVo.class);
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        int effectRows = service.insertCustomer(paramVo);
        // insert Row 없음
        if(effectRows!=1){
            return new ResponseEntity<CustomerVo>(modelMapper.map(customerVo,CustomerVo.class), HttpStatus.NOT_MODIFIED);
        }
        else{
            return new ResponseEntity<CustomerVo>(modelMapper.map(customerVo,CustomerVo.class), HttpStatus.CREATED);
        	
        }
    }

    //UPDATE ONE
    @RequestMapping(value = "/rest/Customer", method = PUT)
    @ResponseBody
    public ResponseEntity<?> update(@RequestBody @Valid CustomerVo paramVo, BindingResult result) {
		CustomerVo customerVo = modelMapper.map(paramVo, CustomerVo.class);
    	if (result.hasErrors()) {
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }
        int effectRows = service.updateCustomer(customerVo);
        // update Row 없음
        if(effectRows!=1){
            return new ResponseEntity<CustomerVo>(modelMapper.map(customerVo,CustomerVo.class), HttpStatus.NOT_MODIFIED);
        }
        // 정상수행
        else{
            return new ResponseEntity<CustomerVo>(modelMapper.map(customerVo,CustomerVo.class), HttpStatus.OK);
        	
        }
    } 
    
    //DELETE ONE
    @RequestMapping(value = "/rest/Customer/{cifNo}", method = DELETE)
    @ResponseBody
    public ResponseEntity<?> delete(@PathVariable("cifNo") String cifNo) {
    	CustomerVo vo = new CustomerVo();
		CustomerVo customerVo = modelMapper.map(vo, CustomerVo.class);
        int effectRows = service.delete(cifNo);
        // 수정 없음.
        if(effectRows!=1){
            return new ResponseEntity<CustomerVo>(modelMapper.map(customerVo,CustomerVo.class), HttpStatus.NOT_MODIFIED);
        }
        // 정상수행
        else{
            return new ResponseEntity<CustomerVo>(modelMapper.map(customerVo,CustomerVo.class), HttpStatus.OK);
        }
    }
	// search Customer
    @RequestMapping(value = "/rest/searchListCustomer", params = {"cifNo", "brnNo", "engFirstName"}, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<CustomerVo> searchListCustomer(@RequestParam("cifNo") String cifNo, @RequestParam("brnNo") String brnNo, @RequestParam("engFirstName") String engFirstName) {
    	return service.searchListCustomer(cifNo,brnNo,engFirstName);
    }
    
}
