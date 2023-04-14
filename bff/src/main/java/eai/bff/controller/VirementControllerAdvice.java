package eai.bff.controller;

import eai.bff.dto.ErrorResponse;
import eai.bff.exception.VirementApiException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.Instant;

@RestControllerAdvice
public class VirementControllerAdvice {

    @ExceptionHandler(VirementApiException.class)
    public ErrorResponse handleRuntimeException(VirementApiException e) {
        return new ErrorResponse(e.getMessage(), e.status(), Instant.now());
    }
}
