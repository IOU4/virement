package eai.bff.service;

import eai.bff.dto.CreateVirementCommand;
import eai.bff.dto.VirementResponse;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.service.annotation.DeleteExchange;
import org.springframework.web.service.annotation.GetExchange;
import org.springframework.web.service.annotation.HttpExchange;
import org.springframework.web.service.annotation.PostExchange;

import java.util.List;

@HttpExchange(url = "/api/virements", accept = "application/json")
public interface VirementApiService {

    @GetExchange()
    List<VirementResponse> getAllVirements();

    @GetExchange(url = "/{id}")
    VirementResponse getVirementById(@PathVariable String id);

    @PostExchange(contentType = "application/json")
    Long createVirement(@RequestBody CreateVirementCommand command);

    @DeleteExchange(url = "/{id}")
    void removeVirement(@PathVariable String id);
}
