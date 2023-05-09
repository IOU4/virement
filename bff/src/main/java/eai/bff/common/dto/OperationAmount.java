package eai.bff.common.dto;

import java.math.BigDecimal;

public record OperationAmount(BigDecimal amount, boolean greaterThanZero) {
}
