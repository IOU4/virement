package eai.virement.virement;

import java.util.ArrayList;
import java.util.List;

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
  public void afterConnectionEstablished(WebSocketSession session) throws Exception {
    log.info("new connection established {}", session.getId());
    VirementWSHandler.sessions.add(session);
    wsSessionService.sendTotalBySession(session, String.valueOf(virementService.findAll().size()));
  }

  @Override
  public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
    log.info("new message: {}", message.getPayload().toString());
  }

  @Override
  public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
    System.out.println("handleTransportError");
  }

  @Override
  public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
    log.info("connection {} closed with status {}", session.getId(), closeStatus.getCode());
    VirementWSHandler.sessions.remove(session);
  }

  @Override
  public boolean supportsPartialMessages() {
    return false;
  }

}
