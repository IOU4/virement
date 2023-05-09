package eai.bff.balance.config;

import eai.bff.balance.service.BalanceApiService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.service.invoker.HttpServiceProxyFactory;

@Configuration
public class BalanceApiServiceConfig {
  @Bean
  public BalanceApiService balanceApiService(HttpServiceProxyFactory httpServiceProxyFactory) {
    return httpServiceProxyFactory.createClient(BalanceApiService.class);
  }
}
