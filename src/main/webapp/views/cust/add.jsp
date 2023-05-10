    <%--jsp 작성을 위해 아래 3줄은 기입.--%>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%--JSTL : 통화 날짜를 표현하게 해주는 문법--%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <script>
        let cust_add = {
            init:function (){
                $('#register_btn').click( function (){ // 클릭되면
                    cust_add.send(); //send.
                });
            },
            send:function (){ // form의 정보를, 어디로 보낼까

                $('#register_form').attr({
                    method:'post', // 방식
                    action:'/cust/addimpl' // 처리할 컨트롤러 경로
                });
                $('#register_form').submit(); // 입력한 id, pwd, name 모두 전송.
            }
        };

        //실행
        $(function (){
            cust_add.init();
        });
    </script>


    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800">Cust ADD</h1>

        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">회원 등록</h6>
            </div>
            <%-- 실제 만들어지는 영역 --%>
            <div class="card-body">
                <div id="container">
                    <%-- form id : 주의 --%>
                    <form id="register_form" class="form-horizontal well">
                        <div class="form-group">
                            <label class="control-label col-sm-2" for="id">ID:</label>
                            <div class="col-sm-10">
                                <input type="text" name="id" class="form-control" id="id" placeholder="Enter id">
                            </div>
                            <div class="form-group">
                                <%--  아이디 중복확인 버튼 추가  --%>
                                <div class="col-sm-10">
                                    <span id="check_id" class="bg-danger"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="pwd">Password:</label>
                                <div class="col-sm-10">
                                    <input type="password" name="pwd" class="form-control" id="pwd" placeholder="Enter password">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="control-label col-sm-2" for="name">Name:</label>
                                <div class="col-sm-10">
                                    <input type="text" name="name" class="form-control" id="name" placeholder="Enter name">
                                </div><br>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-2 col-sm-10">
                                    <button id="register_btn" type="button" class="btn btn-info">등록하기</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>