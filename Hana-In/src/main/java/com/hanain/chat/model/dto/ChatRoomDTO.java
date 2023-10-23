package com.hanain.chat.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class ChatRoomDTO {

    private int roomId;
    private String title;
    private int type;

    // ChatMessageDTO를 포함
    private ChatMessageDTO lastMessage;

}
