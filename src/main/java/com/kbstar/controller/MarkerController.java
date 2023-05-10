package com.kbstar.controller;

import com.kbstar.dto.Item;
import com.kbstar.dto.Marker;
import com.kbstar.dto.MarkerSearch;
import com.kbstar.dto.Markerdesc;
import com.kbstar.service.ItemService;
import com.kbstar.service.MarkerDescService;
import com.kbstar.service.MarkerService;
import com.kbstar.util.FileUploadUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;


@Slf4j //log 출력가능하게 도와줌. 밑에 안써도 됨.
@Controller
@RequestMapping("/marker")
public class MarkerController {

    @Autowired
    MarkerService service;

    @Autowired
    MarkerDescService markerDescService;
    @Value("${uploadimgdir}") // 이렇게 세팅하면, 애플리케이션 프로퍼티에 2.으로 정해둔, uimg/ 폴더에 집어넣는다.
    String imgdir;
    String dir = "marker/"; // 매번, marker 라는 폴더 경로를 붙이기 귀찮을 때.


    // 1-1. 맛집 - "add" 클릭 시 나오는 center 페이지
    @RequestMapping("/add") // 127.0.0.1/marker/add
    public String add(Model model){
        model.addAttribute("center", dir + "add"); // center만 변경
        model.addAttribute("leftNav", "leftNav");
        return "index";
    }
    // 1-2. 맛집 추가등록 시 addimpl이 동작된다.
    @RequestMapping("/addimpl") // 127.0.0.1/marker/addimpl
    public String addimpl(Model model, Marker marker) throws Exception {
        MultipartFile mf = marker.getSend_img();
        String img = mf.getOriginalFilename(); // 0.파일 덩어리에서, 이름을 끄집어내기

        marker.setImg( img ); // 0.암호화처럼, 이미지 이름을 다시 set 해준다.
        service.register( marker ); // 1. 상품이 db에 정상입력 되면,
        FileUploadUtil.saveFile( mf, imgdir);  // 2. 그다음 파일 덩어리 > 우리 디렉토리에 저장해주기.

        // 3. 등록완료 후 다시 전체조회 페이지로 이동.
        return "redirect:/marker/all";
    }

    // 2. marker - "all" 클릭 시 등록된 맛집정보 모두 조회되는 center 페이지
    @RequestMapping("/all") // 127.0.0.1/marker/all

    public String all(Model model) throws Exception {
        // 상세설명 : List<Marker> list = null ; 담기위해 바구니를 준비한다는 의미
        List<Marker> list = null;
        try {
            list = service.get();
        } catch (Exception e) {
            throw new Exception("시스템 장애 발생 : ER00012");
        }

        model.addAttribute("markerlist", list); // db에 저장된 list 보여주기(jsp파일에서 itemlist 로 사용)
        model.addAttribute("center", dir + "all"); // center만 변경
        model.addAttribute("leftNav", "leftNav");
        return "index";
    }
    // 3. marker- "all" 에서 특정 id 1건 선택 시 상세조회로 나오는 center 페이지명 :detail
    @RequestMapping("/detail") // 127.0.0.1/marker/detail?id=
    public String detail(Model model, Integer id) throws Exception {
        // ?id= 에 대한 정보 가져오기
        Marker marker = null; // 가져올 준비하기.

        try {
            marker  = service.get( id );
        } catch (Exception e) {
            throw new Exception("시스템 장애 발생 : ER00014");
        }
        model.addAttribute("markerdetail", marker); //jsp파일에서 뿌릴 이름 정하기
        model.addAttribute("center", dir + "detail"); // center만 변경
        model.addAttribute("leftNav", "leftNav");
        return "index";
    }
    // 3-2. marker- "all" : detail에서 search기능 이용한 뒤 center 페이지
    @RequestMapping("/search") // 127.0.0.1/marker/search
    public String search(Model model, MarkerSearch sc) throws Exception {
        List<Marker> list = service.search(sc);

        model.addAttribute("sc", sc); // ms를 다시 보내서 이용
        model.addAttribute("markerlist", list); //jsp파일에서 뿌릴 이름 정하기
        model.addAttribute("center", dir + "all"); // center만 변경
        model.addAttribute("leftNav", "leftNav");
        return "index";
    }

    // 4. 상품정보 상세 페이지에서 정보 수정하기 : detail > updateimpl
    @RequestMapping("/updateimpl") // 127.0.0.1/marker/upeateimpl?id=
    public String updateimpl(Model model, Marker marker) throws Exception {
        // 설명: cust와 차이점! text 수정 + file 수정
        // file 수정되면 : 파일 덩어리(img)에서 파일이름(send_img) 가져오고 -> 파일(img)은 디렉토리 저장
        MultipartFile mf = marker.getSend_img();
        String new_img = mf.getOriginalFilename(); // 0.새_이미지 파일 덩어리에서, 이름을 끄집어내기
        // if : text만 수정 시 / else : file도 수정 시
        try {
            if( new_img.equals("") || new_img == null ){
                service.modify( marker ); // 1. 수정내용 db에 정상입력(수정)
            }else {
                marker.setImg( new_img ); // 0.암호화처럼, 이미지 파일 수정 시, 이름을 다시 set 해준다.
                service.modify( marker ); // 1. 수정내용 db에 정상입력(수정)
                FileUploadUtil.saveFile( mf, imgdir );  // 2. 그다음 파일 덩어리 > 우리 디렉토리에 저장
            }

        } catch (Exception e) {
            throw new Exception("시스템 장애 발생 : ER00018");
        }

        return  "redirect:/marker/detail?id=" + marker.getId(); // 다시 해당 페이지로 회귀
    }
    // 5. 회원정보 상세 페이지에서 정보 삭제하기 : detail > deleteimpl
    @RequestMapping("/deleteimpl") // 127.0.0.1/marker/deleteimpl?id=
    public String deleteimpl(Model model, Integer id) throws Exception {

        try {
            service.remove( id );
        } catch (Exception e) {
            throw new Exception("시스템 장애 발생 : ER0020");
        }

        return  "redirect:/marker/all" ; // 다시 상품 전체조회 페이지로 회귀
    }

    // 6-1. 가게의 메뉴 상세정보 조회하기 
    @RequestMapping("/markerdesc") // 127.0.0.1/marker/markerdesc?marker_id=
    public String markerdesc(Model model, Integer mid) throws Exception {
        // ?id= 에 대한 정보 가져오기
        List <Markerdesc> markerdesc = null; // 메뉴 상세보기도 미리 준비
        try {
            markerdesc = markerDescService.getmarkerdesc( mid );
        } catch (Exception e) {
            throw new Exception("시스템 장애 발생 : ER00014");
        }

        model.addAttribute("markerdescdetail", markerdesc); //jsp파일에서 메뉴 상세보기 뿌리기
        model.addAttribute("center", dir + "detail"); // center만 변경
        model.addAttribute("leftNav", "leftNav");
        return "index";
    }
    // 6-2. 가게의 메뉴 상세정보 수정하기 
    // 6-3. 가게의 메뉴 상세정보 삭제하기
}
