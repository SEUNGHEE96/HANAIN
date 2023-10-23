package com.hanain.chat.service;

import com.hanain.chat.model.dao.ChatRoomDAO;
import com.hanain.chat.model.dto.ChatMessageDTO;
import com.hanain.chat.model.dto.ChatRoomDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ChatRoomService {

    @Autowired
    private ChatRoomDAO chatRoomDAO;

    public List<ChatRoomDTO> findPrivateChatRoomByMemberId(String memberId) {
        return chatRoomDAO.findPrivateChatRoomByMemberId(memberId);
    }

    public List<ChatRoomDTO> findGroupChatRoomByMemberId(String memberId) {
        return chatRoomDAO.findGroupChatRoomByMemberId(memberId);
    }

    public void createChatRoom(ChatRoomDTO chatRoomDTO) {
        chatRoomDAO.createChatRoom(chatRoomDTO);
    }

    public void addParticipant(Map<String, Object> map) {
        chatRoomDAO.addParticipant(map);
    }

    public int findChatRoomById(int proposalId) {
        return chatRoomDAO.findChatRoomById(proposalId);
    }

    public void deleteParticipant(Map<String, Object> map) {
        chatRoomDAO.deleteParticipant(map);
    }

    public List<String> findParticipantsByRoomId(int roomId) {
        return chatRoomDAO.findParticipantsByRoomId(roomId);
    }
    
}
