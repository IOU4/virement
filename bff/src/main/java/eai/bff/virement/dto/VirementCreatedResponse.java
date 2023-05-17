package eai.bff.virement.dto;

import eai.bff.common.dto.BaseId;
import eai.bff.common.dto.OperationStatus;

import java.util.UUID;

public record VirementCreatedResponse(BaseId<UUID> virementTrackingId, OperationStatus virementOperationStatus,
                                      String message) {
}
