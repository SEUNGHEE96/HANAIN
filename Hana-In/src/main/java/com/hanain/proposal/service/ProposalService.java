package com.hanain.proposal.service;

import com.hanain.proposal.model.dao.ProposalDAO;
import com.hanain.proposal.model.dto.ProposalDTO;

import com.hanain.proposal.model.dto.UnionDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ProposalService {

    private static final int PAGE_SIZE = 9;

    @Autowired
    private ProposalDAO proposalDAO;

    public List<ProposalDTO> getPaginatedProposal(int page) {
        return proposalDAO.getPaginatedProposal(page);
    }

    public int getTotalPages() {
        int totalCount = proposalDAO.getTotalCount();
        return (int) Math.ceil((double) totalCount / PAGE_SIZE);
    }

    public ProposalDTO getProposalById(int proposalId) {
        return proposalDAO.getProposalById(proposalId);
    }

    public void insertProposal(ProposalDTO proposalDTO) {
        proposalDAO.insertProposal(proposalDTO);
    }

    public void insertProposalParticipation(UnionDTO unionDTO) {
        proposalDAO.insertProposalParticipation(unionDTO);
    }

    public void leaveProposalParticipation(UnionDTO unionDTO) {
        proposalDAO.leaveProposalParticipation(unionDTO);
    }

    public List<ProposalDTO> getParticipatedProposalByMemberId(Map<String, Object> params) {
        return proposalDAO.getParticipatedProposalByMemberId(params);
    }

    public int getProposalCountByMemberId(String memberId) {
        return proposalDAO.getProposalCountByMemberId(memberId);
    }

    public List<ProposalDTO> getParticipatedProposalByMemberId2(String memberId) {
        return proposalDAO.getParticipatedProposalByMemberId2(memberId);
    }

}
