    <%--jsp 작성을 위해 아래 3줄은 기입.--%>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%--JSTL : 통화 날짜를 표현하게 해주는 문법--%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <script>
        let cust_detail = {
          init:function (){
              $('#update_btn').click( function (){
                  cust_detail.send();
              });
              $('#delete_btn').click( function (){
                  var c = confirm("회원정보를 탈퇴하시겠습니까?");
                  if(c == true){
                      location.href="/cust/deleteimpl?id=${custdetail.id}";
                      // 삭제할 id가 무엇인지 정확히 다시한번 위치써주고, true면 삭제완료 페이지로.
                  }

              })
          },
          send:function (){
              $('#detail_form').attr({
                  method : 'post',
                  action : '/cust/updateimpl' // cust컨트롤러에서 처리
              });
              $('#detail_form').submit(); // 전송.
          }
        };


        //실행
        $(function (){
            cust_detail.init();
        });
    </script>

    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800">Cust Tables</h1>

        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">회원정보 상세조회</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <%-- 표(테이블)로 db에 담긴 사용자정보(list. 화면에서 뿌릴 땐  로 이름 지었다.) 출력하기   --%>
                    <%--  아래는, web05 버전  --%>
                    <div class="col-sm-12">
                        <div class ="container col-sm-12">

                            <h2>회원정보 상세보기</h2>

                            <form id="detail_form">
                                <div class="form-floating mb-3 mt-3">
                                    <label for="id">id</label>
                                    <input type="text" class="form-control" id="id"  name="id" value="${custdetail.id}" readonly/>

                                </div>

                                <div class="form-floating mt-3 mb-3">
                                    <label for="name">name</label>
                                    <input type="text" class="form-control" id="name" name="name" value="${custdetail.name}"/>
                                </div>
                                <div class="form-floating mb-3 mt-3">
                                    <label for="pwd">password</label>
                                    <%--  패스워드는 블랭크. 입력해야 수정/삭제 가능--%>
                                    <input type="text" class="form-control" id="pwd" name="pwd" placeholder="비밀번호를 재입력 해주세요"/>
                                </div>

                                <br>
                                <button type="button" class="btn btn-primary"  id="update_btn">수정하기</button>
                                <button type="button" class="btn btn-primary"  id="delete_btn">탈퇴하기</button>
                            </form>

                        </div>
                    </div><%--  복사끝   --%>
                </div>
            </div>
        </div>

    </div>