package eai.bff.loyalty.controller;

import eai.bff.loyalty.dto.AccountLoyaltyOperationResponse;
import eai.bff.loyalty.dto.AccountLoyaltyResponse;
import eai.bff.loyalty.service.LoyaltyApiService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;

@RestController
@RequestMapping("/loyalty")
@ResponseStatus(HttpStatus.OK)
public class LoyaltyController {

  private final LoyaltyApiService loyaltyService;

  public LoyaltyController(LoyaltyApiService service) {
    this.loyaltyService = service;
  }

  @GetMapping("/")
  public Flux<AccountLoyaltyResponse> getAllLoyaltyAccounts() {
    return loyaltyService.getAllLoyaltyAccounts();
  }

  @GetMapping("/operations")
  Flux<AccountLoyaltyOperationResponse> getAllLoyaltyOperations() {
    return loyaltyService.getAllLoyaltyOperations();
  }

}
