package eai.bff.service;

import eai.bff.dto.CreateVirementCommand;
import eai.bff.dto.VirementResponse;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.service.annotation.GetExchange;
import org.springframework.web.service.annotation.HttpExchange;
import org.springframework.web.service.annotation.PostExchange;

import java.util.List;

@HttpExchange(url = "/api/virements")
public interface VirementApiService {

    @GetExchange(url = "/")
    List<VirementResponse> getAllVirements();

    @GetExchange(url = "/{id}")
    VirementResponse getVirementById(@PathVariable String id);

    @PostExchange(url = "/")
    VirementResponse createVirement(CreateVirementCommand command);
}
