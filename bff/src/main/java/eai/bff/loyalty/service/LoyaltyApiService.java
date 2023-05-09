package eai.bff.loyalty.service;

import eai.bff.loyalty.dto.AccountLoyaltyOperationResponse;
import eai.bff.loyalty.dto.AccountLoyaltyResponse;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.service.annotation.GetExchange;
import org.springframework.web.service.annotation.HttpExchange;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

@HttpExchange(url = "/loyalty", contentType = "application/json", accept = "application/json")
public interface LoyaltyApiService {

  @GetExchange(url = "/")
  Flux<AccountLoyaltyResponse> getAllLoyaltyAccounts();

  @GetExchange(url = "/{accountId}")
  Mono<AccountLoyaltyResponse> getLoyaltyAccountById(@PathVariable UUID accountId);

  @GetExchange(url = "/operations")
  Flux<AccountLoyaltyOperationResponse> getAllLoyaltyOperations();

  @GetExchange(url = "/{accountId}/operations")
  Mono<AccountLoyaltyOperationResponse> getLoyaltyAccountOperationsById(@PathVariable UUID accountId);
}
