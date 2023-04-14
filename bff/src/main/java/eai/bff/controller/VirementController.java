package eai.bff.controller;

import eai.bff.dto.CreateVirementCommand;
import eai.bff.dto.VirementResponse;
import eai.bff.service.VirementApiService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@ResponseStatus(HttpStatus.OK)
public class VirementController {

    private final VirementApiService virementService;

    public VirementController(VirementApiService service) {
        this.virementService = service;
    }

    @GetMapping("/")
    public List<VirementResponse> getAllVirements() {
        return virementService.getAllVirements();
    }

    @GetMapping("/{id}")
    public VirementResponse getVirementById(@PathVariable String id) {
        return virementService.getVirementById(id);
    }

    @PostMapping("/")
    @ResponseStatus(HttpStatus.CREATED)
    public VirementResponse createVirement(CreateVirementCommand command) {
        return virementService.createVirement(command);
    }
}
