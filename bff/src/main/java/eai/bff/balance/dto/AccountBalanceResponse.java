package eai.bff.balance.dto;

import eai.bff.common.dto.BaseId;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.UUID;

public record AccountBalanceResponse(BaseId<UUID> id, BaseId<UUID> customerAccountReference, BigDecimal balance,
                                     BigDecimal blockedBalanceAmount, OffsetDateTime createdAt) {
}
