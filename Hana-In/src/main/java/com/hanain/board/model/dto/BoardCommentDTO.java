package com.hanain.board.model.dto;

import lombok.Data;

@Data
public class BoardCommentDTO {

    int boardCommentId;
    String memberId;
    int boardId;
    int parent;
    int indent;
    String content;
    String regDate;

}
