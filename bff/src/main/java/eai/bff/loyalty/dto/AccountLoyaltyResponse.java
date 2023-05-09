package eai.bff.loyalty.dto;

import java.math.BigDecimal;
import java.time.OffsetDateTime;
import java.util.UUID;

public record AccountLoyaltyResponse(UUID id, UUID customerAccountReference, BigDecimal loyalty,
                                     BigDecimal blockedLoyaltyAmount, OffsetDateTime createdAt) {
}
