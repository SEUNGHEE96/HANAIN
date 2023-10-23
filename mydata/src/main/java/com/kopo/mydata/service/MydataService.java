package com.kopo.mydata.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kopo.mydata.model.dao.AccountDAO;
import com.kopo.mydata.model.dao.BalanceDAO;
import com.kopo.mydata.model.dao.CIDAO;
import com.kopo.mydata.model.dto.AccountDTO;
import com.kopo.mydata.model.dto.BalanceDTO;
import com.kopo.mydata.model.dto.CIDTO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MydataService {

    private final AccountDAO accountDAO;
    private final BalanceDAO balanceDAO;
    private final CIDAO cidao;

    public CIDTO getCI(String identification) {
        return cidao.getCI(identification);
    }

    public List<AccountDTO> getAccounts(String ci) {
        return accountDAO.getAccounts(ci);
    }

    public List<BalanceDTO> getBalances(Long accountNumber) {
        return balanceDAO.getBalances(accountNumber);
    }

}
