package com.hanain.account.model.dao;

import com.hanain.account.model.dto.BalanceDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@Mapper
public interface BalanceDAO {

    List<BalanceDTO> getAllBalance();

    BalanceDTO getSellableQuantity(Map<String, Object> params);

    Optional<BalanceDTO> findByAccountIdAndIsin(Map<String, Object> params);

    void updateBalance(BalanceDTO balanceDTO);

    void insertBalance(BalanceDTO balanceDTO);

    List<BalanceDTO> getBalanceByMemberId(String memberId);

    List<BalanceDTO> getBalanceByAccountNumber(long accountNumber);

}
