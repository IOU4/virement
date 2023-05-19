package eai.virement.virement;

import java.util.ArrayList;
import java.util.List;

import jakarta.annotation.Nonnull;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * VirementWSHandler
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class VirementWSHandler implements WebSocketHandler {

  public final WSSessionService wsSessionService;
  public final VirementService virementService;

  public static List<WebSocketSession> sessions = new ArrayList<>();

  @Override
  public void afterConnectionEstablished(WebSocketSession session) {
    log.info("new connection established {}", session.getId());
    VirementWSHandler.sessions.add(session);
    wsSessionService.sendTotalBySession(session, String.valueOf(virementService.findAll().size()));
  }

  @Override
  public void handleMessage(@Nonnull WebSocketSession session, WebSocketMessage<?> message) {
    log.info("new message: {}", message.getPayload());
  }

  @Override
  public void handleTransportError(@Nonnull WebSocketSession session, @Nonnull Throwable exception) {
    System.out.println("handleTransportError");
  }

  @Override
  public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) {
    log.info("connection {} closed with status {}", session.getId(), closeStatus.getCode());
    VirementWSHandler.sessions.remove(session);
  }

  @Override
  public boolean supportsPartialMessages() {
    return false;
  }

}
