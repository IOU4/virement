package eai.bff.virement.dto;

import eai.bff.common.dto.BaseId;
import eai.bff.common.dto.OperationStatus;

import java.time.ZonedDateTime;
import java.util.List;
import java.util.UUID;

public record VirementResponse(BaseId<UUID> id, UUID customerAccountSource, UUID customerAccountTarget,
                               OperationStatus virementOperationStatus, String amount, BaseId<UUID> trackingId,
                               List<String> failureMessages, ZonedDateTime createdAt) {
}
