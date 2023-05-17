package eai.bff.balance.controller;

import eai.bff.balance.dto.AccountBalanceOperationResponse;
import eai.bff.balance.dto.AccountBalanceResponse;
import eai.bff.balance.service.BalanceApiService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;

@RestController
@RequestMapping("/balance")
@ResponseStatus(HttpStatus.OK)
public class BalanceController {

  private final BalanceApiService balanceService;

  public BalanceController(BalanceApiService service) {
    this.balanceService = service;
  }

  @GetMapping("/")
  public Flux<AccountBalanceResponse> getAllBalanceAccounts() {
    return balanceService.getAllBalanceAccounts();
  }

  @GetMapping("/operations")
  Flux<AccountBalanceOperationResponse> getAllBalanceAccountOperations() {
    return balanceService.getAllBalanceAccountOperations();
  }
}
