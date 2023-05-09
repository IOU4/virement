package eai.bff.common.config;

import org.springframework.security.core.Authentication;
import reactor.core.publisher.Mono;

public interface IAuthenticationFacade {
  Mono<Authentication> getAuthentication();
}
