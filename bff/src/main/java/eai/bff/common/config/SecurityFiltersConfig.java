package eai.bff.common.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.oauth2.client.ReactiveOAuth2AuthorizedClientManager;
import org.springframework.security.oauth2.client.web.reactive.function.client.ServerOAuth2AuthorizedClientExchangeFilterFunction;
import org.springframework.web.reactive.function.client.ClientRequest;
import org.springframework.web.reactive.function.client.ExchangeFilterFunction;
import reactor.core.publisher.Mono;

import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;

@Configuration
public class SecurityFiltersConfig {

  private final static Logger logger = Logger.getLogger(ApiClientSecurityConfig.class.getName());

  @Bean(name = "oauth2Filter")
  public ServerOAuth2AuthorizedClientExchangeFilterFunction oauth2Filter(ReactiveOAuth2AuthorizedClientManager authorizedClientManager) {
    var oauthFilter = new ServerOAuth2AuthorizedClientExchangeFilterFunction(authorizedClientManager);
    oauthFilter.setDefaultClientRegistrationId("keycloak");
    return oauthFilter;
  }

  @Bean(name = "addCustomClaimsFilter")
  public ExchangeFilterFunction addCustomClaimsFilter(IAuthenticationFacade authenticationFacade) {
    return ExchangeFilterFunction.ofRequestProcessor(clientRequest ->
      authenticationFacade.getAuthentication()
        .map(authentication -> {
          var newRequest = ClientRequest.from(clientRequest);

          Map<String, String> customClaims = new HashMap<>();
          customClaims.put("client-id", Base64.getEncoder().encodeToString(authentication.getName().getBytes()));
          customClaims.put("client-scopes", Base64.getEncoder()
            .encodeToString(authentication.getAuthorities()
              .stream()
              .map(Object::toString)
              .collect(Collectors.joining(","))
              .getBytes()));
          customClaims.forEach(newRequest::header);

          return newRequest.build();
        }));
  }

  @Bean(name = "logRequestFilter")
  public ExchangeFilterFunction logRequestFilter() {
    return ExchangeFilterFunction.ofRequestProcessor(clientRequest ->
      Mono.just(clientRequest)
        .doOnNext(request -> {
          logger.log(Level.INFO, "Client Request Log :" + clientRequest.url());
          logger.log(Level.INFO, "Method: " + clientRequest.method());
          logger.log(Level.INFO, "Headers: ");
          clientRequest.headers().forEach((key, value) -> logger.log(Level.INFO, key + ": " + value));
        }));
  }

  @Bean(name = "logResponseFilter")
  public ExchangeFilterFunction logResponseFilter() {
    return ExchangeFilterFunction.ofResponseProcessor(clientResponse -> Mono.just(clientResponse)
      .doOnNext(response -> {
        logger.log(Level.INFO, "Client Request Log");
        logger.log(Level.INFO, "Headers: ");
        response.headers().asHttpHeaders().forEach((key, value) -> logger.log(Level.INFO, key + ": " + value));
        logger.log(Level.INFO, "Status code: " + response.statusCode());
      }));
  }
}
