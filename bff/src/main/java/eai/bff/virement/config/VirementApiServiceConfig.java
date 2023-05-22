package eai.bff.virement.config;

import eai.bff.virement.service.VirementApiService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.service.invoker.HttpServiceProxyFactory;

@Configuration
public class VirementApiServiceConfig {
  @Bean
  public VirementApiService virementApiService(HttpServiceProxyFactory apiServiceProxyFactory) {
    return apiServiceProxyFactory.createClient(VirementApiService.class);
  }
}
