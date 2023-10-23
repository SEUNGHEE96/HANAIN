package com.hanain.chat;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.config.annotation.*;

import java.net.URI;

@Configuration
@EnableWebSocket
@Component
public class WebSocketConfig implements WebSocketConfigurer {

    @Autowired
    WebSocketHandler webSocketHandler;

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
        registry.addHandler(webSocketHandler, "/chat/**")
                .setAllowedOrigins("*"); // 모든 도메인에서의 연결 허용
    }

}