package com.sennet.common;

import java.text.ParseException;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.sennet.exception.DuplicatedException;
import com.sennet.exception.NotFoundException;
import com.sennet.exception.NotValidException;
import com.sennet.exception.PasswordValidException;

@ControllerAdvice
@RestController
public class ExceptionHandlers {
	@ExceptionHandler(DuplicatedException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	@ResponseBody
	public ErrorResponse handleUserDuplicatedException(DuplicatedException e) {
		ErrorResponse errorResponse = new ErrorResponse();
		errorResponse.setMessage("[" + e.getUniqueName() + "] is duplicated.");
		errorResponse.setCode("unique.duplicated.exception");
		return errorResponse;
	}

	@ExceptionHandler(NotFoundException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	@ResponseBody
	public ErrorResponse handleAccountNotFoundException(NotFoundException e) {
		ErrorResponse errorResponse = new ErrorResponse();
		errorResponse.setMessage("[" + e.getSeq() + "] notFound.");
		errorResponse.setCode("seq.notFound.exception");
		return errorResponse;
	}
	
	@ExceptionHandler(PasswordValidException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	@ResponseBody
	public ErrorResponse handlePasswordValidException(PasswordValidException e) {
		ErrorResponse errorResponse = new ErrorResponse();
		errorResponse.setMessage("[" + e.getPassword() + "] is not valid.");
		errorResponse.setCode("password.notValid.exception");
		return errorResponse;
	}
	
	
	@ExceptionHandler(NotValidException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	@ResponseBody
	public ErrorResponse ParamNotValidException(NotValidException e) {
		ErrorResponse errorResponse = new ErrorResponse();
		errorResponse.setMessage("[" + e.getParam() + "] is not valid.");
		errorResponse.setCode("param.notValid.exception");
		return errorResponse;
	}	
	
	@ExceptionHandler(java.text.ParseException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	@ResponseBody
	public ErrorResponse handleParseException(ParseException e) {
		ErrorResponse errorResponse = new ErrorResponse();
		errorResponse.setMessage("[" + e.getMessage() + "]");
		errorResponse.setCode("date.notParsed.exception");
		return errorResponse;
	}
	
	@ExceptionHandler(RuntimeException.class)
	@ResponseStatus(HttpStatus.BAD_REQUEST)
	@ResponseBody
	public ErrorResponse RunException(RuntimeException e) {
		ErrorResponse errorResponse = new ErrorResponse();
		errorResponse.setMessage("[" + e.getMessage() + "]");
		errorResponse.setCode("runtime.exception");
		return errorResponse;
	}	

}
