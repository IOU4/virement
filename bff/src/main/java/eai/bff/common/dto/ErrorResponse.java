package eai.bff.common.dto;

import com.fasterxml.jackson.annotation.JsonInclude;

import java.util.List;

@JsonInclude(JsonInclude.Include.NON_NULL)
public record ErrorResponse (Integer httpStatus, String exception, String message, List<FieldError> fieldErrors) {
}
