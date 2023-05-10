package com.kbstar;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@EnableWebSocketMessageBroker
@Configuration
public class StomWebSocketConfig implements WebSocketMessageBrokerConfigurer{
    
    @Value("${serviceserver}")
    String serviceServer; // 고객용 서버의 ip주소 일일이 수정하기 귀찮으니까.
    
    @Override // 외부에서 들어올 수 있게 3개 소켓서버 만들기
    // http://127.0.0.1로 접속했던 서버도 우리 어드민(127.0.0.1:8088) 들어올 수 있게 하기.
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // 관리자-사용자용
        registry.addEndpoint("/ws").setAllowedOrigins("http://127.0.0.1", serviceServer).withSockJS();
        // 챗봇용
        registry.addEndpoint("/chbot").setAllowedOrigins("http://127.0.0.1").withSockJS();
        // 관리자-관리자용
        registry.addEndpoint("/wss").setAllowedOrigins("http://127.0.0.1").withSockJS();
    }

    /* 어플리케이션 내부에서 사용할 path를 지정할 수 있음 */

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.enableSimpleBroker("/send","/sendadm");
    } // send, sendadm : 밖으로 내보낼 때 문. 나가는 통로.
}