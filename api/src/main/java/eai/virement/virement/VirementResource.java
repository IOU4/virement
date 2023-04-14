package eai.virement.virement;

import jakarta.validation.Valid;
import java.util.List;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/api/virement", produces = MediaType.APPLICATION_JSON_VALUE)
public class VirementResource {

    private final VirementService virementService;

    public VirementResource(final VirementService virementService) {
        this.virementService = virementService;
    }

    @GetMapping
    public ResponseEntity<List<VirementDTO>> getAllVirements() {
        return ResponseEntity.ok(virementService.findAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<VirementDTO> getVirement(@PathVariable final Long id) {
        return ResponseEntity.ok(virementService.get(id));
    }

    @PostMapping
    public ResponseEntity<Long> createVirement(@RequestBody @Valid final VirementDTO virementDTO) {
        return new ResponseEntity<>(virementService.create(virementDTO), HttpStatus.CREATED);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Void> updateVirement(@PathVariable final Long id,
            @RequestBody @Valid final VirementDTO virementDTO) {
        virementService.update(id, virementDTO);
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteVirement(@PathVariable final Long id) {
        virementService.delete(id);
        return ResponseEntity.noContent().build();
    }

}
