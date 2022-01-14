package com.sennet.bizcommon.commoncode;

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
public class CommonCodeController {

    @Autowired
    private CommonCodeService commonCodeService;

    @Autowired
    private ModelMapper modelMapper;
	
    //CREATE
    @RequestMapping(value = "/rest/CommonCode", method = POST)
    @ResponseBody
    public ResponseEntity<?> insert(@RequestBody @Valid CommonCodeVo paramVo, BindingResult result) {
		CommonCodeVo commonCodeVo = modelMapper.map(paramVo, CommonCodeVo.class);
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }
        int effectRows = commonCodeService.insertCommonCode(paramVo);
        // insert Row 없음
        if(effectRows==1){
            return new ResponseEntity<CommonCodeVo>(modelMapper.map(commonCodeVo,CommonCodeVo.class), HttpStatus.CREATED);
        }
        else{
            return new ResponseEntity<CommonCodeVo>(modelMapper.map(commonCodeVo,CommonCodeVo.class), HttpStatus.NOT_MODIFIED);
        }
    }

    //UPDATE ONE
    @RequestMapping(value = "/rest/CommonCode", method = PUT)
    @ResponseBody
    public ResponseEntity<?> update(@RequestBody @Valid CommonCodeVo paramVo, BindingResult result) {
		CommonCodeVo commonCodeVo = modelMapper.map(paramVo, CommonCodeVo.class);
    	if (result.hasErrors()) {
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }
        int effectRows = commonCodeService.updateCommonCode(commonCodeVo);
        // update Row 없음
        if(effectRows!=1){
            return new ResponseEntity<CommonCodeVo>(modelMapper.map(commonCodeVo,CommonCodeVo.class), HttpStatus.NOT_MODIFIED);
        }
        // 정상수행
        else{
            return new ResponseEntity<CommonCodeVo>(modelMapper.map(commonCodeVo,CommonCodeVo.class), HttpStatus.OK);
        	
        }
    } 
    
    //DELETE ONE
    @RequestMapping(value = "/rest/CommonCode/{gCode}", method = DELETE)
    @ResponseBody
    public ResponseEntity<?> delete(@PathVariable("gCode") String gcode) {
        CommonCodeVo resultCommonCodeVo = commonCodeService.delete(gcode);
        // update Row 없음
        if(resultCommonCodeVo == null){
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("해당코드를 수정하지 못했습니다.");
            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.NOT_FOUND);
        }
        // 정상수행
        else{
            return new ResponseEntity<CommonCodeVo>(modelMapper.map(resultCommonCodeVo,CommonCodeVo.class), HttpStatus.OK);
        }
    }
	// search CommonDcode
    @RequestMapping(value = "/rest/searchListCommonCode", params = { "gcode", "gcodeName", "staCd"}, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<CommonCodeVo> searchListCommonCode(@RequestParam("gcode") String gcode, @RequestParam("gcodeName") String gcodeName,@RequestParam("staCd") String staCd) {
    	return commonCodeService.searchListCommonCode(gcode,gcodeName,staCd);
    } 

    
}
