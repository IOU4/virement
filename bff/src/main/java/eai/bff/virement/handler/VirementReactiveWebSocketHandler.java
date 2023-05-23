package eai.bff.virement.handler;

import jakarta.annotation.Nonnull;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.socket.WebSocketHandler;
import org.springframework.web.reactive.socket.WebSocketMessage;
import org.springframework.web.reactive.socket.WebSocketSession;
import org.springframework.web.reactive.socket.client.WebSocketClient;
import reactor.core.publisher.Mono;

import java.net.URI;
import java.net.URISyntaxException;
import java.util.logging.Level;
import java.util.logging.Logger;

@Service
public class VirementReactiveWebSocketHandler implements WebSocketHandler {

  @Value("${api.websocket.virement}")
  private String virementApiTopicWebSocketUrl;

  private final WebSocketClient client;
  private final static Logger logger = Logger.getLogger(VirementReactiveWebSocketHandler.class.getName());

  public VirementReactiveWebSocketHandler(WebSocketClient client) {
    this.client = client;
  }

  @Override
  @Nonnull
  public Mono<Void> handle(@Nonnull WebSocketSession session) {
    URI url;

    try {
      url = new URI(virementApiTopicWebSocketUrl + "/total");
    } catch (URISyntaxException e) {
      throw new RuntimeException(e);
    }

    return client.execute(url,
      virementApiSession -> session.send(virementApiSession.receive()
        .doOnSubscribe(subscription -> session.getHandshakeInfo().getPrincipal().doOnNext(principal ->
            logger.log(Level.INFO, "User : " + principal.getName() + "Session Terminated!")
          )
        )
        .map(WebSocketMessage::getPayloadAsText)
        .doOnNext(message -> logger.log(Level.INFO, "Incoming Message: " + message))
        .map(session::textMessage)
        .doOnTerminate(() -> logger.log(Level.INFO, "Session Terminated!"))
      )
    );
  }

}
