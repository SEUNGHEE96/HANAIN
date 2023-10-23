package com.kopo.mydata.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kopo.mydata.model.dto.BalanceDTO;

@Mapper
public interface BalanceDAO {

    List<BalanceDTO> getBalances(Long accountNumber);

}
