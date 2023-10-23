package com.kopo.mydata.model.dto;

import lombok.Data;

@Data
public class BalanceDTO {

    private String isin;
    private Long accountNumber;
    private int quantity;
    private int averagePrice;

}
