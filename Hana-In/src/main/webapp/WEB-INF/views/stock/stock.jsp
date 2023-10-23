<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />

    <!-- third party css -->
    <link href="../../../resources/assets/css/vendor/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />
    <!-- third party css end -->
    <link href="../../../resources/css/stock.css" rel="stylesheet" type="text/css" />

    <script src="https://unpkg.com/lightweight-charts/dist/lightweight-charts.standalone.production.js"></script>
    <style>
        .col-lg-8 {
            padding: 0;
            margin: 0;
        }
        .flex-container {
            display: flex;
        }
        .flex-container > div:last-child {
            margin-left: auto;
        }
        .rounded-pill {
            margin-left: 10px;
        }
        #account-list {
            margin-left: 20px;
            margin-right: 20px;
            margin-top: 20px;
        }
        .select2-search__field {
            width:90% !important;
        }
        .horizontal-layout {
            display: flex;
            margin-top: 15px;
            margin-left: 10px;
        }
        .horizontal-layout > div {
            margin-left: 5px;
        }
        .order-book {
            height: 90%;
            overflow: auto;
            width: 90%;
            margin-top: 35px;
        }
        table {
            width: 90%;
        }
        #myChart {
            padding-top: 10px;
            margin-bottom: 20px;
        }
        #myChart .tv-lightweight-charts table:first-child {
            margin-top: 25px;
        }
        #rightForm {
            padding : 1.1rem 1.5rem;
        }
        .order-book tbody tr:nth-child(-n+10) {
            background-color: #fde8e7;
            text-align: center;
        }
        .order-book tbody tr:nth-child(n+11):nth-child(-n+20) {
            background-color: #e7f0fd;
            text-align: center;
        }
        .order-form input {
            text-align: right;
        }
        .badge {
            border-color: white !important;
        }
        .for-form {
            width: 90%;
            height: 25px;
            margin-top: 10px;
        }
        .tab-content label {
            margin-top: 5px;
        }
        .tab-content label:nth-of-type(1) {
            margin-top: 0;
        }
        .tab-content label:nth-of-type(3) {
            margin-top: 10px;
        }
        .tab-content input[type="text"] {
            border: none; /* 모든 테두리 제거 */
            border-bottom: 1px solid #000; /* 밑줄만 추가 */
            outline: none; /* 포커스 시 나타나는 테두리 제거 */
            margin-bottom: 5px;
        }
        #stockLastOhlcv {
            display: flex;
            align-items: center;
            margin-left: 10px;
        }
        #tradeTitle {
            margin-top: 20px;
            margin-bottom: 20px;
        }
    </style>
    <script src="../../../resources/js/crypto-js.min.js"></script>
</head>

<body class="loading" data-layout="detached" data-layout-config='{"leftSidebarCondensed":false,"darkMode":false, "showRightSidebarOnStart": true}'>

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

                <% if (session.getAttribute("message") != null) { %>
                <script>alert('<%= session.getAttribute("message") %>');</script>
                <% session.removeAttribute("message"); %>
                <% } %>

                <div class="row">
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-body">
                                <!-- 드랍다운 코드 하나 남겨놓기 :)
                                <div class="dropdown float-end">
                                    <a href="#" class="dropdown-toggle arrow-none card-drop" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="mdi mdi-dots-vertical"></i>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-end">
                                        <a href="javascript:void(0);" class="dropdown-item">Sales Report</a>
                                        <a href="javascript:void(0);" class="dropdown-item">Export Report</a>
                                        <a href="javascript:void(0);" class="dropdown-item">Profit</a>
                                        <a href="javascript:void(0);" class="dropdown-item">Action</a>
                                    </div>
                                </div>
                                -->
                                <div class="flex-container">
                                    <div id="stockInfo"></div>
                                    <div id="stockLastOhlcv"></div>
                                    <div style="display: inline-table;">
                                        <button type="button" class="btn btn-danger rounded-pill">매수</button>
                                        <button type="button" class="btn btn-primary rounded-pill">매도</button>
                                    </div>
                                </div>
                                <div class="horizontal-layout">
                                    <div>단순이동평균선</div>
                                    <div style='color: rgba(226, 200, 48, 1)'>20</div>
                                    <div style='color: rgba(44, 213, 120, 1)'>60</div>
                                    <div style='color: rgba(72, 194, 219, 1)'>120</div>
                                </div>

                                <div>
                                    <div id="myChart" ></div>
                                    <div id="volumeChart"></div>
                                </div>
                            </div> <!-- end card-body-->
                        </div> <!-- end card-->
                    </div> <!-- end col-->

                    <div class="col-lg-4">
                        <div class="card">
                            <div id="account-list">
                                <label class="form-label">보유계좌</label>
                                <select id="stockSelect" name="accountNumber" class="form-control select2" data-toggle="select2">
                                    <c:forEach items="${accountlist}" var="account" varStatus="status">
                                        <option value="${account.accountNumber}">${account.accountNumber}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <!-- 호가창 -->
                            <div class="card-body" id="rightForm">
                                <div>
                                    <div id="stockInfo2"></div>
                                </div>
                                <!-- 호가창 + 매수 매도 창 -->
                                <div class="order">
                                    <!-- 호가창 -->
                                    <div data-simplebar class="order-book">
                                        <table>
                                            <thead>
                                            </thead>
                                            <tbody id="output">
                                                <tr>
                                                    <td>0</td>
                                                    <td>0</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- 매수/매도 창 -->
                                    <div class="order-form">
                                        <ul class="nav nav-tabs nav-justified nav-bordered mb-3">
                                            <li class="nav-item">
                                                <a href="#home-b2" data-bs-toggle="tab" aria-expanded="false" class="nav-link">
                                                    <i class="mdi mdi-home-variant d-md-none d-block"></i>
                                                    <span class="d-none d-md-block">매수</span>
                                                </a>
                                            </li>
                                            <li class="nav-item">
                                                <a href="#profile-b2" data-bs-toggle="tab" aria-expanded="true" class="nav-link active">
                                                    <i class="mdi mdi-account-circle d-md-none d-block"></i>
                                                    <span class="d-none d-md-block">매도</span>
                                                </a>
                                            </li>
<%--                                            <li class="nav-item">--%>
<%--                                                <a href="#settings-b2" data-bs-toggle="tab" aria-expanded="false" class="nav-link">--%>
<%--                                                    <i class="mdi mdi-settings-outline d-md-none d-block"></i>--%>
<%--                                                    <span class="d-none d-md-block">Settings</span>--%>
<%--                                                </a>--%>
<%--                                            </li>--%>
                                        </ul>

                                        <div class="tab-content">
                                            <div class="tab-pane" id="home-b2">
                                                <form id="buyForm" action="/buyStock" method="post">

                                                    <input type="hidden" name="accountId" id="accountId">
                                                    <input type="hidden" name="isin" id="isin">

                                                    <label for="buyPrice">가격</label><br>
                                                    <input type="text" id="buyPrice" name="price" class="price" placeholder="0" style="flex: 1;">
                                                    <span>원</span>

                                                    <label for="orderQuantity">수량</label><br>
                                                    <input type="text" id="orderQuantity" name="quantity" placeholder="0" style="flex: 1;">
                                                    <span>주</span>
                                                    <button type="button" id="10percent" class="badge bg-light text-dark">10%</button>
                                                    <button type="button" id="25percent" class="badge bg-light text-dark">25%</button>
                                                    <button type="button" id="50percent" class="badge bg-light text-dark">50%</button>
                                                    <button type="button" id="100percent" class="badge bg-light text-dark">100%</button>
                                                    <br>

                                                    <label for="availableFunds">보유 현금</label><br>
                                                    <input type="text" id="availableFunds" name="cash" value="0" readonly style="flex: 1;">
                                                    <span>원</span>

                                                    <label for="totalOrder">총액</label><br>
                                                    <input type="text" id="totalOrder" name="totalOrder" readonly style="flex: 1;">
                                                    <span>원</span>

                                                    <button class="badge bg-light text-dark for-form" type="submit">매수</button>
                                                </form>
                                            </div>
                                            <div class="tab-pane show active" id="profile-b2">
                                                <form id="sellFrom" action="/sellStock" method="post">

                                                    <input type="hidden" name="accountId" id="accountId2">
                                                    <input type="hidden" name="isin" id="isin2">

                                                    <label for="buyPrice">가격</label><br>
                                                    <input type="text" id="buyPrice2" name="price" class="price" placeholder="0" style="flex: 1;">
                                                    <span>원</span>

                                                    <label for="orderQuantity">수량</label><br>
                                                    <input type="text" id="orderQuantity2" name="quantity" placeholder="0" style="flex: 1;">
                                                    <span>주</span>

                                                    <button type="button" id="10percent2" class="badge bg-light text-dark">10%</button>
                                                    <button type="button" id="25percent2" class="badge bg-light text-dark">25%</button>
                                                    <button type="button" id="50percent2" class="badge bg-light text-dark">50%</button>
                                                    <button type="button" id="100percent2" class="badge bg-light text-dark">100%</button>
                                                    <br>

                                                    <label for="availableFunds">매도 가능 수량</label><br>
                                                    <input type="text" id="availableFunds2" name="availableFunds" value="0" readonly style="flex: 1;">
                                                    <span>주</span>

                                                    <label for="totalOrder">총액</label><br>
                                                    <input type="text" id="totalOrder2" name="totalOrder" readonly style="flex: 1;">
                                                    <span>원</span>

                                                    <button class="badge bg-light text-dark for-form" type="submit">매도</button>
                                                </form>
                                            </div>
<%--                                            <div class="tab-pane" id="settings-b2">--%>
<%--                                                <p>...</p>--%>
<%--                                            </div>--%>
                                        </div>
                                    </div>
                                </div>
                                <h4 style="margin: 20px 0;">거래내역</h4>
                                <div class="trades">
                                    <div id="tradeInfo">
                                        <%-- 거래 내역 ajax로 표시--%>
                                    </div>
                                    <%-- 한투 API 호출 내역 숨겨놓기 --%>
                                    <div style="display: none">
                                        <div style="background-color:#EEEEEE">
                                            <pre id="output3" style="width: 100%; height: 10%; overflow: auto;"></pre>
                                        </div>
                                        <div class="left" style="background-color:#FFF5EE">
                                            <input type="text" id="inputMessage1" style="width: 180px; height: 20px" value="005930"><br>
                                            <button id="hokaregButton1" style="width: 80px; height: 20px; font-size: 12px">주식호가</button>
                                            <button id="hokaderegButton1" style="width: 100px; height: 20px; font-size: 12px">주식호가해제</button>
                                            <button id="closeButton" style="width: 100px; height: 20px; font-size: 12px">연결해제</button>
                                        </div>
                                    </div>
                                </div>
                            </div> <!-- end card-body-->
                        </div> <!-- end card-->
                    </div> <!-- end col-->
                </div>
                <!-- end row -->
            </div> <!-- End Content -->
        </div>
        <!-- content-page -->
    </div> <!-- end wrapper-->
</div>
<!-- END Container -->

<%@ include file="../include/footer.jsp" %>

<!-- third party js -->
<script src="../../../resources/assets/js/vendor/apexcharts.min.js"></script>
<script src="../../../resources/assets/js/vendor/jquery-jvectormap-1.2.2.min.js"></script>
<script src="../../../resources/assets/js/vendor/jquery-jvectormap-world-mill-en.js"></script>
<!-- third party js ends -->

<!-- demo app -->
<script src="../../../resources/assets/js/pages/demo.dashboard.js"></script>
<!-- end demo js-->

<script src="../../../resources/js/stock.js"></script>
<script src="../../../resources/js/stock2.js"></script>

</body>
</html>
