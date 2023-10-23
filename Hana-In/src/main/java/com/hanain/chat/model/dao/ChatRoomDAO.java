package com.hanain.chat.model.dao;

import com.hanain.chat.model.dto.ChatMessageDTO;
import com.hanain.chat.model.dto.ChatRoomDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface ChatRoomDAO {

    List<ChatRoomDTO> findPrivateChatRoomByMemberId(String memberId);

    List<ChatRoomDTO> findGroupChatRoomByMemberId(String memberId);

    void createChatRoom(ChatRoomDTO chatRoomDTO);

    void addParticipant(Map<String, Object> map);

    int findChatRoomById(int prposalId);

    void deleteParticipant(Map<String, Object> map);

    List<String> findParticipantsByRoomId(int roomId);

}