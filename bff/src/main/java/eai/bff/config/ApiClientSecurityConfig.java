package eai.bff.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.oauth2.client.ReactiveOAuth2AuthorizedClientManager;
import org.springframework.security.oauth2.client.ReactiveOAuth2AuthorizedClientProviderBuilder;
import org.springframework.security.oauth2.client.registration.ReactiveClientRegistrationRepository;
import org.springframework.security.oauth2.client.web.DefaultReactiveOAuth2AuthorizedClientManager;
import org.springframework.security.oauth2.client.web.reactive.function.client.ServerOAuth2AuthorizedClientExchangeFilterFunction;
import org.springframework.security.oauth2.client.web.server.ServerOAuth2AuthorizedClientRepository;
import org.springframework.security.web.server.SecurityWebFilterChain;
import org.springframework.web.reactive.function.client.ExchangeFilterFunction;
import reactor.core.publisher.Mono;

import java.util.logging.Level;
import java.util.logging.Logger;

@Configuration
public class ApiClientSecurityConfig {

  private final static Logger logger = Logger.getLogger(ApiClientSecurityConfig.class.getName());

  @Bean
  public ReactiveOAuth2AuthorizedClientManager authorizedClientManager(ReactiveClientRegistrationRepository clientRegistrationRepository, ServerOAuth2AuthorizedClientRepository authorizedClientRepository) {
    var authorizedClientProvider = ReactiveOAuth2AuthorizedClientProviderBuilder.builder().clientCredentials().build();
    var authorizedClientManager = new DefaultReactiveOAuth2AuthorizedClientManager(clientRegistrationRepository, authorizedClientRepository);

    authorizedClientManager.setAuthorizedClientProvider(authorizedClientProvider);

    return authorizedClientManager;
  }

  @Bean
  public SecurityWebFilterChain springSecurityFilterChain(ServerHttpSecurity http) {
    return http.cors(cors -> cors.configurationSource(request -> {
        var corsConfiguration = new org.springframework.web.cors.CorsConfiguration();
        corsConfiguration.addAllowedOrigin("*");
        corsConfiguration.addAllowedMethod("*");
        corsConfiguration.addAllowedHeader("*");
        return corsConfiguration;
      }))
      .oauth2Client().and()
      .csrf(ServerHttpSecurity.CsrfSpec::disable)
      .build();
  }

  @Bean
  public ServerOAuth2AuthorizedClientExchangeFilterFunction oauth2Filter(ReactiveOAuth2AuthorizedClientManager authorizedClientManager) {
    var oauthFilter = new ServerOAuth2AuthorizedClientExchangeFilterFunction(authorizedClientManager);
    oauthFilter.setDefaultClientRegistrationId("keycloak");
    return oauthFilter;
  }

  @Bean
  public ExchangeFilterFunction logRequestFilter() {
    return ExchangeFilterFunction.ofRequestProcessor(clientRequest -> {
      logger.log(Level.INFO, "Client Request Log :" + clientRequest.url());
      logger.log(Level.INFO, "Headers: ");
      clientRequest.headers().forEach((key, value) -> logger.log(Level.INFO, key + ": " + value));

      return Mono.just(clientRequest);
    });
  }

}
