    <%--jsp 작성을 위해 아래 3줄은 기입.--%>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%--JSTL : 통화 날짜를 표현하게 해주는 문법--%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <style>
        <%--        --%>
        #marker_img{
                width: 30px;
                height: 40px;
        }
        #marker_modal_img{
            width: 200px;
            height: 250px;
        }
    </style>
    <script>
        <%--   search 기능     --%>
        let marker_search = {
            init : function () {
                $('#search_btn').click(function (){
                    marker_search.send();
                });
            },
            send : function () {
                $('#search_form').attr({
                    action: '/marker/search', // marker 컨트롤러에서 처리.
                    method: 'get'
                });
                $('#search_form').submit();
        }
        }
        // 실행
        $(function (){
            marker_search.init();
        })

    </script>
    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800">Marker Tables</h1>
        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">등록된 맛집 전체조회</h6><br>
                <%-- search : form 수기 추가 --%>
                <form id="search_form" class="form-inline well">
                    <div class="form-group">
                        <label class="control-label col-sm-4" for="loc">loc:</label>
                        <select class="form-control"  id="loc" name="loc">
                            <option value="">전체</option>
                            <option value="s"   <c:if test="${sc.loc=='s'}">selected</c:if>>서울</option>
                            <option value="b"   <c:if test="${sc.loc=='b'}">selected</c:if>>부산</option>
                            <option value="j"   <c:if test="${sc.loc=='j'}">selected</c:if>>제주</option>
                        </select>
<%--                        <div class="col-sm-4">--%>
<%--                            <input type="text" name="loc" class="form-control" id="loc" placeholder="Enter loc">--%>
<%--                        </div>--%>
                    </div>
                    <div class="form-group">
                        <label class="control-label col-sm-2" for="title">Title:</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="title" name="title" placeholder="Input Title"
                                   value="${sc.title}">
                        </div>
                    </div>
                    <div class="form-group">
                        <div >
                            <button id="search_btn" type="button" class="btn btn-info">검색하기</button>
                        </div>
                    </div>
                </form> <%--form 수기 추가 끝. --%>

            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                        <tr>
                            <th>id</th>
                            <th>title</th>
                            <th>target</th>
                            <th>lat</th>
                            <th>lng</th>
                            <th>loc</th>
                            <th>img</th>

                        </tr>
                        </thead>
                        <tfoot>
                        <tr>
                            <th>id</th>
                            <th>title</th>
                            <th>target</th>
                            <th>lat</th>
                            <th>lng</th>
                            <th>loc</th>
                            <th>img</th>
                        </tr>
                        </tfoot>
                        <tbody>
                        <%-- tbody 안에 : 컨트롤러에서 markerlist 라는 이름으로 정보 for로 가져오기  --%>
                        <c:forEach var="obj" items="${markerlist}">
                            <tr>
                                <td><a href="/marker/detail?id=${obj.id}"> ${obj.id} </a></td>
                                <td>${obj.title}</td>
                                <td>${obj.target}</td>
                                <td>${obj.lat}</td>
                                <td>${obj.lng}</td>
                                <td>${obj.loc}</td>
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

