package com.kbstar.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/charts")
public class ChartsController {
    Logger logger = LoggerFactory.getLogger(this.getClass().getSimpleName());
    String dir = "charts/"; // 매번, charts 라는 폴더 경로를 붙이기 귀찮을 때.

    // 좌측 - charts 클릭 시 나오는 기본 페이지
    @RequestMapping("") // 127.0.0.1:8080/charts
    public String main(Model model){

        model.addAttribute("center", dir + "center"); // center에는 charts 페이지 뿌려져라.
        model.addAttribute("leftNav", dir + "leftNav");
        return "index";
    }





}




