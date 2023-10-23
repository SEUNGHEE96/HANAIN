package com.hanain.account.service;

import com.hanain.account.model.dao.AccountDAO;
import com.hanain.account.model.dao.BalanceDAO;
import com.hanain.account.model.dao.TradeDAO;
import com.hanain.account.model.dto.AccountDTO;
import com.hanain.account.model.dto.BalanceDTO;
import com.hanain.account.model.dto.TradeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@Service
public class AccountService {

    @Autowired
    private AccountDAO accountDAO;

    @Autowired
    private BalanceDAO balanceDAO;

    @Autowired
    private TradeDAO tradeDAO;

    public List<AccountDTO> getAllAccount() {
        return accountDAO.getAllAccount();
    }

    public List<AccountDTO> getHanaAccountById(String memberId) {
        return accountDAO.getHanaAccountById(memberId);
    }

    public AccountDTO getAccountByNumber(long accountNumber) {
        return accountDAO.getAccountByNumber(accountNumber);
    }

    /**
     * 주식 매수 -> 트랜잭션 제어 처리
     */
    @Transactional
    public void buyStock(TradeDTO trade, BalanceDTO balance, AccountDTO account) {
        // TradeDTOs 테이블에 데이터 삽입
        tradeDAO.insertTrade(trade);

        // BalanceDTOs 테이블에서 주식 확인 및 업데이트 또는 삽입
        Map<String, Object> params = new HashMap<>();
        params.put("accountId", trade.getAccountId());
        params.put("isin", trade.getIsin());

        Optional<BalanceDTO> existingBalanceDTO = balanceDAO.findByAccountIdAndIsin(params);
        if(existingBalanceDTO.isPresent()) {
            // 기존에 구매한 주식이 있다면 업데이트
            BalanceDTO originBalanceDTO = existingBalanceDTO.get();
            // 가지고 있는 QUANTITY와 AVERAGE_PRICE를 업데이트
            originBalanceDTO.setAveragePrice((originBalanceDTO.getAveragePrice() * originBalanceDTO.getQuantity() + trade.getPrice() * trade.getQuantity()) / (originBalanceDTO.getQuantity() + trade.getQuantity()));
            originBalanceDTO.setQuantity(originBalanceDTO.getQuantity() + trade.getQuantity());
            balanceDAO.updateBalance(originBalanceDTO);
            // 추후 GRADE_ID를 업데이트하는 로직 필요
        } else {
            // 새로 구매하는 주식이면 삽입
            balanceDAO.insertBalance(balance);
            // 추후 GRADE_ID를 업데이트하는 로직 필요
        }

        // AccountDTOs 테이블 업데이트
        AccountDTO existingAccountDTO = accountDAO.getAccountById(account.getAccountId());
        existingAccountDTO.setCash(existingAccountDTO.getCash() - trade.getPrice() * trade.getQuantity());
        accountDAO.updateCash(existingAccountDTO);
    }

    /**
     * 주식 매도 -> 트랜잭션 제어 처리
     */
    @Transactional
    public void sellStock(TradeDTO trade, BalanceDTO balance, AccountDTO account) {
        // TradeDTOs 테이블에 데이터 삽입
        tradeDAO.insertTrade(trade);

        // BalanceDTOs 테이블에서 주식 확인 및 업데이트 또는 삽입
        Map<String, Object> params = new HashMap<>();
        params.put("accountId", trade.getAccountId());
        params.put("isin", trade.getIsin());

        Optional<BalanceDTO> existingBalanceDTO = balanceDAO.findByAccountIdAndIsin(params);
        if(existingBalanceDTO.isPresent()) {
            // 기존에 구매한 주식이 있다면 업데이트
            BalanceDTO originBalanceDTO = existingBalanceDTO.get();
            // 가지고 있는 QUANTITY와 AVERAGE_PRICE를 업데이트
            originBalanceDTO.setAveragePrice((originBalanceDTO.getAveragePrice() * originBalanceDTO.getQuantity() - trade.getPrice() * trade.getQuantity()) / (originBalanceDTO.getQuantity() - trade.getQuantity()));
            originBalanceDTO.setQuantity(originBalanceDTO.getQuantity() - trade.getQuantity());
            balanceDAO.updateBalance(originBalanceDTO);
            // 추후 GRADE_ID를 업데이트하는 로직 필요
        } else {
            // 새로 구매하는 주식이면 삽입
            balanceDAO.insertBalance(balance);
            // 추후 GRADE_ID를 업데이트하는 로직 필요
        }

        // AccountDTOs 테이블 업데이트
        AccountDTO existingAccountDTO = accountDAO.getAccountById(account.getAccountId());
        existingAccountDTO.setCash(existingAccountDTO.getCash() + trade.getPrice() * trade.getQuantity());
        accountDAO.updateCash(existingAccountDTO);
    }

    public List<AccountDTO> getAccountByMemberId(String memberId) {
        return accountDAO.getAccountByMemberId(memberId);
    }

    public void insertAccount(AccountDTO accountDTO) {
        accountDAO.insertAccount(accountDTO);
    }

}
