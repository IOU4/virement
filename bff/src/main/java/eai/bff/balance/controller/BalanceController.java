package eai.bff.balance.controller;

import eai.bff.balance.dto.AccountBalanceOperationResponse;
import eai.bff.balance.dto.AccountBalanceResponse;
import eai.bff.balance.service.BalanceApiService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

@RestController
@RequestMapping("/")
@ResponseStatus(HttpStatus.OK)
public class BalanceController {

  private final BalanceApiService balanceService;

  public BalanceController(BalanceApiService service) {
    this.balanceService = service;
  }

  @GetMapping
  public Flux<AccountBalanceResponse> getAllBalanceAccounts() {
    return balanceService.getAllBalanceAccounts();
  }

  @GetMapping("/{accountId}")
  Mono<AccountBalanceResponse> getBalanceAccountById(@PathVariable UUID accountId) {
    return balanceService.getBalanceAccountById(accountId);
  }

  @GetMapping("/operations")
  Flux<AccountBalanceOperationResponse> getAllBalanceAccountOperations() {
    return balanceService.getAllBalanceAccountOperations();
  }

  @GetMapping("/{accountId}/operations")
  Mono<AccountBalanceOperationResponse> getBalanceAccountOperationsById(@PathVariable UUID accountId) {
    return balanceService.getBalanceAccountOperationsById(accountId);
  }
}
