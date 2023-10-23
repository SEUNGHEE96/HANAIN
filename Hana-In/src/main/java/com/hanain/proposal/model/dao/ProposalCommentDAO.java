package com.hanain.proposal.model.dao;

import com.hanain.proposal.model.dto.ProposalCommentDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ProposalCommentDAO {

    List<ProposalCommentDTO> getCommentsByProposalId(int proposalId);

    void insertComment(ProposalCommentDTO proposalCommentDTO);

    void insertReply(ProposalCommentDTO proposalCommentDTO);

    int getCommentCountByProposalId(int proposalId);

}
