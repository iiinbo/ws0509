package com.kbstar.dto;

import lombok.*;

@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString

public class Chart {
   int month; // 월별
    String gender; // 성별 : M / F
    int total; // 누적 매출금액
}
