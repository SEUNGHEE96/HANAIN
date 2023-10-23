package com.kopo.mydata.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.kopo.mydata.model.dto.AccountDTO;
import com.kopo.mydata.model.dto.BalanceDTO;
import com.kopo.mydata.model.dto.CIDTO;
import com.kopo.mydata.service.MydataService;

@RestController
public class MydataController {

    private final MydataService mydataService;

    @Autowired
    public MydataController(MydataService mydataService) {
        this.mydataService = mydataService;
    }

    /**
     * 본인인증 후 : 주민번호 -> CI값 얻어오기
     */
    @ResponseBody
    @PostMapping("/getCIByAPI/{identification}")
    public ResponseEntity<Map<String, Object>> getCI(@PathVariable("identification") String identification) {
        Map<String, Object> responseBody = new HashMap<>();
        CIDTO cidto = mydataService.getCI(identification);

        if (cidto != null) {
            responseBody.put("state", "OK");
            responseBody.put("message", "조회 성공");
            responseBody.put("data", cidto);
            return ResponseEntity.ok(responseBody);
        } else {
            return ResponseEntity.notFound()
                    .header("state", "error")
                    .header("message", "Account not found.")
                    .build();
        }
    }

    /**
     * 약관 동의 후 : CI -> 계좌 정보 얻어오기
     */
    @ResponseBody
    @PostMapping("/getAccountByAPI/{ci}")
    public ResponseEntity<Map<String, Object>> getAccounts(@PathVariable("ci") String ci) {
        Map<String, Object> responseBody = new HashMap<>();
        List<AccountDTO> accountList = mydataService.getAccounts(ci);

        for (AccountDTO account : accountList) {
            List<BalanceDTO> balanceList = mydataService.getBalances(account.getAccountNumber());
            account.setBalances(balanceList); // 각 계좌의 Balance 리스트를 설정
        }

        if (accountList != null) {
            responseBody.put("state", "OK");
            responseBody.put("message", "조회 성공");
            responseBody.put("data", accountList);
            return ResponseEntity.ok(responseBody);
        } else {
            return ResponseEntity.notFound()
                    .header("state", "error")
                    .header("message", "Account not found.")
                    .build();
        }
    }

}
