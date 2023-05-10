package com.kbstar.dto;

import lombok.*;
import org.springframework.web.multipart.MultipartFile;

// Lombok 기능덕에 : @키워드를 사용해서, 아규먼트 등 자동 생성 !!! - 아래 주절주절 안적어도 된다.
@AllArgsConstructor
@NoArgsConstructor
@Setter
@Getter
@ToString
public class Marker {
    // 속성값만 입력해도 가능.
    private int id;
    private String title;
    private String target;
    private double lat;
    private double lng;
    private String img;   // 파일의 '이름' (나중에 서버가 찾아올 이름)
    private String loc;

    private MultipartFile send_img; // 서버로 전송될 때 사용되어지는 이름

    public Marker(int id, String title, String target, double lat, double lng, String img, String loc) {
        this.id = id;
        this.title = title;
        this.target = target;
        this.lat = lat;
        this.lng = lng;
        this.img = img;
        this.loc = loc;
    }
}
