package com.hanain.account.controller;

import com.hanain.account.model.dto.AccountDTO;
import com.hanain.account.model.dto.BalanceDTO;
import com.hanain.account.model.dto.TradeDTO;
import com.hanain.account.service.AccountService;
import com.hanain.member.model.dto.MemberDTO;
import com.hanain.proposal.model.dto.ProposalDTO;
import com.hanain.stock.model.dto.StockDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class AccountController {

    @Autowired
    private final AccountService accountService;

    public AccountController(AccountService accountService) {
        this.accountService = accountService;
    }

    @RequestMapping("/account")
    public ModelAndView account() {
        ModelAndView mv = new ModelAndView("/account/account");
        List<AccountDTO> accountlist = accountService.getAllAccount();
        mv.addObject("accountlist", accountlist);
        return mv;
    }

    /**
     * 거래소 첫 화면 -> 로그인한 회원의 하나증권 목록
     * @return
     */
    @GetMapping("/stock")
    public ModelAndView stock(HttpServletRequest request, Model model) {
        ModelAndView mv = new ModelAndView("/stock/stock");
        HttpSession session = request.getSession();
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("currentUser");
        List<AccountDTO> accountlist = accountService.getHanaAccountById(memberDTO.getMemberId());
        mv.addObject("accountlist", accountlist);
        return mv;
    }

    /**
     * 거래소 -> 매수매도창의 계좌의 현금을 가져오기 위함 (AJAX호출)
     * @param accountNumber
     * @return
     */
    @ResponseBody
    @GetMapping(value = "/getAccountInfo")
    public AccountDTO getStockInfo(@RequestParam("accountNumber") String accountNumber) {
        AccountDTO account = accountService.getAccountByNumber(Long.parseLong(accountNumber));
        return account;
    }

    /**
     * 주식 매수 -> form의 action태그
     * @return
     */
    @PostMapping("/buyStock")
    public String buyStock(@ModelAttribute TradeDTO trade, HttpServletRequest request) {
        trade.setType("매수");

        AccountDTO account = new AccountDTO();
        account.setAccountId(trade.getAccountId());

        BalanceDTO balance = new BalanceDTO();
        balance.setAccountId(trade.getAccountId());
        balance.setIsin(trade.getIsin());
        balance.setQuantity(trade.getQuantity());
        balance.setAveragePrice(trade.getPrice());

        accountService.buyStock(trade, balance, account);

        // 매수 완료 메시지 설정
        HttpSession session = request.getSession();
        session.setAttribute("message", "매수가 완료되었습니다.");
        return "redirect:/stock";
    }

    /**
     * 주식 매도 -> form의 action태그
     * @return
     */
    @PostMapping("/sellStock")
    public String sellStock(@ModelAttribute TradeDTO trade, HttpServletRequest request) {
        trade.setType("매도");

        AccountDTO account = new AccountDTO();
        account.setAccountId(trade.getAccountId());

        BalanceDTO balance = new BalanceDTO();
        balance.setAccountId(trade.getAccountId());
        balance.setIsin(trade.getIsin());
        balance.setQuantity(trade.getQuantity());
        balance.setAveragePrice(trade.getPrice());

        accountService.sellStock(trade, balance, account);

        // 매수 완료 메시지 설정
        HttpSession session = request.getSession();
        session.setAttribute("message", "매도가 완료되었습니다.");
        return "redirect:/stock";
    }

}
