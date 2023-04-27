package eai.bff.controller;

import eai.bff.dto.CreateVirementCommand;
import eai.bff.dto.VirementResponse;
import eai.bff.service.VirementApiService;
import org.springframework.http.HttpStatus;
import org.springframework.http.codec.ServerSentEvent;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.math.BigDecimal;

@RestController
@ResponseStatus(HttpStatus.OK)
public class VirementController {

  private final VirementApiService virementService;

  public VirementController(VirementApiService service) {
    this.virementService = service;
  }

  @GetMapping("/")
  public Flux<VirementResponse> getAllVirements() {
    return virementService.getAllVirements();
  }

  @GetMapping("/{id}")
  public Mono<VirementResponse> getVirementById(@PathVariable String id) {
    return virementService.getVirementById(id);
  }

  @GetMapping("/sse/sold")
  public Flux<ServerSentEvent<BigDecimal>> getSoldSSE() {
    return virementService.getSoldSSE();
  }

  @PostMapping("/")
  @ResponseStatus(HttpStatus.CREATED)
  public Mono<Long> createVirement(@RequestBody CreateVirementCommand command) {
    return virementService.createVirement(command);
  }

  @DeleteMapping("/{id}")
  public Mono<Void> removeVirement(@PathVariable String id) {
    return virementService.removeVirement(id);
  }
}
