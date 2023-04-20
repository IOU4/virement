package eai.bff.controller;

import eai.bff.dto.RHSSOTokenResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import eai.bff.service.TokenService;
import reactor.core.publisher.Mono;

/**
 * TokenController
 */
@RestController
@RequestMapping("/token")
public class TokenController {
  private final TokenService tokenService;

  public TokenController(TokenService tokenService) {
    this.tokenService = tokenService;
  }

  @GetMapping
  public ResponseEntity<Mono<RHSSOTokenResponse>> getAccessToken() {
    return ResponseEntity.ok(tokenService.getAccessToken());
  }

}
