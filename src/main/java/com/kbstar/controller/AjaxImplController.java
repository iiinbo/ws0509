package com.kbstar.controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.kbstar.dto.Adm;

import com.kbstar.dto.Chart;
import com.kbstar.dto.Sales;
import com.kbstar.service.AdmService;
import com.kbstar.service.ChartService;
import com.kbstar.service.SalesService;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Random;


@RestController // ajax에서 요청이 들어오면 그 요청을 받고 전달하는 곳! @RestController
public class AjaxImplController {

    @Autowired
    AdmService admservice; // 회원가입 시 id중복확인 위해
    @Autowired
    SalesService salesService;
    @Autowired
    ChartService chartService;


    //id 중복체크
    @RequestMapping("/checkid")
    public Object checkid(String id) throws Exception { // ajax에서 보내주는 값 : id.

        Adm adm = null;
        adm = admservice.get(id);
        int result = 0; // id 존재 '1', 미존재 '0'

        if (adm != null) { // adm 회원정보 id가 있다면,
            result = 1; // 기존재
        }
        return result;
    }

    //대시보드 : 중간 좌측 : 월별 매출액 추이
    @RequestMapping("/dashchat01")
    public Object dashchat01() throws Exception {
        List<Chart> list = chartService.MonthTotal();
        JSONArray femaleArray = new JSONArray(); // 1. 성별이 여자인 배열
        JSONArray maleArray = new JSONArray(); // 1. 성별이 남자인 배열
        for (Chart c : list) {
            // 2. 성별이 여자라면? femaleArray 배열 안에 add 하기.
            if (c.getGender().toUpperCase().equals("F")) {
                femaleArray.add(c.getTotal()); // 3. 무엇을? 매출금액을.
            }
            // 2. 성별이 여자가 아니라면? maleArray 배열 안에 add 하기.
            else {
                maleArray.add(c.getTotal()); // 3. 무엇을? 매출금액을.
            }
        }
        // 여기까지 나오는 데이터 모습
        // femaleArray - [ f의 매출금액이 숫자로 찍힌다. 10000, 20000, ...  ]
        // maleArray -  [ m의 매출금액이 숫자로 찍힌다. 10000, 20000, ...  ]

        // 4. for문 끝나는 시점에, JSONObject 만들기
        JSONObject femaleObj = new JSONObject();
        JSONObject maleObj = new JSONObject();
        femaleObj.put("name", "Female"); // 자바스크립트 가져온 것과 동일한 모양으로 put!
        femaleObj.put("data", femaleArray); // data : [ 10000, 20000, ..]

        maleObj.put("name", "male");
        maleObj.put("data", maleArray); // data : [ 10000, 20000, ..]

        // 5. 마지막 이들을 하나로 묶는 배열 만들기.
        JSONArray data = new JSONArray();
        data.add(femaleObj); // 1. 다 만들어진 여자배열 넣기
        data.add(maleObj); // 1. 다 만들어진 남자배열 넣기
        return data;
    }

}
