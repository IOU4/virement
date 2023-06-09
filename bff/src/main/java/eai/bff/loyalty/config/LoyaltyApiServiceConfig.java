package eai.bff.loyalty.config;

import eai.bff.loyalty.service.LoyaltyApiService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.ExchangeFilterFunction;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.support.WebClientAdapter;
import org.springframework.web.service.invoker.HttpServiceProxyFactory;

@Configuration
public class LoyaltyApiServiceConfig {

  @Value("${api.rest.loyalty}")
  private String loyaltyApiUrl;

  @Bean(name = "loyaltyApiWebClient")
  public WebClient loyaltyApiWebClient(ExchangeFilterFunction oauth2Filter,
                                       ExchangeFilterFunction logRequestFilter,
                                       ExchangeFilterFunction addCustomClaimsFilter,
                                       ExchangeFilterFunction logResponseFilter) {
    return WebClient.builder().baseUrl(loyaltyApiUrl)
      .filter(oauth2Filter)
      .filter(addCustomClaimsFilter)
      .filter(logRequestFilter)
      .filter(logResponseFilter)
      .build();
  }

  @Bean(name = "loyaltyApiServiceProxyFactory")
  public HttpServiceProxyFactory loyaltyApiServiceProxyFactory(WebClient loyaltyApiWebClient) {
    return HttpServiceProxyFactory.builder(WebClientAdapter.forClient(loyaltyApiWebClient)).build();
  }
  @Bean
  public LoyaltyApiService loyaltyApiService(HttpServiceProxyFactory loyaltyApiServiceProxyFactory) {
    return loyaltyApiServiceProxyFactory.createClient(LoyaltyApiService.class);
  }
}
