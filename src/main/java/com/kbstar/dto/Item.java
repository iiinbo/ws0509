package com.kbstar.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

// Lombok 기능덕에 : @키워드를 사용해서, 아규먼트 등 자동 생성 !!! - 아래 주절주절 안적어도 된다.
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class Item {
    // 속성값만 입력해도 가능.

    private int id; //상품관리번호 자동으로 채번되게 하려면 int(오라클 : 시퀀스) & xml 작성 유의
    private String name;
    private int price;
    private String imgname; // 파일의 '이름' (나중에 서버가 찾아올 이름)
    private Date rdate; // 상품 등록일자
    private MultipartFile img; // 스프링워크에서 파일 첨부를 도와줌. (서버로 전송될 때 사용되어지는 이름)

    // 5개 기본속성만 가진 컨스트럭터 만들었다. (이미지 첨부를 안하는 경우도 있을테니까.)
    public Item(int id, String name, int price, String imgname, Date rdate) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.imgname = imgname;
        this.rdate = rdate;
    }
}
