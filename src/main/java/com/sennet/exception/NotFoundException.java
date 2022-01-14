package com.sennet.exception;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class NotFoundException extends RuntimeException {

    Long seq;
    String name;

    public NotFoundException(Long seq) {
        this.seq = seq;
    }
    
    public NotFoundException(String name) {
        this.name = name;
    }    

}
