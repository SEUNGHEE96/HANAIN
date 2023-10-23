package com.hanain.account.model.dto;

import lombok.Data;

@Data
public class AccountDTO {

    private int accountId;
    private String memberId;
    private String company;
    private long accountNumber;
    private long cash;

}
