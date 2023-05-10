    <%--jsp 작성을 위해 아래 3줄은 기입.--%>
    <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%--JSTL : 통화 날짜를 표현하게 해주는 문법--%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <style>
        #all {
            width: 400px;
            height: 200px;
            overflow: auto;
            border: 2px solid red;
        }

        #me {
            width: 400px;
            height: 200px;
            overflow: auto;
            border: 2px solid blue;
        }

        #to {
            width: 400px;
            height: 200px;
            overflow: auto;
            border: 2px solid green;
        }
    </style>

    <script>
        let websocket = {
            id:null, // 관리자 id
            stompClient:null, // ws와의 커넥션 준비
            init:function(){
                this.id = $('#adm_id').text(); // 관리자 id 가져오기.
                $("#connect").click(function() { // 연결
                    websocket.connect();
                });
                $("#disconnect").click(function() { // 연결해제
                    websocket.disconnect();
                });
                $("#sendall").click(function() { // 버튼1
                    websocket.sendAll();
                });
                $("#sendme").click(function() { // 버튼2
                    websocket.sendMe();
                });
                $("#sendto").click(function() { // 버튼3
                    websocket.sendTo();
                });
            },
            connect:function(){ // 연결
                var sid = this.id; // 관리자 id
                var socket = new SockJS('${adminserver}/ws'); // 관리자의 ws 서버로 접속하려 한다.
                this.stompClient = Stomp.over(socket);

                this.stompClient.connect({}, function(frame) { // ws 에 connect(접속) 완료.
                    websocket.setConnected(true);
                    console.log('Connected: ' + frame);
                    this.subscribe('/send', function(msg) { // subscribe : 접속완료 즉시, ws서버가 주는 정보를 받을준비.
                        $("#all").prepend(
                            "<h4>" + JSON.parse(msg.body).sendid +":"+
                            JSON.parse(msg.body).content1
                            + "</h4>");
                    });
                    this.subscribe('/send/'+sid, function(msg) { // subscribe : 접속완료 즉시 받을준비.
                        $("#me").prepend( // sid : 내 어드민 id
                            "<h4>" + JSON.parse(msg.body).sendid +":"+
                            JSON.parse(msg.body).content1+ "</h4>");
                    });
                    this.subscribe('/send/to/'+sid, function(msg) { // subscribe : 접속완료 즉시 받을준비.
                        $("#to").prepend(
                            "<h4>" + JSON.parse(msg.body).sendid +":"+
                            JSON.parse(msg.body).content1
                            + "</h4>");
                    });
                });
            },
            disconnect:function(){
                if (this.stompClient !== null) {
                    this.stompClient.disconnect();
                }
                websocket.setConnected(false);
                console.log("Disconnected");
            },
            setConnected:function(connected){
                if (connected) {
                    $("#status").text("Connected");
                } else {
                    $("#status").text("Disconnected");
                }
            },
            sendAll:function(){ // 보낼 때 data 만들어서 content1에 담아 보내기.
                var msg = JSON.stringify({
                    'sendid' : this.id, // 보내는 사람
                    'content1' : $("#alltext").val() // data
                });
                this.stompClient.send("/receiveall", {}, msg); // receiveall 로 메세지 전송하기.
                // receiveall : 받는사람(모두)에게 보내기 위해, admin의 msg컨트롤러가 처리한다.(컨트롤러에선, send로 메세지 뿌리기)
            },
            sendTo:function(){ // 특정인에게 msg
                var msg = JSON.stringify({
                    'sendid' : this.id,
                    'receiveid' : $('#target').val(),
                    'content1' : $('#totext').val()
                });
                this.stompClient.send('/receiveto', {}, msg); //receiveto : admin의 msg컨트롤러가 처리
            },
            sendMe:function(){ // 나에게만
                var msg = JSON.stringify({
                    'sendid' : this.id,
                    'content1' : $('#metext').val()
                });
                this.stompClient.send("/receiveme", {}, msg); //receiveme : admin의 msg컨트롤러가 처리
            }
        };
        $(function(){
            websocket.init();
        })

    </script>
    <!-- Begin Page Content -->
    <div class="container-fluid">

        <!-- Page Heading -->
        <h1 class="h3 mb-2 text-gray-800">Live Chart</h1>

        <!-- DataTales Example -->
        <div class="card shadow mb-4">
            <div class="card-header py-3">
                <h6 class="m-0 font-weight-bold text-primary">Live Chart</h6>
            </div>
            <div class="card-body">
                <div id="container"></div>
                <div class="col-sm-5">
                    <h1 id="adm_id">${loginadm.id}</h1>
                    <H1 id="status">Status</H1>
                    <button id="connect">Connect</button>
                    <button id="disconnect">Disconnect</button>

                    <h3>All</h3>
                    <input type="text" id="alltext"><button id="sendall">Send</button>
                    <div id="all"></div>

                    <h3>Me</h3>
                    <input type="text" id="metext"><button id="sendme">Send</button>
                    <div id="me"></div>

                    <h3>To</h3>
                    <input type="text" id="target">
                    <input type="text" id="totext"><button id="sendto">Send</button>
                    <div id="to"></div>

                </div>
            </div>
        </div>
        <!-- /.container-fluid -->
    </div>