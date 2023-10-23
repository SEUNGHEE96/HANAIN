package com.hanain.stock.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class OhlcvDTO {

    private String isin;
    private String regDate;
    private int open;
    private int high;
    private int low;
    private int close;
    private long volume;
    private long amount;
    private double updown;

}
