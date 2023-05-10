package com.kbstar.dto;

import lombok.*;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

// Lombok 기능덕에 : @키워드를 사용해서, 아규먼트 등 자동 생성 !!! - 아래 주절주절 안적어도 된다.
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class Cust { // 속성값만 입력해도 가능.
    @Size(min = 4, max = 10, message = "id 입력 시 최소 4자리에서 최대 10자리 까지 입력 가능") // 내가 정한 사이즈 이외엔, 에러발생하도록.
    @NotEmpty(message = "id는 필수 항목 입니다.") // null값 불가하다.
    private String id; // 회원이 만드는 id라서 string

    @Size(min = 5, max = 10, message = "pwd 입력 시 최소 5자리에서 최대 10자리 까지 입력 가능") // 내가 정한 사이즈 이외엔, 에러발생하도록.
    @NotEmpty(message = "pwd는 필수 항목 입니다.")
    private String pwd;

    @NotEmpty(message = "name은 필수 항목 입니다.")
    private String name;

}
