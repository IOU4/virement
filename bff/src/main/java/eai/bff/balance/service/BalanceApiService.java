package eai.bff.balance.service;

import eai.bff.balance.dto.AccountBalanceOperationResponse;
import eai.bff.balance.dto.AccountBalanceResponse;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.service.annotation.GetExchange;
import org.springframework.web.service.annotation.HttpExchange;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

@HttpExchange(url = "${api.rest.domains.balance}", contentType = "application/json", accept = "application/json")
public interface BalanceApiService {

  @GetExchange(url = "/")
  Flux<AccountBalanceResponse> getAllBalanceAccounts();

  @GetExchange(url = "/{accountId}")
  Mono<AccountBalanceResponse> getBalanceAccountById(@PathVariable UUID accountId);

  @GetExchange(url = "/operations")
  Flux<AccountBalanceOperationResponse> getAllBalanceAccountOperations();

  @GetExchange(url = "/{accountId}/operations")
  Mono<AccountBalanceOperationResponse> getBalanceAccountOperationsById(@PathVariable UUID accountId);
}
