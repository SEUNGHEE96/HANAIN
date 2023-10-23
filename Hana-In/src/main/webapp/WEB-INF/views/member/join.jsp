<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        #logo-bg {
            background-color: #89BEBE !important;
        }
    </style>
</head>
<body>

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
                            <h4 class="text-dark-50 text-center mt-0 fw-bold">회원가입</h4>
                            <p class="text-muted mb-4">계정이 없으신가요?<br/>하나인 서비스에 가입해보세요!</p>
                        </div>

                        <form action="#">

                            <div class="mb-3">
                                <label for="memberId" class="form-label">아이디</label>
                                <input class="form-control" type="text" id="memberId" placeholder="아이디를 입력하세요" required>
                            </div>

                            <div class="mb-3">
                                <label for="fullname" class="form-label">이름</label>
                                <input class="form-control" type="text" id="fullname" placeholder="이름을 입력하세요" required>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label">비밀번호</label>
                                <div class="input-group input-group-merge">
                                    <input type="password" id="password" class="form-control" placeholder="비밀번호를 입력하세요">
                                    <div class="input-group-text" data-password="false">
                                        <span class="password-eye"></span>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="emailaddress" class="form-label">이메일</label>
                                <input class="form-control" type="email" id="emailaddress" required placeholder="이메일을 입력하세요">
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label">연락처</label>
                                <input class="form-control" type="email" id="phone" required placeholder="연락처를 입력하세요">
                            </div>

                            <div class="mb-3">
                                <label for="address" class="form-label">주소</label>
                                <input class="form-control" type="email" id="address" required placeholder="주소를 입력하세요">
                            </div>

                            <div class="mb-3">
                                <div class="form-check">
                                    <input type="checkbox" class="form-check-input" id="checkbox-signup">
                                    <label class="form-check-label" for="checkbox-signup"><a href="#" class="text-muted">이용약관</a>에 동의합니다</label>
                                </div>
                            </div>

                            <div class="mb-3 text-center">
                                <button class="btn btn-primary" type="submit">회원가입</button>
                            </div>

                        </form>
                    </div> <!-- end card-body -->
                </div>
                <!-- end card -->

                <div class="row mt-3">
                    <div class="col-12 text-center">
                        <p class="text-muted">이미 계정이 있으신가요?<a href="/login" class="text-muted ms-1"><b>로그인</b></a></p>
                    </div> <!-- end col-->
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