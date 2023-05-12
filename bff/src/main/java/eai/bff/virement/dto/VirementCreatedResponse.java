package eai.bff.virement.dto;

import eai.bff.common.dto.OperationStatus;

import java.util.UUID;

public record VirementCreatedResponse(UUID virementTrackingId, OperationStatus virementOperationStatus,
                                      String message) {
}
