package eai.bff.service;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;

import eai.bff.dto.RhssoRokenResponse;

/**
 * TokenService
 */
@Service
public class TokenService {

  private final WebClient tokenWebClient;

  public TokenService(@Qualifier("tokenWebClient") WebClient tokenWebClient) {
    this.tokenWebClient = tokenWebClient;
  }

  public String getAccessToken() {
    return tokenWebClient
        .post()
        .uri("/auth/realms/eai-poc/protocol/openid-connect/token")
        .contentType(MediaType.APPLICATION_FORM_URLENCODED)
        .body(BodyInserters
            .fromFormData("grant_type", "client_credentials")
            .with("client_id", "64063030")
            .with("client_secret", "E5UWtQMjG8ug5ktjM3Ht6Mihp3N4kPoU")
            .with("scope", "openid"))
        .retrieve()
        .bodyToMono(RhssoRokenResponse.class)
        .block()
        .access_token();
  }

}
