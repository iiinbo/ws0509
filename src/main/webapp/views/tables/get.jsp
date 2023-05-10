<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--JSTL : 통화 날짜를 표현하게 해주는 문법--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Tables</title>

    <!-- Custom fonts for this template -->
    <link href="/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
            href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
            rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
    <%-- web05 의 부트스트랩 --%>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>

<body>
<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Page Heading -->
    <h1 class="h3 mb-2 text-gray-800">Tables</h1>
    <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
        For more information about DataTables, please visit the <a target="_blank"
                                                                   href="https://datatables.net">official DataTables documentation</a>.</p>

    <!-- DataTales Example -->
    <div class="card shadow mb-4">
        <div class="card-header py-3">
            <h6 class="m-0 font-weight-bold text-primary">회원정보창</h6>
        </div>
        <div class="card-body">
            <div class="table-responsive">
            <%-- 표(테이블)로 db에 담긴 사용자정보(list. 화면에서 뿌릴 땐  로 이름 지었다.) 출력하기   --%>
                <%--  아래는, web05 버전  --%>
                <div class="col-sm-12">
                    <div class ="container col-sm-12">

                        <h2>회원정보 상세보기</h2>

                        <form id="update_form">
                            <div class="form-floating mb-3 mt-3">
                                <label for="name">name</label>
                                <input type="text" class="form-control" id="name"  name="name" value="${gitem.name}" readonly/>
                                <%--   CustController 에서 db에 있는 회원 정보를 담겠다고 만든 이름 : gcust    --%>
                            </div>
                            <div class="form-floating mb-3 mt-3">
                                <label for="position">position</label>
                                <%--  readonly : 수정 불가한 input 보여주기만 가능.--%>
                                <input type="text" class="form-control" id="position" name="position" value="${gitem.position}" />
                            </div>
                            <div class="form-floating mt-3 mb-3">
                                <label for="office">office</label>
                                <input type="text" class="form-control" id="office" name="office" value="${gitem.office}"/>
                            </div>
                            <div class="form-floating mt-3 mb-3">
                                <label for="age">age</label>
                                <input type="text" class="form-control" id="age" name="age" value="${gitem.age}"/>
                            </div>
                            <div class="form-floating mt-3 mb-3">
                                <label for="age">startdate</label>
                                <input type="text" class="form-control" id="startdate" name="startdate" value="${gitem.startdate}" pattern="yyyy-MM-dd" />
                            </div>
                            <div class="form-floating mt-3 mb-3">
                                <label for="age">salary</label>
                                <input type="text" class="form-control" id="salary" name="salary" value="${gitem.salary}"/>
                            </div>
                            <br>
                            <button type="button" class="btn btn-primary"  id="update_btn">수정하기</button>
                            <button type="button" class="btn btn-primary"  id="remove_btn">삭제하기</button>
                        </form>



                    </div>
                </div><%--  복사끝   --%>
            </div>
        </div>
    </div>

</div>
<!-- /.container-fluid -->
<!-- End of Main Content -->
<!-- Bootstrap core JavaScript-->
<script src="/vendor/jquery/jquery.min.js"></script>
<script src="/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<!-- Core plugin JavaScript-->
<script src="/vendor/jquery-easing/jquery.easing.min.js"></script>

<!-- Custom scripts for all pages-->
<script src="/js/sb-admin-2.min.js"></script>

<!-- Page level plugins -->
<script src="/vendor/datatables/jquery.dataTables.min.js"></script>
<script src="/vendor/datatables/dataTables.bootstrap4.min.js"></script>

<!-- Page level custom scripts -->
<script src="/js/demo/datatables-demo.js"></script>

</body>
</html>
