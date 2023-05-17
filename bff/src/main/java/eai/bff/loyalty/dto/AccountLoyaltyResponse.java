package eai.bff.loyalty.dto;

import eai.bff.common.dto.BaseId;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.UUID;

public record AccountLoyaltyResponse(BaseId<UUID> id, BaseId<UUID> customerAccountReference, BigDecimal loyalty,
                                     BigDecimal blockedLoyaltyAmount, OffsetDateTime createdAt) {
}
