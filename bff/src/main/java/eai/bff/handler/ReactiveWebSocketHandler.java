package eai.bff.handler;

import jakarta.annotation.Nonnull;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.socket.WebSocketHandler;
import org.springframework.web.reactive.socket.WebSocketMessage;
import org.springframework.web.reactive.socket.WebSocketSession;
import org.springframework.web.reactive.socket.client.WebSocketClient;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.logging.Level;
import java.util.logging.Logger;

@Service
public class ReactiveWebSocketHandler implements WebSocketHandler {

  @Value("${api.websocket}")
  private String apiWebsocket;
  private final WebSocketClient client;
  private final static Logger logger = Logger.getLogger(ReactiveWebSocketHandler.class.getName());

  public ReactiveWebSocketHandler(WebSocketClient client) {
    this.client = client;
  }

  @Override
  @Nonnull
  public Mono<Void> handle(@Nonnull WebSocketSession session) {
    URI url;

    try {
      url = new URI(apiWebsocket + "/total");
    } catch (URISyntaxException e) {
      throw new RuntimeException(e);
    }

    return client.execute(url,
      virementApiSession -> {
        logger.log(Level.INFO, "Connected Successfully!");

        Flux<String> messages = virementApiSession.receive()
          .map(WebSocketMessage::getPayloadAsText);

        return session.send(messages
          .doOnNext(message -> logger.log(Level.INFO, "Incoming Message: " + message))
          .map(session::textMessage)
          .doAfterTerminate(() -> logger.log(Level.INFO, "Session Terminated!"))
        );
      });
  }

}
