package com.kbstar.controller;


import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/livechart")
public class LiveChartController {
    @Value("${adminserver}")
    String adminServer; // 관리자용 서버의 ip주소 일일이 수정하기 귀찮으니까.
    String dir = "livechart/"; // 매번, livechart 라는 폴더 경로를 붙이기 귀찮을 때.

    // 상단 - livechart 클릭 시 나오는 기본 페이지
    @RequestMapping("")
    public String livechart(Model model){
        model.addAttribute("adminServer", adminServer); // jsp 파일에서 주소 일일이 치기 귀찮으니.
        model.addAttribute("center", dir + "center"); // livechart 라는 폴더 내 center로 변환된다.
        return "index";
    }

}




