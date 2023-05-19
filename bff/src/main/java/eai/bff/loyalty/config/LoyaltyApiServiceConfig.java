package eai.bff.loyalty.config;

import eai.bff.loyalty.service.LoyaltyApiService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.service.invoker.HttpServiceProxyFactory;

@Configuration
public class LoyaltyApiServiceConfig {
  @Bean
  public LoyaltyApiService loyaltyApiService(HttpServiceProxyFactory apiServiceProxyFactory) {
    return apiServiceProxyFactory.createClient(LoyaltyApiService.class);
  }
}
