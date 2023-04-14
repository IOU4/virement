package eai.bff.dto;

public record CreateVirementCommand(String agentId, String fromId, String toId, double montant) {
}
