package eai.bff.virement.dto;

import eai.bff.common.dto.BaseId;
import eai.bff.common.dto.OperationStatus;

import java.math.BigDecimal;
import java.time.ZonedDateTime;
import java.util.List;
import java.util.UUID;

public record VirementResponse(BaseId<UUID> id, BaseId<UUID> customerAccountSource, BaseId<UUID> customerAccountTarget,
                               OperationStatus virementOperationStatus, BigDecimal amount, BaseId<UUID> trackingId,
                               List<String> failureMessages, ZonedDateTime createdAt) {
}
