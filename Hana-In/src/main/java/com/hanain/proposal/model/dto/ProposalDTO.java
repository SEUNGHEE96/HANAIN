package com.hanain.proposal.model.dto;

import com.hanain.stock.model.dto.StockDTO;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;
import java.util.List;

@Data
public class ProposalDTO {

    int proposalId;
    String memberId;
    String isin;
    String title;
    String content;
    String startDate;
    String endDate;
    Date regDate;
    double rate1;
    double rate2;
    int viewCount;
    int likeCount;
    int status;
    int comments;
    
    // isin 기준으로 STOCK 객체를 가짐
    StockDTO stockDTO;
}
