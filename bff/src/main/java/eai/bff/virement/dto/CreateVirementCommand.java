package eai.bff.virement.dto;

import java.math.BigDecimal;
import java.util.UUID;

public record CreateVirementCommand(UUID customerAccountSource, UUID customerAccountTarget, BigDecimal amount) {
}
