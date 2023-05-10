package com.kbstar.dto;

import lombok.*;
//import org.springframework.format.annotation.DateTimeFormat;


@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString

// 메세지 주고받는 매개체 역할을 할 것이다.
public class Msg {

    private String sendid; // 보내는 사람
    private String receiveid; // 받는사람
    private String content1; // 데이터
}

