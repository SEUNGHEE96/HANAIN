package com.hanain.proposal.service;

import com.hanain.proposal.model.dao.ProposalCommentDAO;
import com.hanain.proposal.model.dto.ProposalCommentDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProposalCommentService {

    @Autowired
    private ProposalCommentDAO proposalCommentDAO;

    public List<ProposalCommentDTO> getCommentsByProposalId(int proposalId) {
        return proposalCommentDAO.getCommentsByProposalId(proposalId);
    }

    public void insertComment(ProposalCommentDTO proposalCommentDTO) {
        proposalCommentDAO.insertComment(proposalCommentDTO);
    }

    public void insertReply(ProposalCommentDTO proposalCommentDTO) {
        proposalCommentDAO.insertReply(proposalCommentDTO);
    }

    public int getCommentCountByProposalId(int proposalId) {
        return proposalCommentDAO.getCommentCountByProposalId(proposalId);
    }

}
