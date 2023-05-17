package eai.bff.loyalty.service;

import eai.bff.loyalty.dto.AccountLoyaltyOperationResponse;
import eai.bff.loyalty.dto.AccountLoyaltyResponse;
import org.springframework.web.service.annotation.GetExchange;
import org.springframework.web.service.annotation.HttpExchange;
import reactor.core.publisher.Flux;

@HttpExchange(contentType = "application/json", accept = "application/json")
public interface LoyaltyApiService {

  @GetExchange(url = "/")
  Flux<AccountLoyaltyResponse> getAllLoyaltyAccounts();

  @GetExchange(url = "/operations")
  Flux<AccountLoyaltyOperationResponse> getAllLoyaltyOperations();

}
