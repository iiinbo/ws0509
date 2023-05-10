package com.kbstar.dto;

import lombok.*;

// Lombok 기능덕에 : @키워드를 사용해서, 아규먼트 등 자동 생성 !!! - 아래 주절주절 안적어도 된다.
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class MarkerSearch {
    // 검색조건
    private String title;
    private String loc;


}
