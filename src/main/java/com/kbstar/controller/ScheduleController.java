package com.kbstar.controller;

import com.kbstar.dto.Cart;
import com.kbstar.dto.Item;
import com.kbstar.dto.MsgAdmin;
import com.kbstar.service.CartService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;
import java.util.Random;


@Slf4j
@Component
public class ScheduleController {
    @Autowired
    private SimpMessageSendingOperations messagingTemplate;
    @Autowired
    CartService cartService;
    // 관리자 화면 맨 상단 - 대시보드에 수시로 업데이트할 내용 만들기
    @Scheduled(cron = "*/5 * * * * *") // 업데이트 속도 : 15초에 한번씩 진행하기.
    public void cronJobDailyUpdate() {

        Random r = new Random();
        int content1 = r.nextInt(100)+1; // 랜덤숫자를 15초마다 뿌려보기.
        int content2 = r.nextInt(100)+1;
        int content3 = r.nextInt(500)+1;
        int content4 = r.nextInt(100)+1;
        MsgAdmin msg = new MsgAdmin(); // 메세지 틀 만들기
        msg.setContent1(content1); // 메세지 세팅하기.
        msg.setContent2(content2);
        msg.setContent3(content3);
        msg.setContent4(content4);

        //sendadm 라는 통로로 보내면 msg 보내진다.
        // 나가는 통로는 StomWebSocketConfig 에서 지정해주기.
        messagingTemplate.convertAndSend("/sendadm", msg);
    }

    @Scheduled(cron = "*/3 * * * * *")
    public void cronJobWeeklyUpdate() throws Exception {
        // 방법 2 : 장바구니에 담긴 총 금액을 차트로 그리기
        List<Cart> list =  cartService.getcartmounttotal();
        int mnt = 0;
        for(Cart obj:list){
        mnt += obj.getTotal();
    }
        // ** cart에 담긴 item 금액을 누적해서 찍기
        // log.info(mnt+""); //콘솔창에 : 3초마다, getItem_id 의 cnt(개수)를 log로 찍어줘
    }

        // 방법 1 : 카트 안에 아이템 행의 개수를 로그에 찍기
        //    List<Cart> list = cartService.get();
        //    // ** cart에 담긴 item 개수 전체조회
        //    int cnt = 0;
        //        for(Cart obj:list){
        //        obj.getItem_id();
        //        cnt++;
        //    } log.info(cnt+""); // 3초마다, getItem_id 의 cnt(개수)를 log로 찍어줘

}