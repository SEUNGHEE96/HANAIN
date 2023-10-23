<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link rel="icon" href="../../../resources/img/logo.png" type="image/png">
    <title>HANAIN</title>

    <!-- App css -->
    <link href="../../../resources/assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <link href="../../../resources/assets/css/app-modern.min.css" rel="stylesheet" type="text/css" id="light-style" />

    <link rel="stylesheet" href="../../../resources/css/maicons.css">
    <link rel="stylesheet" href="../../../resources/vendor/animate/animate.css">
    <link rel="stylesheet" href="../../../resources/css/theme.css">

    <script src="../../../resources/js/jquery-3.5.1.min.js"></script>
</head>
<body>

<!-- Back to top button -->
<div class="back-to-top"></div>

<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-white sticky" data-offset="500">
        <div class="container">
            <!-- 로고 -->
            <a href="/" class="navbar-brand">
                <img src="../../../resources/img/logo.png" alt="Logo" class="logo-img">
                HANA<span class="text-primary">IN</span>
            </a>

            <!-- 오른쪽 영역 -->
            <div class="ml-auto d-flex flex-column align-items-end">
                <!-- 로그인 및 마이페이지 링크 -->
                <div class="navbar-login-links mb-2">
                    <c:if test="${empty currentUser }">
                        <a href="${pageContext.request.contextPath }/login" class="login-link">로그인</a>
                        <a href="${pageContext.request.contextPath }/join" class="mypage-link" >회원가입</a>
                    </c:if>
                    <c:if test="${not empty currentUser }">
                        ${currentUser.name }님 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                        <a href="${pageContext.request.contextPath }/mypage" class="login-link">내정보</a>
                        <a href="${pageContext.request.contextPath }/mybalance" class="login-link">잔고</a>
                        <a href="${pageContext.request.contextPath }/logout" class="mypage-link">로그아웃</a>
                    </c:if>
                </div>

                <!-- 토글 버튼 및 네비게이션 메뉴 -->
                <div class="nav-container">
                    <button class="navbar-toggler" data-toggle="collapse" data-target="#navbarContent"
                            aria-controls="navbarContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="navbar-collapse collapse" id="navbarContent">
                        <ul class="navbar-nav">
                            <li class="nav-item active">
                                <a class="nav-link" href="/about">서비스소개</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/stockinfo">기업정보</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/stock">거래소</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/chat">채팅</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/board">커뮤니티</a>
                            </li>
                            <li class="nav-item">
                                <a class="btn btn-primary ml-lg-2" href="/proposal">주주제안</a>
                            </li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </nav>
</header>

</body>
</html>