package com.hanain.chat.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Data
public class ChatMessageDTO {

    private int roomId;
    private String memberId;
    private String content;
    private String regDate;
    private int unreadCount;

}
