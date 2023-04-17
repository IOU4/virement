package eai.virement.virement;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonFormat;

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
  private String sourceAccount;

  @NotNull
  @Size(max = 255)
  private String destinationAccount;

  @NotNull
  @Digits(integer = 10, fraction = 10)
  @JsonFormat(shape = JsonFormat.Shape.STRING)
  private BigDecimal amount;

  @NotNull
  @Size(max = 255)
  private String agentId;

}
