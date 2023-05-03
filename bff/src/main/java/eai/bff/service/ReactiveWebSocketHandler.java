package eai.bff.service;

import org.springframework.stereotype.Service;
import org.springframework.web.reactive.socket.WebSocketHandler;
import org.springframework.web.reactive.socket.WebSocketSession;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.Duration;
import java.util.Random;

@Service
public class ReactiveWebSocketHandler implements WebSocketHandler {

  @Override
  public Mono<Void> handle(WebSocketSession session) {
    Random random = new Random();
    return session.send(Flux.interval(Duration.ofSeconds(1))
      .map(i -> random.nextDouble(100))
      .map(String::valueOf)
      .map(session::textMessage)
    );
  }

}
