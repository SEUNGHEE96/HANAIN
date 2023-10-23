package com.hanain.account.model.dto;

import lombok.Data;

@Data
public class TradeDTO {

    private int tradeId;
    private int accountId;
    private String isin;
    private String type;
    private String tradeDate;
    private int quantity;
    private int price;

}
