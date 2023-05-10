    <%--jsp 작성을 위해 아래 3줄은 기입.--%>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%--JSTL : 통화 날짜를 표현하게 해주는 문법--%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <style>
        #imgname{
            width: 200px;
            height: 250px;
        }
    </style>
    <script>
        let item_detail = {
            init:function (){
                $('#update_btn').click( function (){
                    item_detail.send();
                });
                $('#delete_btn').click( function (){
                    var c = confirm("상품정보를 삭제하시겠습니까?");
                    if(c == true){
                        location.href="/item/deleteimpl?id=${itemdetail.id}";
                        // 삭제할 id가 무엇인지 정확히 다시한번 위치써주고, true면 삭제완료 페이지로.
                    }

                })
            },
            send:function (){
                $('#detail_form').attr({
                    method : 'post',
                    action : '/item/updateimpl', // item컨트롤러에서 처리
                    enctype : 'multipart/form-data' // 수정한 이미지파일도 날아가야 하므로.
                });
                $('#detail_form').submit(); // 전송.
            }
        };


        //실행
        $(function (){
            item_detail.init();
        });
    </script>
    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800">Item Tables</h1>

        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">상품정보 상세조회</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <%-- 표(테이블)로 db에 담긴 사용자정보(list. 화면에서 뿌릴 땐  로 이름 지었다.) 출력하기   --%>
                    <%--  아래는, web05 버전  --%>
                    <div class="col-sm-12">
                        <div class ="container col-sm-12">

                            <h2>상품정보 상세보기</h2>

                            <form id="detail_form">
                                <div class="form-floating mt-3 mb-3">
                                    <label for="imgname">imgname</label>
                                    <img src="/uimg/${itemdetail.imgname}"class="form-control" id="imgname" name="imgname" value="${itemdetail.imgname}"/>
                                    <%-- 이미지 파일도 수정되었을 땐, input : hidden으로 날아가도록 한다.
                                     그리고, 1. 이미지 파일에서 이름 따와서 교체하고, 2. 파일덩어리도 다른걸로 저장한다. --%>
                                    <input type="hidden" name="imgname" value="${itemdetail.imgname}" />
                                </div>
                                <div class="form-floating mt-3 mb-3">
                                    <label for="id">id</label>
                                    <input type="text" class="form-control" id="id" name="id" value="${itemdetail.id}" readonly/>
                                    <%-- id정보도 같이 날아가야 수정 되므로, input : type을 hidden 으로 바꿔준다.
                                    예시. from 정보 중, 이미지는 수정을 안했다면, 수정을 하기로 건드린 것만 서버로 전송된다. --%>
                                    <input type="hidden" class="form-control" id="id" name="id" value="${itemdetail.id}"/>
                                </div>
                                <div class="form-floating mt-3 mb-3">
                                    <label for="name">name</label>
                                   <input type="text" class="form-control" id="name" name="name" value="${itemdetail.name}"/>
                                </div>
                                <div class="form-floating mb-3 mt-3">
                                    <label for="price">price</label>
                                    <input type="number" class="form-control" id="price"  name="price" value="${itemdetail.price}" />
                                    <%--   CustController 에서 db에 있는 회원 정보를 담겠다고 만든 이름 : itemdetail    --%>
                                </div>
                                <div class="form-floating mb-3 mt-3">
                                    <label for="price">img</label>
                                    <input type="file" class="form-control" id="img"  name="img" value="${itemdetail.img}" />
                                </div>
<%--                                <div class="form-floating mt-3 mb-3">--%>
<%--                                    <label for="rdate">rdate</label>--%>
<%--                                    <input type="text" class="form-control" id="rdate" name="rdate"  value="${itemdetail.rdate}"/>--%>
<%--                                </div>--%>


                                <br>
                                <button type="button" class="btn btn-primary"  id="update_btn">수정하기</button>
                                <button type="button" class="btn btn-primary"  id="delete_btn">삭제하기</button>
                            </form>

                        </div>
                    </div><%--  복사끝   --%>
                </div>
            </div>
        </div>

    </div>