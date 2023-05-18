package eai.bff.loyalty.dto;

import eai.bff.common.dto.OperationStatus;
import eai.bff.common.dto.BaseId;
import eai.bff.common.dto.OperationAmount;
import eai.bff.common.dto.TransactionType;

import java.util.UUID;

public record AccountLoyaltyOperationResponse(BaseId<UUID> id, BaseId<UUID> customerAccountReference,
    OperationAmount operationAmount,
    OperationStatus loyaltyOperationStatus, TransactionType transactionType,
    UUID sagaId) {
}
