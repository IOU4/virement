package eai.virement.virement;

import java.math.BigDecimal;

import jakarta.validation.constraints.Digits;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class VirementDTO {

  private Long id;

  @NotNull
  @Size(max = 255)
  private String fromId;

  @NotNull
  @Size(max = 255)
  private String toId;

  @NotNull
  @Digits(integer = 10, fraction = 10)
  private BigDecimal amount;

  @NotNull
  @Size(max = 255)
  private String agentId;

}
