package eai.bff.dto;

import java.math.BigDecimal;

public record CreateVirementCommand(String agentId, String sourceAccount, String destinationAccount,
                                    BigDecimal amount) {
}
