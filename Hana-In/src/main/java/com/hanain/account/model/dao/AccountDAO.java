package com.hanain.account.model.dao;

import com.hanain.account.model.dto.AccountDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface AccountDAO {

    List<AccountDTO> getAllAccount();
    List<AccountDTO> getHanaAccountById(String memberId);
    AccountDTO getAccountByNumber(long accountNumber);
    AccountDTO getAccountById(int accountId);
    void updateCash(AccountDTO accountDTO);
    List<AccountDTO> getAccountByMemberId(String memberId);
    void insertAccount(AccountDTO accountDTO);

}
