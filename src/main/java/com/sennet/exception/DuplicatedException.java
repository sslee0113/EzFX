package com.sennet.exception;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DuplicatedException extends RuntimeException {

    String uniqueName;
    String type;

    public DuplicatedException(String uniqueName) {
        this.uniqueName = uniqueName;
    }
   
}
