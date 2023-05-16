package eai.bff.virement.controller;

import eai.bff.virement.dto.CreateVirementCommand;
import eai.bff.virement.dto.VirementCreatedResponse;
import eai.bff.virement.service.VirementApiService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

@RestController
@RequestMapping("/")
@ResponseStatus(HttpStatus.OK)
public class VirementController {

  private final VirementApiService virementService;

  public VirementController(VirementApiService service) {
    this.virementService = service;
  }

  @PostMapping
  @ResponseStatus(HttpStatus.CREATED)
  public Mono<VirementCreatedResponse> createVirement(@RequestBody CreateVirementCommand command) {
    return virementService.createVirement(command);
  }
}
