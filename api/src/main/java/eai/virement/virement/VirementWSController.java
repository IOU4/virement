package eai.virement.virement;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;

/**
 * VirementWSController
 */
@Controller
@RequiredArgsConstructor
public class VirementWSController {

  private final VirementService virementService;
  private final ObjectMapper objectMapper;

  @MessageMapping("/virements")
  @SendTo("/topic/virements")
  public String getAll() throws JsonProcessingException {
    return objectMapper.writeValueAsString(virementService.findAll());
  }
}
