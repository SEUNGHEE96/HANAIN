package com.hanain.stock.model.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class StockChartDTO {

    private String isin;
    private String stockName;
    private LocalDate regDate;
    private int sales;
    private int operatingProfit;
    private int netIncome;
    private int assets;
    private int liabilities;
    private int equity;
    private int retainedEarnings;
    private int dividendPayment;
    private double per;
    private int close;
    private long issuedShares;

}
