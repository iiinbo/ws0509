package com.kbstar.dto;

import lombok.*;
//import org.springframework.format.annotation.DateTimeFormat;


@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString

public class Sales {

    private String rdate; // 매출 발생일자(2023-00-00) : String로 잡은 이유는, 달력선택해서 입력 시 모두 문자로 인식함
    private int price; // 매출
    private String gender; // 성별

    public Sales(String rdate, int price, String gender) {
        this.rdate = rdate;
        this.price = price;
        this.gender = gender;
    }

    // search용
    private String month; // 월별 (2023-00) : String로 잡은 이유는, 달력선택해서 입력 시 모두 문자로 인식함
    private int total_price; // 매출액

}

