package com.hanain.chat.service;

import com.hanain.chat.model.dao.ChatMessageDAO;
import com.hanain.chat.model.dto.ChatMessageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ChatMessageService {

    @Autowired
    private ChatMessageDAO chatMessageDAO;  // 변경된 부분

    public List<ChatMessageDTO> findAllMessageByRoomId(int roomId) {
        return chatMessageDAO.findAllMessageByRoomId(roomId);
    }

    public void insertMessage(ChatMessageDTO chatMessageDTO) {
        chatMessageDAO.insertMessage(chatMessageDTO);
    }

    public void insertFirstMessage(Map<String, Object> map) {
        chatMessageDAO.insertFirstMessage(map);
    }
}
