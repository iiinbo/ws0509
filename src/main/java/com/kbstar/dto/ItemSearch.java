package com.kbstar.dto;

import lombok.*;

// Lombok 기능덕에 : @키워드를 사용해서, 아규먼트 등 자동 생성 !!! - 아래 주절주절 안적어도 된다.
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class ItemSearch {
    // item의 검색조건
    private String name; // item의 이름
    private Integer price; // item의 가격, Integer : null 가능
    private String startdate; // item 등록일자
    private String enddate;

}
