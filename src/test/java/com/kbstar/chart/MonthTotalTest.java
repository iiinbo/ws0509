package com.kbstar.chart;

import com.kbstar.dto.Chart;
import com.kbstar.service.ChartService;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
@Slf4j
class MonthTotalTest {
    @Autowired
    ChartService chartService;
    @Test
    void contextLoads() {
        // 0. 형태 : [ 5.하나로 묶는 배열 {[ 1.여자배열 ]}, {[ 1.남자배열 ]} ]
        // femaleArray - [ f의 매출금액이 숫자로 찍힌다. 10000, 20000, ...  ]
        // maleArray -  [ m의 매출금액이 숫자로 찍힌다. 10000, 20000, ...  ]
        try {
           List<Chart> list = chartService.MonthTotal();
            JSONArray femaleArray = new JSONArray(); // 1. 성별이 여자인 배열
            JSONArray maleArray = new JSONArray(); // 1. 성별이 남자인 배열
           for(Chart c : list){
               // 2. 성별이 여자라면? femaleArray 배열 안에 add 하기.
               if( c.getGender().toUpperCase().equals("F") ){
                   femaleArray.add( c.getTotal() ); // 3. 무엇을? 매출금액을.
               }
               // 2. 성별이 여자가 아니라면? maleArray 배열 안에 add 하기.
               else {
                   maleArray.add( c.getTotal()  ); // 3. 무엇을? 매출금액을.
               }
           }
           // 여기까지 나오는 데이터 모습
            // femaleArray - [ f의 매출금액이 숫자로 찍힌다. 10000, 20000, ...  ]
            // maleArray -  [ m의 매출금액이 숫자로 찍힌다. 10000, 20000, ...  ]

           // 4. for문 끝나는 시점에, JSONObject 만들기
            JSONObject femaleObj = new JSONObject();
            JSONObject maleObj = new JSONObject();
            femaleObj.put("name" , "Female"); // 자바스크립트 가져온 것과 동일한 모양으로 put!
            femaleObj.put("data" , femaleArray); // data : [ 10000, 20000, ..]

            maleObj.put("name" , "male");
            maleObj.put("data" , maleArray); // data : [ 10000, 20000, ..]

            // 5. 마지막 이들을 하나로 묶는 배열 만들기.
            JSONArray data = new JSONArray();
            data.add(femaleObj); // 1. 다 만들어진 여자배열 넣기
            data.add(maleObj); // 1. 다 만들어진 남자배열 넣기
            log.info(data.toJSONString()); // 만들어진 모양 보기


            //log.info(String.valueOf("여자매출금액" + femaleArray));
            //log.info(String.valueOf("남자매출금액" + maleArray));

        } catch (Exception e) {
            log.info("시스템 장애입니다.==============================");
               // e.printStackTrace();
            }
    }

}
