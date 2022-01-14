package com.sennet.exception;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NotValidException extends RuntimeException {

    String param;
    
    public NotValidException(String param) {
        this.param = param;
    }    

}
