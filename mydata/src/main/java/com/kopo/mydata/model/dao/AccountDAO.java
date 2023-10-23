package com.kopo.mydata.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.kopo.mydata.model.dto.AccountDTO;

@Mapper
public interface AccountDAO {

    List<AccountDTO> getAccounts(String ci);

}
