package eai.virement.virement;

import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.socket.TextMessage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * WSSessionService
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class WSSessionService {

  private VirementService virementService;

  public void broadcastTotal() {
    VirementWSHandler.sessions.forEach(s -> {
      try {
        s.sendMessage(new TextMessage(String.valueOf(virementService.findAll().size())));
      } catch (IOException e) {
        log.error("IOException while");
      }
    });
  }

}
