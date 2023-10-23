package com.hanain.account.service;

import com.hanain.account.model.dao.AccountDAO;
import com.hanain.account.model.dao.BalanceDAO;
import com.hanain.account.model.dao.TradeDAO;
import com.hanain.account.model.dto.TradeDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

import static com.fasterxml.jackson.databind.type.LogicalType.Map;

@Service
public class TradeService {

    @Autowired
    private TradeDAO tradeDAO;

    public List<TradeDTO> getTradeByAccountId(int accountId) {
        return tradeDAO.getTradeByAccountId(accountId);
    }

    public List<TradeDTO> getTradeByMemberId(Map<String, Object> params){
        return tradeDAO.getTradeByMemberId(params);
    };

    public int getTradeCountThisMonthByMemberId(String memberId){
        return tradeDAO.getTradeCountThisMonthByMemberId(memberId);
    };

    public int getTradeCountByMemberId(String memberId){
        return tradeDAO.getTradeCountByMemberId(memberId);
    };
}
