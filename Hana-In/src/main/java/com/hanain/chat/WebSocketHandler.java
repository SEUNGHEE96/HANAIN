package com.hanain.chat;

import java.util.HashMap;

import com.hanain.chat.model.dto.ChatMessageDTO;
import com.hanain.chat.service.ChatMessageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

@Component
public class WebSocketHandler extends TextWebSocketHandler {

    @Autowired
    private ChatMessageService chatMessageService;

    static HashMap<String, WebSocketSession> sessionMap = new HashMap<>(); //웹소켓 세션을 담아둘 맵

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) {
        //메시지 발송
        String msg = message.getPayload();

        // 파싱 로직
        String[] parts = msg.split(" : ");
        String memberId = parts[0];
        String content = parts[1];
        String roomId = parts[2];

        ChatMessageDTO newMessage = new ChatMessageDTO();
        newMessage.setMemberId(memberId);
        newMessage.setContent(content);
        newMessage.setRoomId(Integer.parseInt(roomId));

        chatMessageService.insertMessage(newMessage);

        for(String key : sessionMap.keySet()) {
            WebSocketSession wss = sessionMap.get(key);
            try {
                wss.sendMessage(new TextMessage(msg));
            }catch(Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        //소켓 연결
        super.afterConnectionEstablished(session);
        sessionMap.put(session.getId(), session);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        //소켓 종료
        super.afterConnectionClosed(session, status);
        sessionMap.remove(session.getId());
    }

}