    <%--jsp 작성을 위해 아래 3줄은 기입.--%>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%--JSTL : 통화 날짜를 표현하게 해주는 문법--%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <style>
        #img{
            width: 550px;
            height: 450px;
        }
        #map{
            width: 220px;
            height: 350px;
            border: solid 1px gray;
        }
    </style>
    <script>
        // 2- 맛집 위치 지도로 보여주기
        let marker_detail_map = {
            map:null,
            init:function(){
                // 아래부턴 ''지도'' 나타내기
                var mapContainer = document.querySelector('#map'); // map : 지도뿌리는 영역의 id
                // center : marker 컨트롤러에서, 맛집정보를 담은 명칭은 markerdetail
                var mapOption =  {
                    center: new kakao.maps.LatLng(${markerdetail.lat},${markerdetail.lng}), // 지도의 중심좌표
                    level: 3
                };
                map = new kakao.maps.Map(mapContainer, mapOption);

                var mapTypeControl = new kakao.maps.MapTypeControl();
                map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
                var zoomControl = new kakao.maps.ZoomControl();
                map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
                // 아래부턴 ''노란색 마커'' 표시
                var markerPosition  = new kakao.maps.LatLng(${markerdetail.lat},${markerdetail.lng});
                var marker = new kakao.maps.Marker({
                    position: markerPosition
                });
                marker.setMap(map);

                var iwContent = '<img src="/uimg/${markerdetail.img}" style="width:80px"><div style="padding:5px;">Hello World!</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

                var infowindow = new kakao.maps.InfoWindow({
                    content : iwContent
                });

                kakao.maps.event.addListener(marker, 'mouseover', function() {
                    infowindow.open(map, marker);
                });

                kakao.maps.event.addListener(marker, 'mouseout', function() {
                    infowindow.close();
                });
                // 마커 클릭 하면 해당맛집 url 연동(location).
                kakao.maps.event.addListener(marker, 'click', function() {
                    location.href='${markerdetail.target}';
                });
            }
        };

        // 1- 맛집 정보 수정/삭제하기 기능
        let marker_detail = {
            init:function (){
                $('#update_btn').click( function (){
                    marker_detail.send();
                });
                $('#delete_btn').click( function (){
                    var c = confirm("맛집 정보를 삭제하시겠습니까?");
                    if(c == true){
                        location.href="/marker/deleteimpl?id=${markerdetail.id}";
                        // 삭제할 id가 무엇인지 정확히 다시한번 위치써주고, true면 삭제완료 페이지로.
                    }

                })
            },
            send:function (){
                $('#detail_form').attr({
                    method : 'post',
                    action : '/marker/updateimpl', // item컨트롤러에서 처리
                    enctype : 'multipart/form-data' // 수정한 이미지파일도 날아가야 하므로.
                });
                $('#detail_form').submit(); // 전송.
            }
        };
        //실행(2가지 기능 함께 적기)
        $(function (){
            marker_detail.init();
            marker_detail_map.init();
        });
    </script>


    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800">Marker Tables</h1>

        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">맛집정보 상세조회</h6>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <%-- 표(테이블)로 db에 담긴 사용자정보(list. marker 컨트롤러가 화면에서 뿌릴 땐
                        markerdetail로 이름 지었다.) 출력하기   --%>
                    <div class="col-sm-12">
                        <div class ="container col-sm-12">

                            <h2>맛집정보 상세보기</h2>

                            <form id="detail_form">
                                <div class="form-floating mt-3 mb-3">
                                    <label for="img">img</label>
                                    <img src="/uimg/${markerdetail.img}"class="form-control" id="img" name="img" value="${markerdetail.img}"/>
                                    <%-- 이미지 파일도 수정되었을 땐, input : hidden으로 날아가도록 한다.
                                     그리고, 1. 이미지 파일에서 이름 따와서 교체하고, 2. 파일덩어리도 다른걸로 저장한다. --%>
                                    <input type="hidden" name="img" value="${markerdetail.img}" />
                                </div>
                                <%-- 상세메뉴는 희망해서 자발적으로 추가한 부분 --%>
                                <a href="/marker/markerdesc?marker_id=${obj.id}" class="btn btn-primary btn-block">등록된 상세메뉴보기</a>
                                <div class="form-floating mt-3 mb-3">
                                    <label for="id">id</label>
                                    <input type="text" class="form-control" id="id" name="id" value="${markerdetail.id}" readonly/>
                                    <%-- id정보도 같이 날아가야 수정 되므로, input : type을 hidden 으로 바꿔준다.
                                    예시. from 정보 중, 이미지는 수정을 안했다면, 수정을 하기로 건드린 것만 서버로 전송된다. --%>
                                    <input type="hidden" class="form-control" id="id" name="id" value="${markerdetail.id}" />
                                </div>
                                <div class="form-floating mt-3 mb-3">
                                    <label for="title">title</label>
                                    <input type="text" class="form-control" id="title" name="title" value="${markerdetail.title}"/>
                                </div>
                                <div class="form-floating mt-3 mb-3">
                                    <label for="target">target</label>
                                    <input type="text" class="form-control" id="target" name="target" value="${markerdetail.target}"/>
                                </div>
                                <div class="form-floating mt-3 mb-3">
                                    <label for="lat">lat</label>
                                   <input type="text" class="form-control" id="lat" name="lat" value="${markerdetail.lat}"/>
                                </div>
                                <div class="form-floating mb-3 mt-3">
                                    <label for="lng">lng</label>
                                    <input type="text" class="form-control" id="lng"  name="lng" value="${markerdetail.lng}" />
                                    <%--   CustController 에서 db에 있는 회원 정보를 담겠다고 만든 이름 : markerdetail    --%>
                                </div>
                                <div class="form-floating mb-3 mt-3">
                                    <label for="loc">loc</label>
                                    <input type="text" class="form-control" id="loc"  name="loc" value="${markerdetail.loc}" />
                                    <%--   CustController 에서 db에 있는 회원 정보를 담겠다고 만든 이름 : markerdetail    --%>
                                </div>
<%--                                이미지 파일 첨부가 가능한 구간 --%>
                                <div class="form-floating mb-3 mt-3">
                                    <label for="send_img">send_img</label>
                                    <input type="file" class="form-control" id="send_img"  name="send_img" value="${markerdetail.send_img}" />
                                </div>

                                <br>
                                <button type="button" class="btn btn-primary"  id="update_btn">수정하기</button>
                                <button type="button" class="btn btn-primary"  id="delete_btn">삭제하기</button>
                            </form>
                                <%--  맨 하단 기능 추가하기 : marker가 가리키는 좌표 지도에 나타내기
                                       주의! 지도를 표시할 영역을 너비/높이/선으로 표시 --%>
                                <div class="card-body">
                                    <div class="row ">
                                        <div class="col-sm-10" id="map">

                                        </div>
                                    </div>
                                </div>
                        </div>
                    </div><%--  복사끝   --%>
                </div>
            </div>
        </div>

    </div>