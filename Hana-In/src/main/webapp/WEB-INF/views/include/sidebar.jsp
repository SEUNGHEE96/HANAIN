<%@ page import="java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        .side-nav-link {
            display: flex;
            align-items: center;   /* 수직 중앙 정렬 */
        }
        .box {
            background: #BDBDBD;
            display: inline-block;
            width: 35px;
            height: 35px;
            border-radius: 70%;
            overflow: hidden;
            margin-right: 10px;
        }
        .profile {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: inline-block;
            vertical-align: middle; /* img를 수직 가운데로 정렬하기 위한 추가된 스타일 */
        }
        .stock-name { /* stockName 스타일 */
            font-size: 1em; /* 글자 크기 키우기 */
            color: black; /* 검정색으로 설정 */
        }
        .stock-isin { /* isin 스타일 */
            font-size: 0.8em; /* 글자 크기 줄이기 */
            color: grey; /* 회색으로 설정 */
        }
        .side-nav-title {
            font-size: 2em;  /* 기존 크기의 1.5배로 설정 */
        }

        <!-- 검색창 -->

        .searchform {
            display: block;
            margin: 0;
            overflow: hidden;
        }
        label, input {
            vertical-align: baseline;
            color: #737373;
        }
        input[type="search"] {
            border: 2px solid #737373;
            border-width: 0 0 3px;
            background-color: transparent;
            padding: 0.125em 0.225em;
            width: 70%;
            margin-left: 20px;
        }
        input[type="search"]:focus {
            color: #008485;
            border-color: #008485;
            outline: none;
        }
        .search-result {
            background-color: white;
            width: 183px;
            margin-left: 24px;
            border: 1px solid #e7ebf0;
            border-bottom-right-radius: 5%;
            border-bottom-left-radius: 5%;
            z-index: 100;
            position: absolute;
        }
        .search-result-item {
            margin-left: 10px;
            margin: 5px;
        }
    </style>
</head>
<body>

<div class="leftbar-user">
    <a href="javascript: void(0);">
        <c:if test="${empty currentUser }">
            <img src="../../../resources/img/person/null.png" alt="user-image" height="42" class="rounded-circle shadow-sm">
            <span class="leftbar-user-name"><a href="${pageContext.request.contextPath }/login" class="login-link">로그인</a></span>
        </c:if>
        <c:if test="${not empty currentUser }">
            <img src="../../../resources/img/person/${currentUser.memberId }.jpg" alt="user-image" height="42" class="rounded-circle shadow-sm">
            <span class="leftbar-user-name"><a href="${pageContext.request.contextPath }/mypage" class="login-link">${currentUser.name }</a>&nbsp;님</span>
        </c:if>
    </a>
</div>

<!--- Sidemenu -->
<ul class="side-nav">

    <div class="searchBar">
        <form class="searchform group">
            <label for="search-box">
                <span class="fa fa-2x fa-search"></span>
            </label>

            <input type="search" id="search-box" placeholder="Search">
            <img id="hokaregButton1" class="search-button" src="../resources/img/search.png" alt="search" style="width: 20px; height: 20px;">
        </form>
    </div>
    <div class="search-result"></div>

    <li class="side-nav-title side-nav-item">보유종목</li>

    <%
        List<String> menuNames = Arrays.asList("Ecommerce","Email", "Projects", "Tasks", "Pages", "Layouts", "BaseUI", "ExtendedUI", "Icons", "Forms", "Charts", "Tables", "Maps", "MultiLevel");
        request.setAttribute("menuNames", menuNames);
    %>

    <c:if test="${not empty userStocks}">
        <c:forEach items="${userStocks}" var="stock" varStatus="status">
            <li class="side-nav-item">
                <a data-bs-toggle="collapse" aria-expanded="false" href="#sidebar${menuNames[status.index]}" aria-controls="sidebar${menuNames[status.index]}"
                   class="side-nav-link">
                    <div class="box">
                        <img class="profile" src="../../../resources/img/logo/${stock.isin}.png" style="max-height: 100%;">
                    </div>
                    <div style="display: inline-block;">
                        <span class="stock-name">${stock.stockName}</span><br>
                        <span class="stock-isin">${stock.isin}</span>
                    </div>
                </a>
                <div class="collapse" id="sidebar${menuNames[status.index]}">
                    <ul class="side-nav-second-level">
                        <li>
                            <a href="/">커뮤니티</a>
                        </li>
                        <li>
                            <a href="/">주주제안</a>
                        </li>
                    </ul>
                </div>
            </li>
        </c:forEach>
    </c:if>

    <li class="side-nav-title side-nav-item">관심종목</li>

    <c:if test="${not empty userStocks2}">
        <c:forEach items="${userStocks2}" var="stock" varStatus="status">
            <li class="side-nav-item">
                <a data-bs-toggle="collapse" aria-expanded="false" aria-controls="sidebar${menuNames[status.index]}"
                   class="side-nav-link">
                    <div class="box">
                        <img class="profile" src="../../../resources/img/logo/${stock.isin}.png" style="max-height: 100%;">
                    </div>
                    <div style="display: inline-block;">
                        <span class="stock-name">${stock.stockName}</span><br>
                        <span class="stock-isin">${stock.isin}</span>
                    </div>
                </a>
<%--                <div class="collapse" id="sidebar${menuNames[status.index]}">--%>
<%--                    <ul class="side-nav-second-level">--%>
<%--                        <li>--%>
<%--                            <a href="/">커뮤니티</a>--%>
<%--                        </li>--%>
<%--                        <li>--%>
<%--                            <a href="/">주주제안</a>--%>
<%--                        </li>--%>
<%--                    </ul>--%>
<%--                </div>--%>
            </li>
        </c:forEach>
    </c:if>

</ul>


<!-- Help Box
<div class="help-box help-box-light text-center">
    <a href="javascript: void(0);" class="float-end close-btn text-body">
        <i class="mdi mdi-close"></i>
    </a>
    <img src="../../../resources/assets/images/help-icon.svg" height="90" alt="Helper Icon Image"/>
    <h5 class="mt-3">Unlimited Access</h5>
    <p class="mb-3">Upgrade to plan to get access to unlimited reports</p>
    <a href="javascript: void(0);" class="btn btn-outline-primary btn-sm">Upgrade</a>
</div>
end Help Box -->

<!-- End Sidebar -->


<script src="../../../resources/js/sidebar.js"></script>
</body>
</html>
