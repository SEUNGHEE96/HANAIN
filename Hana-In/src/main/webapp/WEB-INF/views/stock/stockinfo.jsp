<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <style>
        .chart {
            display: flex;
            justify-content: space-between;
            width: 100%; /* or another value if needed */
        }

        .chart div {
            flex: 1;
            padding: 0 10px;
            min-width: 20%; /* or another value if needed */
        }

        .table-row {
            width: 100%;
            margin: 20px auto 60px;
        }

        .custom-table {
            /*border-collapse: collapse;*/
            border-collapse: separate;
            border-spacing: 20px 0px; /* 상하 10px 여백 */
            width: 100%;
        }

        .custom-table tr:nth-child(2) td {
            padding-top: 50px;
        }

        .custom-table td {
            border: none;
            border-bottom: 1px solid grey;
            padding: 10px;
            text-align: right;
        }

        .custom-table .title {
            color: grey;
            float: left;
        }

        .custom-table .content {
            color: black;
        }

        .title-span {
            color: grey;
            font-size: 0.8rem;
            margin-left: 5px;
        }

        .rate-td {
            width: 33%;
        }

        .btn-outline-secondary {
            margin-right: 10px; /* 버튼 간의 간격 */
            border: none !important; /* 테두리 제거 */
        }

        .btn-outline-secondary:last-child {
            margin-right: 0; /* 마지막 버튼의 오른쪽 마진 제거 */
        }

        /* 경쟁사 탭 */
        .custom-button {
            margin-right: 10px;
            margin-bottom: 10px;
            border: none !important;
            background-color: #226efe;
            color: white;
            padding: 5px 10px;
        }

        .custom-button:hover {
            background-color: #475dc4;
            color: white;
        }

        .clickable {
            cursor: pointer;
        }

        .clickable.selected {
            border: 4px solid #008485;
        }

        .selected-tag {
            color: blue;
            font-weight: bold;
        }
    </style>
</head>
<body class="loading" data-layout="detached"
      data-layout-config='{"leftSidebarCondensed":false,"darkMode":false, "showRightSidebarOnStart": true}'>

<%@ include file="../include/header.jsp" %>

<!-- Start Content-->
<div class="container-fluid">

    <!-- Begin page -->
    <div class="wrapper">

        <!-- ========== Left Sidebar Start ========== -->
        <div class="leftside-menu leftside-menu-detached">
            <%@ include file="../include/sidebar.jsp" %>
        </div>
        <!-- Left Sidebar End -->

        <div class="content-page">
            <div class="content">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">

<%--                                <div class="flex-container">--%>
                                <div class="flex-container" style="display: flex; justify-content: space-between; align-items: center;">
                                    <div id="stockInfo"></div>
                                    <button type="button" id="likeButton" class="btn btn-light"><i class="mdi mdi-heart-outline"></i></button>
                                </div>

                                <ul class="nav nav-tabs mb-3">
                                    <li class="nav-item">
                                        <a href="#home" data-bs-toggle="tab" aria-expanded="false"
                                           class="nav-link active">
                                            <i class="mdi mdi-home-variant d-md-none d-block"></i>
                                            <span class="d-none d-md-block">재무 정보</span>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#profile" data-bs-toggle="tab" aria-expanded="true"
                                           class="nav-link">
                                            <i class="mdi mdi-account-circle d-md-none d-block"></i>
                                            <span class="d-none d-md-block">시장 정보</span>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#settings" data-bs-toggle="tab" aria-expanded="false" class="nav-link">
                                            <i class="mdi mdi-settings-outline d-md-none d-block"></i>
                                            <span class="d-none d-md-block">경쟁사</span>
                                        </a>
                                    </li>
                                </ul>

                                <div class="tab-content">
                                    <div class="tab-pane show active" id="home">
                                        <div style="float: right; font-size: 0.8rem; color: grey; margin-right: 10px; margin-bottom: 20px;">
                                            단위 : 억 원
                                        </div>
                                        <div class="row table-row">
                                            <table class="custom-table">
                                                <tr> <!-- 첫 번째 행 -->
                                                    <td>
                                                        <div class="title">
                                                            매출액
                                                        </div>
                                                        <div class="content">

                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="title">
                                                            영업이익
                                                        </div>
                                                        <div class="content">

                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="title">
                                                            당기순이익
                                                        </div>
                                                        <div class="content">

                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="title">
                                                            자산
                                                        </div>
                                                        <div class="content">

                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr> <!-- 두 번째 행 -->
                                                    <td>
                                                        <div class="title">
                                                            부채
                                                        </div>
                                                        <div class="content">

                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="title">
                                                            자본
                                                        </div>
                                                        <div class="content">

                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="title">
                                                            배당수익률
                                                        </div>
                                                        <div class="content">

                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="title">
                                                            자본잉여금
                                                        </div>
                                                        <div class="content">

                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>

                                        <div class="row">
                                            <div class="chart">
                                                <div>
                                                    <h5>매출액<span id="sales-title" class="title-span"></span></h5>
                                                    <canvas id="myChart1"></canvas>
                                                </div>
                                                <div>
                                                    <h5>영업이익<span id="operating-profit-title" class="title-span"></span>
                                                    </h5>
                                                    <canvas id="myChart2"></canvas>
                                                </div>
                                                <div>
                                                    <h5>당기순이익<span id="net-profit-title" class="title-span"></span></h5>
                                                    <canvas id="myChart3"></canvas>
                                                </div>
                                                <div>
                                                    <h5>자산<span id="assets-title" class="title-span"></span></h5>
                                                    <canvas id="myChart4"></canvas>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="float: right; color: grey; font-size: 0.8rem; margin-top: 30px;">
                                            IFRS / 연결 / 2022년 12월 01일 기준
                                        </div>
                                    </div>
                                    <div class="tab-pane" id="profile">
                                        <div style="float: right; font-size: 0.8rem; color: grey; margin-right: 10px; margin-bottom: 20px;">

                                        </div>
                                        <div class="row table-row">
                                            <table class="custom-table">
                                                <tr> <!-- 첫 번째 행 -->
                                                    <td>
                                                        <div class="title">
                                                            시가총액
                                                        </div>
                                                        <div class="content">

                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="title">
                                                            주가
                                                        </div>
                                                        <div class="content">

                                                        </div>
                                                    </td>
                                                    <td class="rate-td">
                                                        <div class="title">
                                                            주가변동율
                                                        </div>
                                                        <div class="content" id="change-rate-content">

                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="title">
                                                            거래량
                                                        </div>
                                                        <div class="content">

                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr> <!-- 두 번째 행 -->
                                                    <td>
                                                        <div class="title">
                                                            EPS
                                                        </div>
                                                        <div class="content">

                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="title">
                                                            PER
                                                        </div>
                                                        <div class="content">

                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="title">
                                                            PBR
                                                        </div>
                                                        <div class="content">

                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="title">
                                                            DPS
                                                        </div>
                                                        <div class="content">

                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>

                                        <div class="row">
                                            <div class="col d-flex justify-content-center" style="margin-bottom: 30px;">
                                                <button type="button" class="btn btn-outline-secondary" data-range="1m">
                                                    최근 1달
                                                </button>
                                                <button type="button" class="btn btn-outline-secondary" data-range="3m">
                                                    최근 3달
                                                </button>
                                                <button type="button" class="btn btn-outline-secondary" data-range="1y">
                                                    올해
                                                </button>
                                                <button type="button" class="btn btn-outline-secondary"
                                                        data-range="12m">최근 1년
                                                </button>
                                                <button type="button" class="btn btn-outline-secondary"
                                                        data-range="60m">최근 5년
                                                </button>
                                                <button type="button" class="btn btn-outline-secondary"
                                                        data-range="all">전체
                                                </button>
                                                <i class="dripicons-calendar" style="margin-top: 6px;"></i>
                                            </div>
                                            <div class="chart">
                                                <div>
                                                    <canvas id="myChart5" height="100px"></canvas>
                                                </div>
                                            </div>
                                        </div>
                                        <div style="float: right; color: grey; font-size: 0.8rem; margin-top: 10px;">
                                            IFRS / 연결 / 2022년 12월 01일 기준
                                        </div>
                                    </div>
                                    <div class="tab-pane" id="settings">
                                        <h5 style="margin-top: 10px; margin-bottom: 20px;">선택 기업</h5>
                                        <div class="col d-flex">
<%--                                            <button type="button" class="custom-button">기업명 X</button>--%>
                                        </div>
                                        <hr/>
                                        <div class="row">
                                            <div class="col-lg-3">
                                                <div data-simplebar style="max-height: 400px;">
                                                    <ul class="list-group list-group-flush">
<%--                                                        <li class="list-group-item">태그 : 아무개</li>--%>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="col-lg-9">
                                                <div data-simplebar style="max-height: 400px;">
                                                    <div class="row" id="stockChartList">
<%--                                                        <div class="col-md-4">--%>
<%--                                                            <div class="card border-primary border">--%>
<%--                                                                 <div class="card-body clickable" data-stock="stock1"> <!-- clickable 클래스 및 data-stock 속성 추가 -->--%>
<%--                                                                    <div class="d-flex align-items-start">--%>
<%--                                                                        <img src="../../../resources/assets/images/users/avatar-1.jpg" alt="image" class="me-3 d-none d-sm-block avatar-sm rounded-circle">--%>
<%--                                                                        <div class="w-100 overflow-hidden">--%>
<%--                                                                            <h5 class="mb-1 mt-0">Louis K. Bond</h5>--%>
<%--                                                                            <p> Founder & CEO </p>--%>
<%--                                                                            <p class="mb-0 text-muted">--%>
<%--                                                                                abcdefghijklmnopqrstuvwxyz--%>
<%--                                                                            </p>--%>
<%--                                                                        </div> <!-- end w-100 -->--%>
<%--                                                                    </div> <!-- end d-flex -->--%>
<%--                                                                </div> <!-- end card-body -->--%>
<%--                                                            </div> <!-- end card-->--%>
<%--                                                        </div> <!-- end col-->--%>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <hr>
                                        <h5 style="margin-top: 20px; margin-bottom: 30px;">정렬 순서</h5>
                                        <div class="mt-2" style="margin-top: 15px;">
                                            <div class="form-check form-check-inline">
                                                <input type="radio" id="customRadio1" name="customRadio1" class="form-check-input" checked>
                                                <label class="form-check-label" for="customRadio1">매출액</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input type="radio" id="customRadio2" name="customRadio1" class="form-check-input">
                                                <label class="form-check-label" for="customRadio2">자산</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input type="radio" id="customRadio3" name="customRadio1" class="form-check-input">
                                                <label class="form-check-label" for="customRadio3">부채</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input type="radio" id="customRadio4" name="customRadio1" class="form-check-input">
                                                <label class="form-check-label" for="customRadio4">이익잉여금</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input type="radio" id="customRadio5" name="customRadio1" class="form-check-input">
                                                <label class="form-check-label" for="customRadio5">배당금</label>
                                            </div>
                                            <div style="width: 100%; height: 200px; position: relative; margin-top: 20px;">
                                                <canvas id="myChart6"></canvas>
                                            </div>
                                        </div>
                                        <hr/>
                                        <h5 style="margin-top: 20px;">재무 평가</h5>
                                        <div class="row">
                                            <div class="col-lg-5" style="min-height: 450px;">
                                                <canvas id="myChart7" style="width: 100%; height: 100%; display: block;"></canvas>
                                            </div>
                                            <div class="col-lg-7">
                                                <div style="float: right; font-size: 0.8rem; color: grey; text-align: right; margin-bottom: 30px;">
                                                    성장성 : 최근 3년 매출액 연평균 증가율(%)<br/>
                                                    수익성 : 직전연도 영입이익률(%)<br/>
                                                    안정성 : 직전연도 부채비율(%)<br/>
                                                    배당 : 배당수익률(%)<br/>
                                                    벨류에이션 : PER
                                                </div>
                                                <table class="table mb-0" id="stockDataTable">
                                                    <thead>
                                                    <tr class="table-active">
                                                        <th>기업명</th>
                                                        <th>성장성</th>
                                                        <th>수익성</th>
                                                        <th>안정성</th>
                                                        <th>배당</th>
                                                        <th>벨류에이션</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>

                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- end card-body-->
                        </div>
                        <!-- end card-->
                    </div>
                    <!-- end col-->
                </div>
                <!-- end row -->
            </div>
            <!-- End Content -->
        </div>
        <!-- content-page -->
    </div>
    <!-- end wrapper-->
</div>
<!-- END Container -->

<%@ include file="../include/footer.jsp" %>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="../../../resources/js/stockinfo.js"></script>

</body>
</html>
