package eai.virement.virement;

import eai.virement.util.NotFoundException;
import java.util.List;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

@Service
public class VirementService {

  private final VirementRepository virementRepository;

  public VirementService(final VirementRepository virementRepository) {
    this.virementRepository = virementRepository;
  }

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
    return virementRepository.save(virement).getId();
  }

  public void update(final Long id, final VirementDTO virementDTO) {
    final Virement virement = virementRepository.findById(id)
        .orElseThrow(NotFoundException::new);
    mapToEntity(virementDTO, virement);
    virementRepository.save(virement);
  }

  public void delete(final Long id) {
    virementRepository.deleteById(id);
  }

  private VirementDTO mapToDTO(final Virement virement, final VirementDTO virementDTO) {
    virementDTO.setId(virement.getId());
    virementDTO.setSourceAccount(virement.getFromId());
    virementDTO.setDestinationAccount(virement.getToId());
    virementDTO.setAmount(virement.getAmount());
    virementDTO.setAgentId(virement.getAgentId());
    return virementDTO;
  }

  private Virement mapToEntity(final VirementDTO virementDTO, final Virement virement) {
    virement.setFromId(virementDTO.getSourceAccount());
    virement.setToId(virementDTO.getDestinationAccount());
    virement.setAmount(virementDTO.getAmount());
    virement.setAgentId(virementDTO.getAgentId());
    return virement;
  }

}
