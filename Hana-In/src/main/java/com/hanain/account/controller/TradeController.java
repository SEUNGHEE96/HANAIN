package com.hanain.account.controller;

import com.hanain.account.model.dto.AccountDTO;
import com.hanain.account.model.dto.TradeDTO;
import com.hanain.account.service.TradeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class TradeController {

    @Autowired
    private TradeService tradeService;

    /**
     * 거래소 -> 매수매도창의 우측 하단의 거래내역을 가져옴 (AJAX호출)
     * @param accountId
     * @return
     */
    @ResponseBody
    @GetMapping(value = "/getTradeInfo")
    public List<TradeDTO> getTradeInfo(@RequestParam("accountId") int accountId) {
        List<TradeDTO> tradelist = tradeService.getTradeByAccountId(accountId);
        return tradelist;
    }

}
