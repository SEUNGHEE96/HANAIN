package com.hanain.chat.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hanain.chat.model.dto.ChatMessageDTO;
import com.hanain.chat.model.dto.ChatRoomDTO;
import com.hanain.chat.service.ChatMessageService;
import com.hanain.chat.service.ChatRoomService;
import com.hanain.member.model.dto.MemberDTO;
import com.hanain.proposal.model.dto.UnionDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.handler.annotation.DestinationVariable;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class ChatController {

    @Autowired
    private ChatRoomService chatRoomService;

    @Autowired
    private ChatMessageService chatMessageService;

    @GetMapping("/chat")
    public String chat(HttpSession session, Model model) {
        MemberDTO currentUser = (MemberDTO) session.getAttribute("currentUser");

        List<ChatRoomDTO> privateChatRoomList = chatRoomService.findPrivateChatRoomByMemberId(currentUser.getMemberId());
        List<ChatRoomDTO> groupChatRoomList = chatRoomService.findGroupChatRoomByMemberId(currentUser.getMemberId());

        List<ChatRoomDTO> allChatRoomList = new ArrayList<>();
        allChatRoomList.addAll(privateChatRoomList);
        allChatRoomList.addAll(groupChatRoomList);

        // lastMessage의 regDate 기준으로 내림차순 정렬
        privateChatRoomList.sort(Comparator.comparing(
                (ChatRoomDTO chatRoomDTO) -> chatRoomDTO.getLastMessage().getRegDate()).reversed());
        groupChatRoomList.sort(Comparator.comparing(
                (ChatRoomDTO chatRoomDTO) -> chatRoomDTO.getLastMessage().getRegDate()).reversed());
        allChatRoomList.sort(Comparator.comparing(
                (ChatRoomDTO chatRoomDTO) -> chatRoomDTO.getLastMessage().getRegDate()).reversed());

        model.addAttribute("now", new Date());
        model.addAttribute("privateChatRoomList", privateChatRoomList);
        model.addAttribute("groupChatRoomList", groupChatRoomList);
        model.addAttribute("allChatRoomList", allChatRoomList);
        return "chat/chat";
    }

    @GetMapping("/chat/{roomId}")
    @ResponseBody
    public Map<String, Object> getAllChat(@PathVariable("roomId") int roomId) {
        List<ChatMessageDTO> messageList = chatMessageService.findAllMessageByRoomId(roomId);
        List<String> participantList = chatRoomService.findParticipantsByRoomId(roomId);

        Map<String, Object> response = new HashMap<>();
        response.put("messages", messageList);
        response.put("participants", participantList);

        return response;
    }

    /**
     * 커뮤니티에서 개인 채팅방 개설
     */
    @GetMapping("/chatWithMember")
    public String chatWithMember(@RequestParam String memberId, HttpSession session) {
        // 세션에서 현재 로그인한 사용자 정보를 가져옴
        MemberDTO currentUser = (MemberDTO) session.getAttribute("currentUser");

        // 주주제안 이름의 채팅방 생성
        ChatRoomDTO chatRoomDTO = new ChatRoomDTO();
        chatRoomDTO.setTitle(currentUser.getName());
        chatRoomDTO.setType(0); //개인채팅방
        chatRoomService.createChatRoom(chatRoomDTO);

        // 해당 채팅방에 두명 참여 + 첫 메세지 추가하고 시작
        int createdChatRoomId = chatRoomDTO.getRoomId();
        Map<String, Object> params1 = new HashMap<>();
        params1.put("roomId", createdChatRoomId);
        params1.put("memberId", memberId);
        chatRoomService.addParticipant(params1);

        Map<String, Object> params2 = new HashMap<>();
        params2.put("roomId", createdChatRoomId);
        params2.put("memberId", currentUser.getMemberId());
        chatRoomService.addParticipant(params2);

        ChatMessageDTO chatMessageDTO = new ChatMessageDTO();
        chatMessageDTO.setRoomId(createdChatRoomId);
        chatMessageDTO.setMemberId(currentUser.getMemberId());
        chatMessageDTO.setContent(currentUser.getMemberId() + "님이 " + memberId + "님과의 채팅을 시작하였습니다.");
        chatMessageService.insertMessage(chatMessageDTO);

        return "redirect:/chat";
    }

}