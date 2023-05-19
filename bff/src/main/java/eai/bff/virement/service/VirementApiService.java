package eai.bff.virement.service;

import eai.bff.virement.dto.CreateVirementCommand;
import eai.bff.virement.dto.VirementCreatedResponse;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.service.annotation.HttpExchange;
import org.springframework.web.service.annotation.PostExchange;
import reactor.core.publisher.Mono;

@HttpExchange(url = "${api.rest.endpoints.virement}", contentType = "application/json", accept = "application/json")
public interface VirementApiService {

  @PostExchange
  Mono<VirementCreatedResponse> createVirement(@RequestBody CreateVirementCommand command);

}
