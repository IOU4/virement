package eai.bff.common.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.ExchangeFilterFunction;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.support.WebClientAdapter;
import org.springframework.web.service.invoker.HttpServiceProxyFactory;

@Configuration
public class ApiServiceConfig {

  @Value("${api.rest.base}")
  private String apiBaseUrl;

  @Bean
  public WebClient apiWebClient(ExchangeFilterFunction oauth2Filter,
                                ExchangeFilterFunction logRequestFilter,
                                ExchangeFilterFunction addCustomClaimsFilter,
                                ExchangeFilterFunction logResponseFilter) {
    return WebClient.builder().baseUrl(apiBaseUrl)
      .filter(oauth2Filter)
      .filter(addCustomClaimsFilter)
      .filter(logRequestFilter)
      .filter(logResponseFilter)
      .build();
  }

  @Bean
  public HttpServiceProxyFactory apiServiceProxyFactory(WebClient apiWebClient) {
    return HttpServiceProxyFactory.builder(WebClientAdapter.forClient(apiWebClient)).build();
  }
}
