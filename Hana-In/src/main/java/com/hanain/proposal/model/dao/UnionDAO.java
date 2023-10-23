package com.hanain.proposal.model.dao;

import com.hanain.proposal.model.dto.UnionDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface UnionDAO {

    List<UnionDTO> getUnionsByProposalIds(Map<String, Object> params);

    void insertUnion(UnionDTO unionDTO);

    void deleteUnion(UnionDTO unionDTO);

    int checkUnion(UnionDTO unionDTO);

}
