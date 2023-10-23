package com.hanain.stock.model.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class FundamentalDTO {

    private String isin;
    private String item;
    private String regDate;
    private BigDecimal value;
    private String status;

}
