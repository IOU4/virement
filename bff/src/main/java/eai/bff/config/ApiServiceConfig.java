package eai.bff.config;

import eai.bff.service.VirementApiService;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.support.WebClientAdapter;
import org.springframework.web.service.invoker.HttpServiceProxyFactory;

@Configuration
public class ApiServiceConfig {

  @Value("${api.url}")
  private String apiUrl;

  @Bean
  public WebClient restTemplate() {
    return WebClient
        .builder()
        .baseUrl(apiUrl)
        .build();
  }

  @Bean("tokenWebClient")
  public WebClient tokenWebClient() {
    return WebClient
        .builder()
        .baseUrl("https://eai-rhsso.serveo.net")
        .build();
  }

  @Bean
  public HttpServiceProxyFactory httpServiceProxyFactory(@Qualifier("restTemplate") WebClient webClient) {
    return HttpServiceProxyFactory.builder(WebClientAdapter.forClient(webClient))
        .build();
  }

  @Bean
  public VirementApiService virementApiService(HttpServiceProxyFactory httpServiceProxyFactory) {
    return httpServiceProxyFactory.createClient(VirementApiService.class);
  }

}
