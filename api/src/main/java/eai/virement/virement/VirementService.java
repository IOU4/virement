package eai.virement.virement;

import java.util.List;

import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import eai.virement.util.NotFoundException;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class VirementService {

  private final VirementRepository virementRepository;
  private final WSSessionService wsSessionService;

  public List<VirementDTO> findAll() {
    final List<Virement> virements = virementRepository.findAll(Sort.by("id"));
    return virements.stream()
        .map((virement) -> mapToDTO(virement, new VirementDTO()))
        .toList();
  }

  public VirementDTO get(final Long id) {
    return virementRepository.findById(id)
        .map(virement -> mapToDTO(virement, new VirementDTO()))
        .orElseThrow(NotFoundException::new);
  }

  public Long create(final VirementDTO virementDTO) {
    final Virement virement = new Virement();
    mapToEntity(virementDTO, virement);
    var virementId = virementRepository.save(virement).getId();
    wsSessionService.broadcastTotal();
    return virementId;
  }

  public void update(final Long id, final VirementDTO virementDTO) {
    final Virement virement = virementRepository.findById(id)
        .orElseThrow(NotFoundException::new);
    mapToEntity(virementDTO, virement);
    virementRepository.save(virement);
  }

  public void delete(final Long id) {
    virementRepository.deleteById(id);
    wsSessionService.broadcastTotal();
  }

  private VirementDTO mapToDTO(final Virement virement, final VirementDTO virementDTO) {
    virementDTO.setId(virement.getId());
    virementDTO.setSourceAccount(virement.getSourceAccount());
    virementDTO.setDestinationAccount(virement.getDestinationAccount());
    virementDTO.setAmount(virement.getAmount());
    virementDTO.setAgentId(virement.getAgentId());
    virementDTO.setDateCreated(virement.getDateCreated());
    return virementDTO;
  }

  private Virement mapToEntity(final VirementDTO virementDTO, final Virement virement) {
    virement.setSourceAccount(virementDTO.getSourceAccount());
    virement.setDestinationAccount(virementDTO.getDestinationAccount());
    virement.setAmount(virementDTO.getAmount());
    virement.setAgentId(virementDTO.getAgentId());
    return virement;
  }

}
