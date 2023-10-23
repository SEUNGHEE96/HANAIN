package com.hanain.proposal.model.dao;

import com.hanain.proposal.model.dto.ProposalDTO;
import com.hanain.proposal.model.dto.UnionDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ProposalDAO {

    List<ProposalDTO> getPaginatedProposal(int page);
    int getTotalCount();
    ProposalDTO getProposalById(int proposalId);
    void insertProposal(ProposalDTO proposalDTO);
    void insertProposalParticipation(UnionDTO unionDTO);
    void leaveProposalParticipation(UnionDTO unionDTO);
    List<ProposalDTO> getParticipatedProposalByMemberId(Map<String, Object> params);
    int getProposalCountByMemberId(String memberId);

    List<ProposalDTO> getParticipatedProposalByMemberId2(String memberId);

}
