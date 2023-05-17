package eai.bff.balance.config;

import eai.bff.balance.service.BalanceApiService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.web.reactive.function.client.ExchangeFilterFunction;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.support.WebClientAdapter;
import org.springframework.web.service.invoker.HttpServiceProxyFactory;
import reactor.netty.http.client.HttpClient;

@Configuration
public class BalanceApiServiceConfig {

  @Value("${api.rest.balance}")
  private String balanceApiUrl;

  @Bean(name = "balanceApiWebClient")
  public WebClient balanceApiWebClient(HttpClient httpClient,
                                       ExchangeFilterFunction oauth2Filter,
                                       ExchangeFilterFunction logRequestFilter,
                                       ExchangeFilterFunction addCustomClaimsFilter,
                                       ExchangeFilterFunction logResponseFilter) {
    return WebClient.builder().baseUrl(balanceApiUrl)
      .clientConnector(new ReactorClientHttpConnector(httpClient))
      .filter(oauth2Filter)
      .filter(addCustomClaimsFilter)
      .filter(logRequestFilter)
      .filter(logResponseFilter)
      .build();
  }

  @Bean(name = "balanceApiServiceProxyFactory")
  public HttpServiceProxyFactory balanceApiServiceProxyFactory(WebClient balanceApiWebClient) {
    return HttpServiceProxyFactory.builder(WebClientAdapter.forClient(balanceApiWebClient)).build();
  }

  @Bean
  public BalanceApiService balanceApiService(HttpServiceProxyFactory balanceApiServiceProxyFactory) {
    return balanceApiServiceProxyFactory.createClient(BalanceApiService.class);
  }
}
