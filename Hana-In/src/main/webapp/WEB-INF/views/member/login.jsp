<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        #logo-bg {
            background-color: #89BEBE !important;
        }
    </style>
</head>

<%@ include file="../include/header.jsp" %>

<body class="loading authentication-bg" data-layout-config='{"darkMode":false}'>
<div class="account-pages pt-2 pt-sm-5 pb-4 pb-sm-5">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-xxl-4 col-lg-5">
                <div class="card">

                    <!-- Logo -->
                    <div class="card-header pt-4 pb-4 text-center bg-primary" id="logo-bg">
                        <a href="/">
                            <span><img src="../../../resources/img/logo2.png" alt="" height="70"></span>
                        </a>
                    </div>

                    <div class="card-body p-4">

                        <div class="text-center w-75 m-auto">
                            <h4 class="text-dark-50 text-center mt-0 fw-bold">로그인</h4>
                            <p class="text-muted mb-4">아이디와 비밀번호를 입력하세요!</p>
                        </div>

                        <form:form modelAttribute="loginDTO" action="/login" method="post">

                            <div class="mb-3">
                                <label for="memberId" class="form-label">아이디</label>
                                <form:input path="memberId" class="form-control" type="text" id="memberId" required="required" placeholder="아이디를 입력하세요" />
                                <form:errors path="memberId" cssStyle="color: red;" />
                            </div>

                            <div class="mb-3">
                                <a href="pages-recoverpw.html" class="text-muted float-end"><small>비밀번호를 잊어버렸나요?</small></a>
                                <label for="password" class="form-label">비밀번호</label>
                                <div class="input-group input-group-merge">
                                    <form:password path="password" id="password" class="form-control" placeholder="비밀번호를 입력하세요" />
                                    <div class="input-group-text" data-password="false">
                                        <span class="password-eye"></span>
                                    </div>
                                    <form:errors path="password" cssStyle="color: red;" />
                                </div>
                            </div>

                            <div class="mb-3">
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="checkbox-signin">
                                    <label class="form-check-label" for="checkbox-signin">아이디 저장하기</label>
                                </div>
                            </div>

                            <div class="mb-3 text-center">
                                <button class="btn btn-primary" type="submit">로그인</button>
                            </div>

                        </form:form>
                    </div> <!-- end card-body -->
                </div>
                <!-- end card -->

                <div class="row mt-3">
                    <div class="col-12 text-center">
                        <p class="text-muted">계정이 없으신가요?<a href="/join" class="text-muted ms-1"><b>회원가입</b></a></p>
                    </div> <!-- end col -->
                </div>
                <!-- end row -->

            </div> <!-- end col -->
        </div>
        <!-- end row -->
    </div>
    <!-- end container -->
</div>
<!-- end page -->

<!-- bundle -->
<script src="../../../resources/assets/js/vendor.min.js"></script>
<script src="../../../resources/assets/js/app.min.js"></script>

<script src="../../../resources/js/bootstrap.bundle.min.js"></script>
<script src="../../../resources/js/google-maps.js"></script>
<script src="../../../resources/vendor/wow/wow.min.js"></script>
<script src="../../../resources/js/theme.js"></script>

</body>
</html>