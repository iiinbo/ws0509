package com.kbstar.controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.util.Random;

@RestController // ajax에서 요청이 들어오면 그 요청을 받고 전달하는 곳! @RestController
public class ChartsImplController {

    //DB에 있는 정보를 json으로 바꿔 보내주기
    @RequestMapping("/chart0301")
    public Object chart0301() {
        // java -> json으로
        // JSON 의미 : 자바스크립트 오브젝트 노테이션
        // JSONArray 모습 : [ [], [],[] ,  ] 이 모양

        JSONArray ja = new JSONArray(); // 1. 가장 바깥 배열
        for (int i = 1; i <= 5; i++) {
            Random r = new Random();
            int num = r.nextInt(20) + 1;
            JSONArray jadata = new JSONArray(); // 1. 안에 배열
            jadata.add("data : " + num);
            jadata.add(num); // 안에 배열에 랜덤숫자 넣고,

            ja.add(jadata); // 바깥배열 속에 집어넣기.
        }

        return ja; // 리턴값 은배열 : ajax가 아니라, 여기선 반대로 json을 배출
    }


    }

