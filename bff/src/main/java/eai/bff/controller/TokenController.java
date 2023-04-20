package eai.bff.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import eai.bff.service.TokenService;

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
  public ResponseEntity<String> getAccessToken() {
    return ResponseEntity.ok(tokenService.getAccessToken());
  }

}
