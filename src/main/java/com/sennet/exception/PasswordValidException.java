package com.sennet.exception;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PasswordValidException extends RuntimeException {

    String password;
    
    public PasswordValidException(String password) {
        this.password = password;
    }    

}
