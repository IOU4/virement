package eai.bff.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;

public class VirementApiException extends RuntimeException {

    private final HttpStatus status;

    public VirementApiException(String message, HttpStatusCode status) {
        super(message);
        this.status = HttpStatus.valueOf(status.value());
    }

    public HttpStatus status() {
        return status;
    }
}
