    <%--jsp 작성을 위해 아래 3줄은 기입.--%>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%--JSTL : 통화 날짜를 표현하게 해주는 문법--%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <style>
        <%--        --%>
        #markerdesc_img{
                width: 30px;
                height: 40px;
        }
        #markerdesc_modal_img{
            width: 200px;
            height: 250px;
        }
    </style>
    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800">MarkerDesc Tables</h1>
        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">상세메뉴 조회</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                        <tr>
                            <th>id</th>
                            <th>marker_id</th>
                            <th>item</th>
                            <th>price</th>
                            <th>imgname</th>
                        </tr>
                        </thead>
                        <tfoot>
                        <tr>
                            <th>id</th>
                            <th>marker_id</th>
                            <th>item</th>
                            <th>price</th>
                            <th>imgname</th>

                        </tr>
                        </tfoot>
                        <tbody>
                        <%-- tbody 안에 : 컨트롤러에서 markerdescdetail 라는 이름으로 정보 for로 가져오기  --%>
                        <c:forEach var="obj" items="${markerdescdetail}">
                            <tr>
                                <td><a href="/marker/markerdesc?marker_id=${obj.marker_id}"> ${obj.marker_id} </a></td>
                                <td>${obj.id}</td>
                                <td>${obj.item}</td>
                                <td>${obj.price}</td>
                                <td>${obj.imgname}</td>
                                <td>
                                    <!-- 이미지 클릭 시 Modal 호출  id는, target+맛집의 id로 설정! -->
                                    <a href="#" data-toggle="modal" data-target="#target${obj.id} ">
                                    <img src="/uimg/${obj.img}" id="marker_img">
                                    </a>
                                </td>
                            </tr>
                            <!-- /.container-fluid -->
                            <!-- 이미지 클릭 시 Modal 호출  id는, target+맛집의 id로 설정! -->
                            <div id="target${obj.id}" class="modal fade" role="dialog">
-                                <div class="modal-dialog">

                                    <!-- Modal content-->
                                   <div class="modal-content">
                                        <div class="modal-header">
                                          <h4 class="modal-title">맛집 상세이미지</h4>
                                        </div>
                                        <%--      모달 호출된 뒤 보여지는 내용! 1. 맛집id 2. 큰 이미지--%>
                                        <div class="modal-body">
                                           <p> ${obj.id} </p>
                                            <img src="/uimg/${obj.img}" id="marker_modal_img"><br><br>
                                            <a href="/marker/detail?id=${obj.id}" class="btn btn-info">자세히보기</a>
                                        </div>
                                        <div class="modal-footer">
                                            <a href= "#" class="btn btn-default" data-dismiss="modal">창닫기</a>
                                        </div>
                                    </div>

                               </div>
                            </div>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </div>

