package com.hanain.stock.model.dto;

import lombok.Data;

import java.time.LocalDate;

@Data
public class ValuationDTO {

    private String isin;
    private LocalDate regDate;
    private double bps;
    private double per;
    private double pbr;
    private long eps;
    private long div;
    private long dps;

}
