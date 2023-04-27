package eai.bff.dto;

import java.math.BigDecimal;
import java.time.OffsetDateTime;

public record VirementResponse(Long id, String agentId, String sourceAccount, String destinationAccount,
                               BigDecimal amount, OffsetDateTime dateCreated) {
}
