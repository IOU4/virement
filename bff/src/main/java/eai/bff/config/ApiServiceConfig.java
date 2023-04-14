package eai.bff.config;

import eai.bff.exception.VirementApiException;
import eai.bff.service.VirementApiService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatusCode;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.reactive.function.client.support.WebClientAdapter;
import org.springframework.web.service.invoker.HttpServiceProxyFactory;
import reactor.core.publisher.Mono;

@Configuration
public class ApiServiceConfig {

    @Bean
    public WebClient restTemplate() {
        return WebClient
                .builder()
                .baseUrl("http://localhost:8080")
                .defaultStatusHandler(HttpStatusCode::isError, response -> response.bodyToMono(String.class)
                        .flatMap(body -> Mono.error(new VirementApiException(body, response.statusCode()))))
                .build();
    }

    @Bean
    public HttpServiceProxyFactory httpServiceProxyFactory(WebClient webClient) {
        return HttpServiceProxyFactory.builder(WebClientAdapter.forClient(webClient))
                .build();
    }

    @Bean
    public VirementApiService virementApiService(HttpServiceProxyFactory httpServiceProxyFactory) {
        return httpServiceProxyFactory.createClient(VirementApiService.class);
    }
}
