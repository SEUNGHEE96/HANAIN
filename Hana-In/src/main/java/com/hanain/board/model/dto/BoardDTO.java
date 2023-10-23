package com.hanain.board.model.dto;

import com.hanain.account.model.dto.BalanceDTO;
import com.hanain.stock.model.dto.StockDTO;
import lombok.Data;

@Data
public class BoardDTO {

    private int boardId;
    private String memberId;
    private String isin;
    private String title;
    private String content;
    private String regDate;
    private int viewCount;
    private int likeCount;
    private int status;

    // isin 기준으로 STOCK 객체를 가짐
    StockDTO stockDTO;

    // isin + memberId 기준으로 balance 객체를 가짐
    BalanceDTO balanceDTO;

}
