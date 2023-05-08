package eai.virement.virement;

import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import lombok.extern.slf4j.Slf4j;

/**
 * WSSessionService
 */
@Service
@Slf4j
public class WSSessionService {

  public void broadcastMessage(String message) {
    VirementWSHandler.sessions.forEach(s -> {
      try {
        s.sendMessage(new TextMessage(message));
      } catch (IOException e) {
        log.error("IOException while");
      }
    });
  }

  public void sendTotalBySession(WebSocketSession session, String message) {
    try {
      session.sendMessage(new TextMessage(message));
    } catch (IOException e) {
      log.error(e.getMessage());
    }
  }

}
