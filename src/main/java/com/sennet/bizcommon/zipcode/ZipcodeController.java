package com.sennet.bizcommon.zipcode;

import static org.springframework.web.bind.annotation.RequestMethod.GET;

import java.util.List;


import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
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
public class ZipcodeController {

    @Autowired
    private ZipcodeService zipcodeService;

    @Autowired
    private ModelMapper modelMapper;

	// search ZipcodeWindow
    @RequestMapping(value = "/rest/searchListZipcodePopupPageable", params = {"zipcode","province","roadName","mainBuildingNo"}, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public  PageImpl<ZipcodeVo> searchListZipcodeWindow(
    		@RequestParam("zipcode") String zipcode, 
    		@RequestParam("province") String province,
    		@RequestParam("roadName") String roadName, 
    		@RequestParam("mainBuildingNo") String mainBuildingNo,
    		Pageable pageable) {
        return zipcodeService.searchListZipcodePopupPageable(zipcode, province, roadName, mainBuildingNo,pageable);
    }


	// search Zipcode
    @RequestMapping(value = "/rest/searchListZipcodePageable", params = {"zipcode","province","roadName","mainBuildingNo"}, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public  PageImpl<ZipcodeVo> searchListZipcode(
    		@RequestParam("zipcode") String zipcode, 
    		@RequestParam("province") String province,
    		@RequestParam("roadName") String roadName, 
    		@RequestParam("mainBuildingNo") String mainBuildingNo,
    		Pageable pageable) {
        return zipcodeService.searchListZipcodePageable(zipcode, province, roadName, mainBuildingNo,pageable);
    }
}
