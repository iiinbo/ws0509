package com.kbstar.marker;

import com.kbstar.service.MarkerService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * 4.27 정인보 selectLoc 테스트 완료
 * 테스트 id : 100 / 국밥집
 */
@Slf4j // 로그 찍을거야
@SpringBootTest
class SelectLocTest {
    @Autowired
    MarkerService service;
    @Test
    void contextLoads() {

        try {
            service.getmybob( "s" ); // loc : string // 소문자 입력해도 대문자로 자동변환(xml에 설정해둠)
            log.info("-------입력하신 loc 대한 Marker(맛집추천) 정보 조회 성공! -------");
        } catch (Exception e) { // 오류 예외처리(자동)
            //throw new RuntimeException(e);
            log.info("-------  Marker(맛집추천) 조회 에러 발생 -------");
            // e.printStackTrace(); // 에러 자세히
        }
    }


}
