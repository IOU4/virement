package eai.bff.balance.dto;

import eai.bff.common.dto.OperationStatus;
import eai.bff.common.dto.OperationAmount;
import eai.bff.common.dto.TransactionType;

import java.util.UUID;

public record AccountBalanceOperationResponse(UUID id, UUID customerAccountReference, OperationAmount operationAmount,
                                              OperationStatus balanceOperationStatus, TransactionType transactionType,
                                              UUID sagaId) {
}
