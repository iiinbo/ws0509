package com.kbstar.cust;

import com.kbstar.service.CustService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.dao.DuplicateKeyException;

@Slf4j // 로그 찍을거야
@SpringBootTest
class SelectTest {
    @Autowired
    CustService service;
    @Test
    void contextLoads() {
    // cust 객체 만들어서 아규먼트 넣어본다. 테스트 ok

        try {
            service.get();
        } catch (Exception e) { // 오류 예외처리(자동)
            //throw new RuntimeException(e);
            if(e instanceof DuplicateKeyException){
                log.info("에러");
            }else{
                log.info("정해지지 않은 시스템 장애입니다.");
            }
           // e.printStackTrace(); // 에러 자세히
        }
    }

}
