package com.kopo.mydata.model.dto;

import java.math.BigDecimal;
import java.util.List;

import lombok.Data;

@Data
public class AccountDTO {

    private Long accountNumber;
    private String ci;
    private String company;
    private Long cash;

    private List<BalanceDTO> balances;

}
