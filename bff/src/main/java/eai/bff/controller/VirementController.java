package eai.bff.controller;

import eai.bff.dto.CreateVirementCommand;
import eai.bff.dto.VirementResponse;
import eai.bff.service.VirementApiService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController(value = "/api/virements")
@ResponseStatus(HttpStatus.OK)
@RequestMapping("/api/virements")
@RequiredArgsConstructor
@CrossOrigin(origins = "http://localhost:4200", methods = {RequestMethod.GET, RequestMethod.POST}, allowCredentials = "true")
public class VirementController {

    private final VirementApiService virementService;

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
