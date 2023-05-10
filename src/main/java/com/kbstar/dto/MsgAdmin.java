package com.kbstar.dto;

import lombok.*;
//import org.springframework.format.annotation.DateTimeFormat;


@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString

// (스케쥴러와 관련된 DTO) 관리자에게 정보를 보내는 역할 담당.
public class MsgAdmin {

    private int content1; // 대시보드에 올라올 내용 1
    private int content2; // 내용 2
    private int content3; // 내용 3
    private int content4; // 내용 4
}

