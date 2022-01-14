package com.sennet.userprofile;

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
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import com.sennet.common.ErrorResponse;

@Controller
public class UserProfileController {

    @Autowired
    private UserProfileService userProfileService;

    @Autowired
    private ModelMapper modelMapper;
	
    
    //CREATE
    @RequestMapping(value = "/rest/userProfile", method = POST)
    @ResponseBody
    public ResponseEntity<?> insert(@RequestBody @Valid UserProfileVo paramVo, BindingResult result) {
        if (result.hasErrors()) {
            ErrorResponse errorResponse = new ErrorResponse();
            errorResponse.setMessage("잘못된 요청입니다.");
            errorResponse.setCode("bad.request");

            return new ResponseEntity<ErrorResponse>(errorResponse, HttpStatus.BAD_REQUEST);
        }

        UserProfileVo userProfileVo = userProfileService.insertUserProfile(paramVo);
        return new ResponseEntity<UserProfileVo>(modelMapper.map(userProfileVo, UserProfileVo.class), HttpStatus.CREATED);
    }
 
    //READ ONE
    @RequestMapping(value = "/rest/userProfile/{seq}", method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public UserProfileVo readOne(@PathVariable Long seq) {
        UserProfileVo userProfileVo = userProfileService.findOneUserProfile(seq);
        return modelMapper.map(userProfileVo, UserProfileVo.class);
    }  
    
    
    //READ username ONE
    @RequestMapping(value = "/rest/userProfile", params = {"userName", "role"}, method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public List<UserProfileVo> read(@RequestParam("userName") String userName, @RequestParam("role") String role) {
        
    	List<UserProfileVo> userProfileVoList = userProfileService.searchListUserProfile(userName,role);
    	return userProfileVoList; 
    }
    
    //READ ACCOUNT INFO
    @RequestMapping(value = "/rest/userProfileInfo", method = GET)
    @ResponseBody
    @ResponseStatus(HttpStatus.OK)
    public UserProfileVo readLoginInfo() {
    	
    	Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
    	
    	UserProfileVo userProfileVo = userProfileService.findOneUserProfile(username);
    	return userProfileVo;
    }
    
    //UPDATE PASSWORD
    @RequestMapping(value = "/rest/updatePassword/{seq}", method = PUT)
    @ResponseBody
    public ResponseEntity<?> updatePassword(@PathVariable Long seq, @RequestBody @Valid UserProfileVo paramVo, BindingResult result) {
        if (result.hasErrors()) {
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }

        UserProfileVo updatedUserProfile = userProfileService.updatePassword(seq, paramVo);
        return new ResponseEntity<UserProfileVo>(modelMapper.map(updatedUserProfile,UserProfileVo.class), HttpStatus.OK);
    }

    //UPDATE ONE
    @RequestMapping(value = "/rest/userProfile/{seq}", method = PUT)
    @ResponseBody
    public ResponseEntity<?> update(@PathVariable Long seq, @RequestBody @Valid UserProfileVo paramVo, BindingResult result) {
        if (result.hasErrors()) {
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }

        UserProfileVo updatedUserProfile = userProfileService.updateUserProfile(seq, paramVo);
        if(updatedUserProfile==null){
        	return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
        }
        else{
            return new ResponseEntity<UserProfileVo>(modelMapper.map(updatedUserProfile, UserProfileVo.class), HttpStatus.OK);
        }
    }
    

    //DELETE ONE
    @RequestMapping(value = "/rest/userProfile/{seq}", method = DELETE)
    @ResponseBody
    public ResponseEntity<?> delete(@PathVariable Long seq) {
    	int effectRows = userProfileService.deleteUserProfile(seq);
    	if(effectRows==1){
            return new ResponseEntity<Object>(HttpStatus.OK);
    	}
    	else{
            return new ResponseEntity<Object>(HttpStatus.BAD_REQUEST);
    	}
    }
    



}
