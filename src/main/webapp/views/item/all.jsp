    <%--jsp 작성을 위해 아래 3줄은 기입.--%>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%--JSTL : 통화 날짜를 표현하게 해주는 문법--%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <style>
        #item_img{
                width: 60px;
                height: 70px;
        }
        #item_modal_img{
            width: 200px;
            height: 250px;
        }
    </style>
<%--    <script>--%>
<%--        &lt;%&ndash;   search 기능     &ndash;%&gt;--%>
<%--        let item_search = {--%>
<%--            init : function () {--%>
<%--                $('#search_btn').click(function (){--%>
<%--                    item_search.send();--%>
<%--                });--%>
<%--            },--%>
<%--            send : function () {--%>
<%--                $('#search_form').attr({--%>
<%--                    action: '/item/search', // item 컨트롤러에서 처리.--%>
<%--                    method: 'get'--%>
<%--                });--%>
<%--                $('#search_form').submit();--%>
<%--            }--%>
<%--        };--%>
<%--        // 실행--%>
<%--        $(function (){--%>
<%--            item_search.init();--%>
<%--        });--%>

<%--    </script>--%>
    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800">Item Tables</h1>
        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">상품 전체현황 조회</h6>
                <%--item의 search 기능을 위해 새로 만든 DTO(ItemSearch), 정보를 담은 명칭은 ic: form  추가 action / method 필요 --%>
                <%-- form태그 안에 action="/item/search" 이라고 써주면, 복잡하게 js 안적어도 된다!!!
                단 절대 주의할 것!!! 이 방식을 선택하면, 발송putton type="submit" 필수 --%>
                <form id="search_form"  action="/item/search" method="get" class="form-inline well"  >
                    <div class="form-group col-sm-5">
                        <label class="control-label col-sm-5" for="name">Name:</label>
                            <div>
                                <input type="text" name="name"  class="form-control col-sm-6" id="name" placeholder="Enter name" value="${ic.name}">
                            </div>
                    </div>

                    <div class="form-group col-sm-5">
                        <label class="control-label col-sm-5" for="price">Price:</label>
                        <div>
                            <input type="number" name="price"  class="form-control col-sm-6" id="price" placeholder="Enter price" value="${ic.price}">
                        </div>
                    </div>

                    <div class="form-group col-sm-5">
                        <label class="control-label col-sm-5" for="startdate">Start DATE:</label>
                        <div>
                            <input type="date" name="startdate"  class="form-control col-sm-6" id="startdate" placeholder="Enter startdate" value="${ic.startdate}">
                        </div>
                    </div>


                    <div class="form-group col-sm-5">
                        <label class="control-label col-sm-5" for="enddate">End DATE:</label>
                        <div>
                            <input type="date" name="enddate"  class="form-control col-sm-6" id="enddate" placeholder="Enter enddate" value="${ic.enddate}">
                        </div>
                    </div>
                    <div class="form-group col-sm-2">
                            <button id="search_btn" type="submit" class="btn btn-info">검색하기</button>
                    </div>
                </form> <%--form 수기 추가 끝. --%>
            </div>
            <%-- item 전체 조회 내용 시작 --%>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                        <thead>
                        <tr>
                            <th>imgname</th>
                            <th>id</th>
                            <th>name</th>
                            <th>price</th>
                            <th>rdate</th>

                        </tr>
                        </thead>
                        <tfoot>
                        <tr>
                            <th>imgname</th>
                            <th>id</th>
                            <th>name</th>
                            <th>price</th>
                            <th>rdate</th>
                        </tr>
                        </tfoot>
                        <tbody>
                        <%-- tbody 안에 : item컨트롤러 /all에서 itemlist 라는 이름으로 정보 for로 가져오기  --%>
                        <c:forEach var="obj" items="${itemlist}">
                            <tr>
                                <td>
                                    <a href="#" data-toggle="modal" data-target="#target${obj.id} ">
                                    <img src="/uimg/${obj.imgname}" id="item_img">
                                    </a>
                                </td>
                                <td><a href="/item/detail?id=${obj.id}"> ${obj.id} </a></td>
                                <td>${obj.name}</td>
                                <td><fmt:formatNumber value="${obj.price}" type="number" pattern="###,###원" /></td>
                                <td><fmt:formatDate pattern="yyyy-MM-dd" value="${obj.rdate}" /></td>
                            </tr>
                            <!-- /.container-fluid -->
                            <!-- 이미지 클릭 시 Modal 호출  id는, target+제품의 id로 설정! -->
                            <div id="target${obj.id}" class="modal fade" role="dialog">
                                <div class="modal-dialog">

                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h4 class="modal-title">상품 상세이미지</h4>
                                        </div>
                                        <%--   모달 호출된 뒤 보여지는 내용! 1. 상품id 2. 큰 이미지--%>
                                        <div class="modal-body">
                                            <p> ${obj.id} </p>
                                            <img src="/uimg/${obj.imgname}" id="item_modal_img"><br><br>
                                            <a href="/item/detail?id=${obj.id}" class="btn btn-info">자세히보기</a>
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

