package com.sennet.common;

import lombok.Data;

import java.util.List;

@Data
public class ErrorResponse {

    private String message;

    private String code;

/*    private List<FieldError> errors;

    // field에 있는 값 response에 추가하여 친절한 응답주기
    public static class FieldError {
        private String field;
        private String value;
        private String reason;
    }*/

}
