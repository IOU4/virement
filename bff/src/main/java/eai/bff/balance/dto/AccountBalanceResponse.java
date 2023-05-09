package eai.bff.balance.dto;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.UUID;

public record AccountBalanceResponse(UUID id, UUID customerAccountReference, BigDecimal balance,
                                     BigDecimal blockedBalanceAmount, OffsetDateTime createdAt) {
}
