package com.hanain.account.service;

import com.hanain.account.model.dao.BalanceDAO;
import com.hanain.account.model.dto.BalanceDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class BalanceService {

    @Autowired
    private BalanceDAO balanceDAO;
    /* Balances 테이블 관련 */

    public List<BalanceDTO> getAllBalance() {
        return balanceDAO.getAllBalance();
    }

    public BalanceDTO getSellableQuantity(Map<String, Object> params) {
        return balanceDAO.getSellableQuantity(params);
    }

    public List<BalanceDTO> getBalanceByMemberId(String memberId) {
        return balanceDAO.getBalanceByMemberId(memberId);
    }

    public List<BalanceDTO> getBalanceByAccountNumber(long accountNumber) {
        return balanceDAO.getBalanceByAccountNumber(accountNumber);
    }
    public void insertBalance(BalanceDTO balanceDTO) {
        balanceDAO.insertBalance(balanceDTO);
    }
}
