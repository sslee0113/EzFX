package com.sennet.userprofile;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;

import com.sennet.common.StringUtil;
import com.sennet.exception.DuplicatedException;
import com.sennet.exception.NotFoundException;
import com.sennet.exception.PasswordValidException;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class UserProfileService {

	@Autowired
	private UserProfileDao userProfileDao;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private ModelMapper modelMapper;

	// CREATE
	public UserProfileVo insertUserProfile(UserProfileVo paramVo) {
		
		UserProfileVo userProfileVo =  modelMapper.map(paramVo,UserProfileVo.class);

		if (userProfileDao.findOneUserProfile(paramVo.getUserName()) != null) {
			log.error("username duplicated exception. {}", paramVo.getUserName());
			throw new DuplicatedException(paramVo.getUserName());
		}

		String requestPassword = paramVo.getPassword();

		if (!isPassswordValid(requestPassword)) {
			log.error("password notValid exception {}", requestPassword);
			throw new PasswordValidException(requestPassword);
		}

		Integer nextSequence = userProfileDao.getNextSeq();
		userProfileVo.setAccountSeq(nextSequence.longValue());
		userProfileVo.setUserName(paramVo.getUserName());
		userProfileVo.setPassword(passwordEncoder.encode(paramVo.getPassword()));
		userProfileVo.setFullName(paramVo.getFullName());
		userProfileVo.setStartDate(StringUtil.currentDateString("yyyy-MM-dd HH:mm:ss"));
		userProfileVo.setModifyDate(StringUtil.currentDateString("yyyy-MM-dd HH:mm:ss"));
		userProfileVo.setFinalDate(StringUtil.currentDateString("yyyy-MM-dd HH:mm:ss"));
		userProfileVo.setBadCount(0);
		userProfileVo.setBadCountdate("");
		userProfileVo.setWhiteIp(paramVo.getWhiteIp());
		userProfileVo.setPasswordDate(StringUtil.currentDateString("yyyy-MM-dd HH:mm:ss"));
		userProfileVo.setSuperUser(paramVo.getSuperUser());
		userProfileVo.setPosCd(paramVo.getPosCd());
		userProfileVo.setUserPos(paramVo.getUserPos());
		userProfileVo.setBrno(paramVo.getBrno());
		userProfileVo.setOffrId(paramVo.getOffrId());
		userProfileVo.setTelNo(paramVo.getTelNo());
		userProfileVo.setCellNo(paramVo.getCellNo());
		int effectRows =  userProfileDao.saveUserProfile(userProfileVo);
		if(effectRows==1){
			return userProfileVo;
		}
		else{
			return null;
		}
	}
	// find One
	public UserProfileVo findOneUserProfile(String userName) {
		UserProfileVo vo = userProfileDao.findOneUserProfile(userName);
		if (vo == null) {
			throw new NotFoundException(userName);
		}
		return vo;
	}
	// find One
	public UserProfileVo findOneUserProfile(Long accountSeq) {
		UserProfileVo vo = userProfileDao.findOneUserProfile(accountSeq);
		if (vo == null) {
			throw new NotFoundException("accountSeq:"+accountSeq);
		}
		return vo;
	}
	
	// READ LOGIN USER's UserProfileVo
	public UserProfileVo getLoginInfo(){
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
    	String username = authentication.getName();
    	return findOneUserProfile(username);
	}
	// READ LOGIN USER's Brno
	public String  getLoginUserBrno(){
    	UserProfileVo vo = getLoginInfo();
    	return vo.getBrno();
	}

	// UPDATE
	public UserProfileVo updateUserProfile(Long seq, UserProfileVo paramVo) {

		UserProfileVo userProfileVo = findOneUserProfile(seq);
		if(userProfileVo==null){
			throw new NotFoundException(paramVo.getUserName());
		}
		userProfileVo.setAccountSeq(paramVo.getAccountSeq());
		userProfileVo.setUserName(paramVo.getUserName());
		
		String requestPasswd =  paramVo.getPassword();
		if(requestPasswd.length() > 8 && requestPasswd.length() < 13){
			if (!isPassswordValid(paramVo.getPassword())) {
				log.error("password notValid exception {}",requestPasswd);
				throw new PasswordValidException(requestPasswd);
			}
			userProfileVo.setPassword(passwordEncoder.encode(requestPasswd));
			userProfileVo.setPasswordDate(StringUtil.currentDateString("yyyy-MM-dd HH:mm:ss"));
		}
		
		userProfileVo.setFullName(paramVo.getFullName());
		userProfileVo.setModifyDate(StringUtil.currentDateString("yyyy-MM-dd HH:mm:ss"));
		userProfileVo.setFinalDate(StringUtil.currentDateString("yyyy-MM-dd HH:mm:ss"));
		
		userProfileVo.setWhiteIp(paramVo.getWhiteIp());
		userProfileVo.setSuperUser(paramVo.getSuperUser());
		userProfileVo.setPosCd(paramVo.getPosCd());
		userProfileVo.setUserPos(paramVo.getUserPos());
		userProfileVo.setBrno(paramVo.getBrno());
		userProfileVo.setOffrId(paramVo.getOffrId());
		userProfileVo.setTelNo(paramVo.getTelNo());
		userProfileVo.setCellNo(paramVo.getCellNo());
		int effectRows = userProfileDao.saveUserProfile(userProfileVo);
		if(effectRows==1){
			return userProfileVo;
		}
		else{
			return null;
		}
	}
	
	// UPDATE
	public UserProfileVo updatePassword(Long seq, UserProfileVo paramVo) {

		String requestPasswd =  paramVo.getPassword();
		if (!isPassswordValid(paramVo.getPassword())) {
			log.error("password notValid exception {}",requestPasswd);
			throw new PasswordValidException(requestPasswd);
		}
		
		UserProfileVo userProfileVo = findOneUserProfile(seq);
		userProfileVo.setPassword(passwordEncoder.encode(requestPasswd));
		userProfileVo.setPasswordDate(StringUtil.currentDateString("yyyy-MM-dd HH:mm:ss"));
		userProfileVo.setRole(userProfileVo.getRole().replace("EXPIRED", ""));
		int effectRows = userProfileDao.saveUserProfile(userProfileVo);
		if(effectRows==1){
			return userProfileVo;
		}
		else{
			return null;
		}
	}

	// DELETE
	public int deleteUserProfile(Long seq) {
		
		UserProfileVo userProfileVo = findOneUserProfile(seq);
		if(userProfileVo==null){
			throw new NotFoundException("accountSeq:"+seq);
		}
		return userProfileDao.deleteUserProfile(seq);
	}
	
	public List<UserProfileVo> searchListUserProfile(String userName, String role) {
		return userProfileDao.searchListUserProfile(userName,role);
	}
	
	public boolean isPassswordValid(String password) {

		if (password == null || password.equals("")) {
			return false;
		}

		if (7 >= password.length() || password.length() >= 21) {
			return false;
		}

		Pattern p = Pattern.compile("([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])");
		Matcher m = p.matcher(password);

		if (m.find()) {
			return true;
		}
		return false;

	}


	// UPDATE BAD COUNT
	public UserProfileVo updateBadCount(String name) throws Exception {
		UserProfileVo userProfileVo = findOneUserProfile(name);
		int badcount;

		if (!userProfileVo.getBadCountdate().contains(StringUtil.currentDateString("yyyy-MM-dd"))) {
			badcount = 1;
		} else {
			if (userProfileVo.getBadCount() != 0) {
				badcount = userProfileVo.getBadCount() + 1;
			} else {
				badcount = 1;
			}
		}

		userProfileVo.setBadCount(badcount);
		userProfileVo.setBadCountdate(StringUtil.currentDateString("yyyy-MM-dd HH:mm:ss"));
		int effectRows =  userProfileDao.updateBadCount(userProfileVo);
		if(effectRows==1){
			return userProfileVo;
		}
		else{
			throw new Exception("로그인 실패 카운트 업데이트 시 오류");
		}
	}

	// UPDATE INIT COUNT
	public UserProfileVo updateInitCount(String name, Integer count) {
		UserProfileVo userProfileVo = findOneUserProfile(name);
		userProfileVo.setBadCount(count);
		userProfileVo.setBadCountdate(StringUtil.currentDateString("yyyy-MM-dd HH:mm:ss"));
		int effectRows =  userProfileDao.updateBadCount(userProfileVo);
		if(effectRows==1){
			return userProfileVo;
		}
		else{
			return null;
		}
	}

	// UPDATE ROLE ADD EXPIRED
	public UserProfileVo updateAccountAddExpired(String name) {
		UserProfileVo userProfileVo = findOneUserProfile(name);
		if (userProfileVo.getRole().contains("EXPIRED")) {
		} else {
			userProfileVo.setRole(userProfileVo.getRole() + "EXPIRED");
		}
		int effectRows =  userProfileDao.saveUserProfile(userProfileVo);
		if(effectRows==1){
			return userProfileVo;
		}
		else{
			return null;
		}
	}
}
