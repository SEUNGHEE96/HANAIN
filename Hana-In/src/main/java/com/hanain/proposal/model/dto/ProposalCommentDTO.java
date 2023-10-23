package com.hanain.proposal.model.dto;

import lombok.Data;

@Data
public class ProposalCommentDTO {

        int proposalCommentId;
        String memberId;
        int proposalId;
        int parent;
        int indent;
        String content;
        String regDate;

}
