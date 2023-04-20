package eai.bff.dto;

import java.math.BigDecimal;

public record VirementResponse(Long id, String agentId, String sourceAccount, String destinationAccount,
                               BigDecimal amount) {
}
