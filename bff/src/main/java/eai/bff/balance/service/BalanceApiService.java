package eai.bff.balance.service;

import eai.bff.balance.dto.AccountBalanceOperationResponse;
import eai.bff.balance.dto.AccountBalanceResponse;
import org.springframework.web.service.annotation.GetExchange;
import org.springframework.web.service.annotation.HttpExchange;
import reactor.core.publisher.Flux;

@HttpExchange(contentType = "application/json", accept = "application/json")
public interface BalanceApiService {

  @GetExchange(url = "/")
  Flux<AccountBalanceResponse> getAllBalanceAccounts();

  @GetExchange(url = "/operations")
  Flux<AccountBalanceOperationResponse> getAllBalanceAccountOperations();

}
