package com.hanain.account.model.dao;

import com.hanain.account.model.dto.TradeDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface TradeDAO {

    void insertTrade(TradeDTO trade);

    List<TradeDTO> getTradeByAccountId(int accountId);

    List<TradeDTO> getTradeByMemberId(Map<String, Object> params);

    int getTradeCountThisMonthByMemberId(String memberId);

    int getTradeCountByMemberId(String memberId);

}
