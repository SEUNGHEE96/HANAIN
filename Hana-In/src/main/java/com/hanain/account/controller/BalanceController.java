package com.hanain.account.controller;

import com.hanain.account.model.dto.BalanceDTO;
import com.hanain.account.service.BalanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class BalanceController {

    @Autowired
    private BalanceService balanceService;
    /* Balances 테이블 관련 */
    @GetMapping("/balance")
    public ModelAndView balance() {
        ModelAndView mv = new ModelAndView("/balance/balance");
        List<BalanceDTO> balancelist = balanceService.getAllBalance();
        mv.addObject("balancelist", balancelist);
        return mv;
    }

    @ResponseBody
    @GetMapping(value = "/getBalanceInfo")
    public BalanceDTO getBalanceByAccountNumber(@RequestParam("accountNumber") String accountNumberString, @RequestParam("isin") String isin) {
        long accountNumber = Long.parseLong(accountNumberString);  // Convert String to long

        Map<String, Object> params = new HashMap<>();
        params.put("accountNumber", accountNumber);
        params.put("isin", isin);

        BalanceDTO balance = balanceService.getSellableQuantity(params);  // Assuming you have a balanceService

        return balance;
    }

    @GetMapping("/mybalance/{accountNumber}")
    public ModelAndView proposalDetail(@PathVariable("accountNumber") int accountNumber) {
        ModelAndView mv = new ModelAndView("/account/accountdetail");
        List<BalanceDTO> balancelist = balanceService.getBalanceByAccountNumber(accountNumber);
        mv.addObject("balancelist", balancelist);
        return mv;
    }

}
