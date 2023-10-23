package com.hanain.proposal.service;

import com.hanain.proposal.model.dao.UnionDAO;
import com.hanain.proposal.model.dto.UnionDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class UnionService {

    @Autowired
    private UnionDAO unionDAO;

    public List<UnionDTO> getUnionsByProposalIds (Map<String, Object> params) {
        return unionDAO.getUnionsByProposalIds(params);
    }

    public void insertUnion(UnionDTO unionDTO) {
        unionDAO.insertUnion(unionDTO);
    }

    public void deleteUnion(UnionDTO unionDTO) {
        unionDAO.deleteUnion(unionDTO);
    }

    public int checkUnion(UnionDTO unionDTO) {
        return unionDAO.checkUnion(unionDTO);
    }

}
