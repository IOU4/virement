package eai.bff.controller;

import eai.bff.dto.ErrorResponse;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.reactive.function.client.WebClientResponseException;

@RestControllerAdvice(basePackages = "eai.bff.controller")
public class VirementApiExceptionHandler {

    @ExceptionHandler(WebClientResponseException.class)
    public ErrorResponse handleWebClientResponseException(WebClientResponseException e) {
        return e.getResponseBodyAs(ErrorResponse.class);
    }

    @ExceptionHandler(Exception.class)
    public ErrorResponse handleException(Throwable e) {
        return new ErrorResponse(HttpStatus.INTERNAL_SERVER_ERROR.value(), e.getClass().getName(), e.getMessage(), null);
    }
}
