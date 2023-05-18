package eai.bff.balance.dto;

import eai.bff.common.dto.OperationStatus;
import eai.bff.common.dto.BaseId;
import eai.bff.common.dto.OperationAmount;
import eai.bff.common.dto.TransactionType;

import java.util.UUID;

public record AccountBalanceOperationResponse(BaseId<UUID> id, BaseId<UUID> customerAccountReference,
    OperationAmount operationAmount,
    OperationStatus balanceOperationStatus, TransactionType transactionType,
    UUID sagaId) {
}
