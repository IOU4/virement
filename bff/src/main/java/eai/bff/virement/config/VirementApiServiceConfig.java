package eai.bff.virement.config;

import eai.bff.virement.service.VirementApiService;
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
public class VirementApiServiceConfig {

  @Value("${api.rest.virement}")
  private String virementApiUrl;

  @Bean(name = "virementApiWebClient")
  public WebClient virementApiWebClient(HttpClient httpClient,
                                        ExchangeFilterFunction oauth2Filter,
                                        ExchangeFilterFunction logRequestFilter,
                                        ExchangeFilterFunction addCustomClaimsFilter,
                                        ExchangeFilterFunction logResponseFilter) {
    return WebClient.builder().baseUrl(virementApiUrl)
      .clientConnector(new ReactorClientHttpConnector(httpClient))
      .filter(oauth2Filter)
      .filter(addCustomClaimsFilter)
      .filter(logRequestFilter)
      .filter(logResponseFilter)
      .build();
  }

  @Bean(name = "virementApiServiceProxyFactory")
  public HttpServiceProxyFactory virementApiServiceProxyFactory(WebClient virementApiWebClient) {
    return HttpServiceProxyFactory.builder(WebClientAdapter.forClient(virementApiWebClient)).build();
  }
  @Bean
  public VirementApiService virementApiService(HttpServiceProxyFactory virementApiServiceProxyFactory) {
    return virementApiServiceProxyFactory.createClient(VirementApiService.class);
  }
}
