package eai.bff.dto;

import java.time.Instant;

public record VirementResponse(String id, String agentId, String fromId, String toId, double montant, Instant date) {
}
