package eai.bff.loyalty.controller;

import eai.bff.loyalty.dto.AccountLoyaltyOperationResponse;
import eai.bff.loyalty.dto.AccountLoyaltyResponse;
import eai.bff.loyalty.service.LoyaltyApiService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.util.UUID;

@RestController
@RequestMapping("/loyalty")
@ResponseStatus(HttpStatus.OK)
public class LoyaltyController {

  private final LoyaltyApiService loyaltyService;

  public LoyaltyController(LoyaltyApiService service) {
    this.loyaltyService = service;
  }

  @GetMapping
  public Flux<AccountLoyaltyResponse> getAllLoyaltyAccounts() {
    return loyaltyService.getAllLoyaltyAccounts();
  }

  @GetMapping("/{accountId}")
  Mono<AccountLoyaltyResponse> getLoyaltyAccountById(@PathVariable UUID accountId) {
    return loyaltyService.getLoyaltyAccountById(accountId);
  }

  @GetMapping("/operations")
  Flux<AccountLoyaltyOperationResponse> getAllLoyaltyOperations() {
    return loyaltyService.getAllLoyaltyOperations();
  }

  @GetMapping("/{accountId}/operations")
  Mono<AccountLoyaltyOperationResponse> getLoyaltyAccountOperationsById(@PathVariable UUID accountId) {
    return loyaltyService.getLoyaltyAccountOperationsById(accountId);
  }
}
