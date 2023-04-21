package eai.bff.dto;

import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.math.BigDecimal;

public record CreateVirementCommand(
    @NotNull @Size(max = 255) String agentId,
    @NotNull @Size(max = 255) String sourceAccount,
    @NotNull @Size(max = 255) String destinationAccount,
    @NotNull @Digits(integer = 10, fraction = 10) BigDecimal amount) {
}
