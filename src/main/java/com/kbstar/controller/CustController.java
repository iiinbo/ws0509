package com.kbstar.controller;

import com.kbstar.dto.Cust;
import com.kbstar.service.CustService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.ObjectError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.validation.Valid;
import java.util.List;


@Slf4j //log 출력가능하게 도와줌. 밑에 안써도 됨.
@Controller
@RequestMapping("/cust")
public class CustController {
    @Autowired
    BCryptPasswordEncoder encoder;
    @Autowired
    CustService service;

    //Logger logger = LoggerFactory.getLogger(this.getClass().getSimpleName());
    String dir = "cust/"; // 매번, cust 라는 폴더 경로를 붙이기 귀찮을 때.


    // 1-1. cust - "add" 클릭 시 나오는 center 페이지
    @RequestMapping("/add") // 127.0.0.1/cust/add
    public String add(Model model){
        model.addAttribute("center", dir + "add"); // center만 변경
        model.addAttribute("leftNav", "leftNav");
        return "index";
    }
    // 1-2. 관리자가 직접 cust 객체 등록 시 > 정보 전송은 addimpl가 담당
    @RequestMapping("/addimpl") // 127.0.0.1/cust/addimpl
    public String addimpl(Model model, @Validated Cust cust, Errors errors) throws Exception{

        if( errors.hasErrors() ){
            // 에러 모음 만들기
            List<ObjectError> es = errors.getAllErrors();
            String msg = "";
            // 에러가 발생하면, 해당하는 에러문구는 모두 출력. (한 화면에 에러 문구 여러개 가능)
            for( ObjectError e:es ){
                msg += "<h4>";
                msg += e.getDefaultMessage();
                msg += "<h4>";
            }
            throw new Exception(msg);
        }
        // 에러없이 정상 입력된 정보는 DB에 집어넣기(넣기 전, 암호화 선행)
        cust.setPwd( encoder.encode(cust.getPwd()) );
        service.register( cust );
        // 등록 완료 후 페이지 따로 안만들고, / 회원 전체조회 되는 all 페이지로 이동.
        return "redirect:/cust/all";
    }

    // 2. cust - "all" 클릭 시 나오는 center 페이지
    @RequestMapping("/all") // 127.0.0.1/cust/all

    public String all(Model model) throws Exception {
        
        List<Cust> list = null; // 조회 건 담을 바구니 준비
        try {
            list = service.get(); // 바구니 = 담기
        } catch (Exception e) {
            throw new Exception("시스템 장애 발생 : ER0001");
        }

        model.addAttribute("custlist", list); // db에 저장된 list 보여주기(jsp파일에서 custlist로 사용)
        model.addAttribute("center", dir + "all"); // center만 변경
        model.addAttribute("leftNav", "leftNav");
        return "index";
    }
    // 3. cust - "all" 에서 특정 id 1건 선택 시 상세조회로 나오는 center 페이지명 :detail
    @RequestMapping("/detail") // 127.0.0.1/cust/detail?id=
    public String detail(Model model, String id) throws Exception {
        // ?id= 에 대한 정보 가져오기
        Cust cust = null; // 가져올 준비하기.
        try {
            cust  = service.get( id );
        } catch (Exception e) {
            throw new Exception("시스템 장애 발생 : ER0002");
        }
        model.addAttribute("custdetail", cust); // jsp에서 화면에 뿌릴 때 사용할 이름 : custdetail
        model.addAttribute("center", dir + "detail"); // center만 변경
        model.addAttribute("leftNav", "leftNav");
        return "index";
    }
    // 4. 회원정보 상세 페이지에서 정보 수정하기 : detail > updateimpl
    @RequestMapping("/updateimpl") // 127.0.0.1/cust/upeateimpl?id=
    public String updateimpl(Model model, Cust cust) throws Exception {

        try {
            // 에러없이 수정될 정보는 DB에 집어넣기(넣기 전, pwd 암호화 선행)
            cust.setPwd( encoder.encode(cust.getPwd()) );
            service.modify(cust);
        } catch (Exception e) {
            throw new Exception("시스템 장애 발생 : ER0005");
        }

        return  "redirect:/cust/detail?id=" + cust.getId(); // 다시 해당 페이지로 회귀
    }
    // 5. 회원정보 상세 페이지에서 정보 삭제하기 : detail > deleteimpl
    @RequestMapping("/deleteimpl") // 127.0.0.1/cust/deleteimpl?id=
    public String deleteimpl(Model model, String id) throws Exception {

        try {
            service.remove( id );
        } catch (Exception e) {
            throw new Exception("시스템 장애 발생 : ER0006");
        }

        return  "redirect:/cust/all" ; // 다시 회원 전체조회 페이지로 회귀
    }

}
