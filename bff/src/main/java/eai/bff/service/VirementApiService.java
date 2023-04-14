package eai.bff.service;

import eai.bff.dto.CreateVirementCommand;
import eai.bff.dto.VirementResponse;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.service.annotation.GetExchange;
import org.springframework.web.service.annotation.PostExchange;

import java.util.List;

public interface VirementApiService {

    @GetExchange(url = "/", accept = "application/json")
    List<VirementResponse> getAllVirements();

    @GetExchange(url = "/{id}", accept = "application/json")
    VirementResponse getVirementById(@PathVariable String id);

    @PostExchange(url = "/", accept = "application/json", contentType = "application/json")
    VirementResponse createVirement(CreateVirementCommand command);
}
