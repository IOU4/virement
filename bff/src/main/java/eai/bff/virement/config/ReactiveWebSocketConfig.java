package eai.bff.virement.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.reactive.HandlerMapping;
import org.springframework.web.reactive.handler.SimpleUrlHandlerMapping;
import org.springframework.web.reactive.socket.WebSocketHandler;
import org.springframework.web.reactive.socket.client.ReactorNettyWebSocketClient;
import org.springframework.web.reactive.socket.server.upgrade.ReactorNettyRequestUpgradeStrategy;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class ReactiveWebSocketConfig {

  @Value("${api.websocket.topics.virement}")
  private String apiVirementTopicWebSocketUrl;

  @Bean
  public HandlerMapping webSocketHandlerMapping(WebSocketHandler handler) {
    Map<String, WebSocketHandler> map = new HashMap<>();
    map.put(apiVirementTopicWebSocketUrl + "/total", handler);

    SimpleUrlHandlerMapping handlerMapping = new SimpleUrlHandlerMapping();
    handlerMapping.setUrlMap(map);
    handlerMapping.setOrder(Ordered.HIGHEST_PRECEDENCE);
    return handlerMapping;
  }

  @Bean
  public ReactorNettyRequestUpgradeStrategy upgradeStrategy() {
    return new ReactorNettyRequestUpgradeStrategy();
  }

  @Bean
  public ReactorNettyWebSocketClient webSocketClient() {
    return new ReactorNettyWebSocketClient();
  }

}
