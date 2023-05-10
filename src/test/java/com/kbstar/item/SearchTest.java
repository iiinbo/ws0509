package com.kbstar.item;

import com.kbstar.dto.ItemSearch;
import com.kbstar.dto.MarkerSearch;
import com.kbstar.service.ItemService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

/**
 * 5.8 정인보 search 테스트 완료
 * 조건 4개 충족 : 성공
 * 조건 3개 충족, price = null : 성공!
 *
 */
@Slf4j // 로그 찍을거야
@SpringBootTest
class SearchTest {
    @Autowired
    ItemService service;
    @Test
    void contextLoads() {
        try {
            // 새로만든 DTO : ItemSearch (속성 2개 = 조건 2개)
            ItemSearch ic = new ItemSearch("바지",null, "2023-05-01", "2023-05-08");
            service.search(ic);
            log.info("------- item 검색 전체 조회 성공! -------");
        } catch (Exception e) { // 오류 예외처리(자동)
            //throw new RuntimeException(e);
                log.info("-------  item 검색  전체조회 에러 발생 -------");
            // e.printStackTrace(); // 에러 자세히
        }
    }
}
