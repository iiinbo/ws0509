<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">


    <style>
        #c1{
            width: 90%;
            height: 400px;
            border: black 1px solid;
        }
    </style>
    <script>
        let chart01 = {
            init:function (){
                this.getdata1();
            },
            getdata1:function (){
                $.ajax({
                    url:'/chart0301',
                    success:function (result){
                        chart01.display1(result); }

                });
        },
        // 차트 그리는 공간 : 복사 붙여넣기
        display1:function (result){
            Highcharts.chart('c1', { // id변경
                chart: {
                    type: 'pie',
                    options3d: {
                        enabled: true,
                        alpha: 45
                    }
                },
                title: {
                    text: 'Beijing 2022 gold medals by country',
                    align: 'left'
                },
                subtitle: {
                    text: '3D donut in Highcharts',
                    align: 'left'
                },
                plotOptions: {
                    pie: {
                        innerSize: 100,
                        depth: 45
                    }
                },
                series: [{
                    name: 'Medals',
                    data: result // 배열안에 배열형태.

                }]
            }); // 붙여넣기 끝.

        }
        }


        // 실행
        $(function (){
            chart01.init();
        });
    </script>

<!-- Begin Page Content -->
<div class="container-fluid">

    <!-- Content Row -->
    <div class="row">
        <div class="col-sm-12">
            <div class ="container col-sm-12" id="chart01">
                <h3>chart 01</h3>
                <div class="row">
                    <div class="col-sm-12" id="c1">chart1</div>
                </div>
            </div>

        </div>
    </div>

</div>

