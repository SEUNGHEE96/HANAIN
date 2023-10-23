package com.hanain.account.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class BalanceDTO {

    private int accountId;
    private String isin;
    private int gradeId;
    private int quantity;
    private int averagePrice;

}
