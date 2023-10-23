package com.hanain.stock.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class StockDTO {

    String isin;
    String stockName;
    String sector;
    String refDate;
    long issuedShares;

}
