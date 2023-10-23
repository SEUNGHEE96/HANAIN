package com.hanain.chat.model.dao;

import com.hanain.chat.model.dto.ChatMessageDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper
public interface ChatMessageDAO {

    List<ChatMessageDTO> findAllMessageByRoomId(int roomId);
    void insertMessage(ChatMessageDTO chatMessageDTO);
    void insertFirstMessage(Map<String, Object> map);

}