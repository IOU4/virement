package eai.bff.service;

import eai.bff.dto.CreateVirementCommand;
import eai.bff.dto.VirementResponse;
import org.springframework.http.MediaType;
import org.springframework.http.codec.ServerSentEvent;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.service.annotation.DeleteExchange;
import org.springframework.web.service.annotation.GetExchange;
import org.springframework.web.service.annotation.HttpExchange;
import org.springframework.web.service.annotation.PostExchange;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.math.BigDecimal;

@HttpExchange(url = "/virements", accept = "application/json")
public interface VirementApiService {

  @GetExchange()
  Flux<VirementResponse> getAllVirements();

  @GetExchange(url = "/{id}")
  Mono<VirementResponse> getVirementById(@PathVariable String id);

  @GetExchange(url = "/sse/sold", accept = MediaType.TEXT_EVENT_STREAM_VALUE)
  Flux<ServerSentEvent<BigDecimal>> getSoldSSE();

  @PostExchange(contentType = "application/json")
  Mono<Long> createVirement(@RequestBody CreateVirementCommand command);

  @DeleteExchange(url = "/{id}")
  Mono<Void> removeVirement(@PathVariable String id);
}
