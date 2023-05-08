package eai.virement.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import eai.virement.virement.VirementWSHandler;
import lombok.RequiredArgsConstructor;

/**
 * WebSocketConfig
 */
@Configuration
@EnableWebSocket
@RequiredArgsConstructor
public class WebSocketConfig implements WebSocketConfigurer {

  private final VirementWSHandler virementWSHandler;

  @Override
  public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
    registry.addHandler(virementWSHandler, "/virements/total").setAllowedOriginPatterns("*");
  }

}
