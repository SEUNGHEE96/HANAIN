<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Random" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <!-- Add to the head of your HTML -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.theme.default.min.css">
    <style>
        .pagination {
            padding-top: 15px;
            justify-content: center;
        }

        .btn-success {
            background-color: #008485 !important;
            border-color: #008485 !important;
        }

        .btn-danger {
            background-color: #E90061 !important;
            border-color: #E90061 !important;
        }

        .rounded-pill {
            margin-top: 20px;
        }

        .owl-carousel .owl-item img {
            display: block;
            width: 20%;
            height: auto;
            border-radius: 50%;
        }

        .carousel-control-prev, .carousel-control-next {
            width: auto;
            position: absolute;
            top: 50%;
        }

        .carousel-control-prev {
            left: -12% !important;
        }

        .carousel-control-next {
            right: -12% !important;
        }

        .form-control {
            padding: .45rem .9rem !important;
            height: auto !important;
        }

        #custom-accordion-one .card {
            margin-top: 0 !important;
        }

        #custom-accordion-one .card-body {
            color: black;
            font-size: 0.8rem;
        }

        .custom-accordion-title {
            font-size: 0.8rem;
        }

        .clickable {
            cursor: pointer;
        }

        .clickable.selected {
            border: 4px solid #008485;
        }
    </style>
</head>

<%@ include file="../include/header.jsp" %>

<body class="loading" data-layout="detached"
      data-layout-config='{"leftSidebarCondensed":false,"darkMode":false, "showRightSidebarOnStart": true}'>

<div class="container-fluid">
    <!-- Begin page -->
    <div class="wrapper">
        <div class="content-page">
            <div class="content">

                <div class="row">
                    <div class="col-lg-5">
                        <div class="card tilebox-one">
                            <div class="card-body">
                                <img src="../../../resources/img/person/${currentUser.memberId}.jpg" class='uil uil-users-alt float-end' style="width: 70px; border-radius: 50%"/>
                                <h6 class="text-uppercase mt-0">총자산</h6>
                                <h2 class="my-2" id="active-users-count"><fmt:formatNumber value="${totalBalance}" groupingUsed="true" pattern="#,###"/>원</h2>
                                <p class="mb-0 text-muted">
                                    <span class="text-success me-2"><span
                                            class="mdi mdi-arrow-up-bold"></span> 5.27%</span>
                                    <span class="text-nowrap">지난 주 대비</span>
                                </p>
                                <button type="button" class="btn btn-success rounded-pill">거래소가기</button>
                            </div> <!-- end card-body-->
                        </div>
                    </div>

<%--                    <div class="col-lg-7">--%>
<%--                        <div class="card cta-box bg-primary text-white">--%>
<%--                            <div class="card-body">--%>
<%--                                <div class="d-flex align-items-start align-items-center">--%>
<%--                                    <div class="w-100 overflow-hidden">--%>
<%--                                        <h2 class="mt-0"><i class="mdi mdi-bullhorn-outline"></i>&nbsp;</h2>--%>
<%--                                        <h3 class="m-0 fw-normal cta-box-title">타 증권사의 계좌를 <b>마이데이터</b>를 통해 연결해보세요!--%>
<%--                                            <i class="mdi mdi-arrow-right"></i></h3>--%>
<%--                                        <button type="button" class="btn btn-danger rounded-pill">연결하기</button>--%>
<%--                                    </div>--%>
<%--                                    <img class="ms-3" src="../../../resources/img/mydata.png" width="140"--%>
<%--                                         alt="Generic placeholder image">--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <!-- end card-body -->--%>
<%--                        </div>--%>
<%--                        <!-- end card-->--%>
<%--                    </div>--%>
<%--                </div>--%>

                    <div class="col-lg-7">
                        <div class="card cta-box bg-primary text-white">
                            <div class="card-body" style="margin: 0 auto; width: 90%; height: 200px;">
                                <div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel">
                                    <div class="carousel-inner">
                                        <!-- Page 1 -->
                                        <div class="carousel-item active">
                                            <div class="d-flex align-items-start align-items-center">
                                                <div class="w-100 overflow-hidden">
                                                    <h2 class="mt-0"><i class="mdi mdi-bullhorn-outline"></i>&nbsp;</h2>
                                                    <h3 class="m-0 fw-normal cta-box-title">타 증권사의 계좌를 <b>마이데이터</b>를 통해 연결해보세요!
                                                        <i class="mdi mdi-arrow-right"></i>
                                                    </h3>
                                                    <button type="button" class="btn btn-danger rounded-pill" data-bs-toggle="modal" data-bs-target="#login-modal">연결하기</button>
                                                    <div id="login-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                                                        <div class="modal-dialog modal-dialog-centered">
                                                            <div class="modal-content">
                                                                <div class="modal-body">
                                                                    <div class="text-center mt-2 mb-4">
                                                                        <h4 style="color: black">마이데이터</h4>
                                                                    </div>
                                                                    <c:choose>
                                                                        <c:when test="${currentUser.status == 0}">
                                                                            <!-- Main Content -->
                                                                            <div id="main-content">
                                                                                <!-- ... other main content ... -->
                                                                                <div class="text-center mt-2 mb-4" style="color: black;">
                                                                                    <h4 style="padding-top: 20px">본인인증이 필요합니다</h4>
                                                                                </div>
                                                                                <div class="d-flex justify-content-center align-items-center">
                                                                                    <button type="button" class="btn btn-success rounded-pill" id="authButton" style="margin-right: 10px">본인인증 하기</button>
                                                                                    <button type="button" class="btn btn-danger rounded-pill" data-bs-dismiss="modal">닫기</button>
                                                                                </div>
                                                                            </div>

                                                                            <!-- Verification Content -->
                                                                            <div id="verification-content" style="display: none; color: black;">
                                                                                <div class="text-center mt-2 mb-4">
                                                                                    <h5>본인인증</h5>
                                                                                </div>

                                                                                <form class="ps-3 pe-3" action="#">

                                                                                    <div class="mb-3">
                                                                                        <label for="username" class="form-label">이름</label>
                                                                                        <input class="form-control" type="text" id="username" value="${currentUser.name}" readonly>
                                                                                    </div>

                                                                                    <div class="mb-3">
                                                                                        <label for="phone" class="form-label">연락처</label>
                                                                                        <input class="form-control" type="text" id="phone" value="${currentUser.phone}" readonly>
                                                                                    </div>

                                                                                    <div class="mb-3">
                                                                                        <button type="button" id="request-verification" class="btn btn-primary rounded-pill">인증 요청</button>
                                                                                        <button type="button" class="btn btn-danger rounded-pill" data-bs-dismiss="modal">닫기</button>
                                                                                    </div>

                                                                                    <div class="mb-3" id="verification-section" style="display:none;">
                                                                                        <label for="verification-code" class="form-label">인증 번호</label>
                                                                                        <input class="form-control" type="text" id="verification-code">

                                                                                        <div id="timer" style="display:none;">00:30</div>
                                                                                        <button type="button" id="submit-verification" class="btn btn-danger rounded-pill">인증 확인</button>
                                                                                        <button type="button" id="retry-verification" class="btn btn-light rounded-pill" style="display:none;">재요청</button>
                                                                                    </div>

                                                                                </form>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:when test="${currentUser.status == 1 and currentUser.ci == null}">
                                                                            <div class="text-center mt-2 mb-4" style="color: black;">
                                                                                <b>마이데이터</b> 서비스 이용을 위해 아래 약관 동의가 필요합니다.
                                                                            </div>
                                                                            <div class="accordion custom-accordion" id="custom-accordion-one">
                                                                                <div class="card mb-0">
                                                                                    <div class="card-header" id="headingFour">
                                                                                        <h5 class="m-0">
                                                                                            <input type="checkbox">
                                                                                            <a class="custom-accordion-title py-1"
                                                                                               data-bs-toggle="collapse" href="#collapseFour"
                                                                                               aria-expanded="true" aria-controls="collapseFour">
                                                                                                금융분야 마이데이터 통합인증을 위한 인증서 본인확인서비스 이용약관 <i
                                                                                                    class="mdi mdi-chevron-down accordion-arrow"></i>
                                                                                            </a>
                                                                                        </h5>
                                                                                    </div>

                                                                                    <div id="collapseFour" class="collapse"
                                                                                         aria-labelledby="headingFour"
                                                                                         data-bs-parent="#custom-accordion-one">
                                                                                        <div class="card-body">
                                                                                            본 약관은 사용자가 마이데이터 통합인증을 이용하기 위해 본인을 확인하는 인증서 서비스를 이용할 때의 권리와 의무, 책임사항 등을 정합니다.

                                                                                            서비스 제공: 본 서비스는 사용자의 본인 확인을 위해 제공되며, 인증서는 개인의 신원을 보장하기 위한 수단으로 사용됩니다.
                                                                                            서비스 이용: 사용자는 인증서를 타인에게 제공하거나, 무단으로 사용해서는 안됩니다.
                                                                                            서비스 중단: 보안 위협이나 기타 불가피한 사유로 인해 서비스를 일시 중단할 수 있습니다.
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="card mb-0">
                                                                                    <div class="card-header" id="headingFive">
                                                                                        <h5 class="m-0">
                                                                                            <input type="checkbox">
                                                                                            <a class="custom-accordion-title collapsed py-1"
                                                                                               data-bs-toggle="collapse" href="#collapseFive"
                                                                                               aria-expanded="false" aria-controls="collapseFive">
                                                                                                금융분야 마이데이터 통합인증(인증서 본인확인)을 위한 개인 정보 처리 동의 <i
                                                                                                    class="mdi mdi-chevron-down accordion-arrow"></i>
                                                                                            </a>
                                                                                        </h5>
                                                                                    </div>
                                                                                    <div id="collapseFive" class="collapse"
                                                                                         aria-labelledby="headingFive"
                                                                                         data-bs-parent="#custom-accordion-one">
                                                                                        <div class="card-body">
                                                                                            본 동의서는 마이데이터 통합인증을 이용하기 위한 개인정보의 수집, 이용에 관한 사항을 규정합니다.

                                                                                            수집하는 개인정보: 이름, 주민등록번호, 연락처 등 인증에 필요한 기본적인 정보.
                                                                                            개인정보의 이용: 수집한 개인정보는 인증서 발급, 관리, 본인확인 등의 목적으로만 사용됩니다.
                                                                                            개인정보의 보호: 모든 개인정보는 안전하게 보관하며, 불필요한 정보는 지체 없이 파기합니다.
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="card mb-0">
                                                                                    <div class="card-header" id="headingSix">
                                                                                        <h5 class="m-0">
                                                                                            <input type="checkbox">
                                                                                            <a class="custom-accordion-title collapsed py-1"
                                                                                               data-bs-toggle="collapse" href="#collapseSix"
                                                                                               aria-expanded="false" aria-controls="collapseSix">금융분야 마이데이터 통합인증(인증서 본인확인)을 위한 고유 식별 정보 수집, 이용 및 위탁 동의 <i
                                                                                                    class="mdi mdi-chevron-down accordion-arrow"></i>
                                                                                            </a>
                                                                                        </h5>
                                                                                    </div>
                                                                                    <div id="collapseSix" class="collapse" aria-labelledby="headingSix"
                                                                                         data-bs-parent="#custom-accordion-one">
                                                                                        <div class="card-body">
                                                                                            본 동의서는 마이데이터 통합인증을 위한 고유 식별 정보의 수집, 이용, 위탁에 관한 사항을 규정합니다.

                                                                                            수집 및 이용 목적: 고유 식별 정보는 사용자 인증의 신뢰도를 높이기 위해 수집 및 이용됩니다.
                                                                                            위탁: 개인정보의 처리를 위탁받은 제3자는 본 동의서의 내용을 준수해야 합니다.
                                                                                            정보의 보호: 수집된 고유 식별 정보는 안전한 방법으로 처리 및 저장됩니다.
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="d-flex justify-content-center">
                                                                                    <button type="button" id="nextButton" class="btn btn-primary rounded-pill" style="margin-right: 10px;">다음</button>
                                                                                    <button type="button" class="btn btn-danger rounded-pill" data-bs-dismiss="modal">닫기</button>
                                                                                </div>
                                                                            </div>
                                                                        </c:when>
                                                                        <c:when test="${currentUser.status == 1 and not empty currentUser.ci}">
                                                                            <div class="text-center mt-2 mb-4" style="color: black;">
                                                                                <b>연결 가능한</b> 계좌 목록
                                                                            </div>
                                                                            <div data-simplebar style="max-height: 400px; color: black;">
                                                                                <div class="row" id="stockChartList">
                                                                                </div>
                                                                            </div>
                                                                            <button id="submitSelectedAccount" class="btn btn-primary mt-3">전송</button>
                                                                        </c:when>
                                                                    </c:choose>
                                                                </div>
                                                            </div><!-- /.modal-content -->
                                                        </div><!-- /.modal-dialog -->
                                                    </div><!-- /.modal -->
                                                </div>
                                                <img class="ms-3" src="../../../resources/img/mydata.png" width="120px"
                                                     alt="Generic placeholder image" style="margin-top: 20px;">
                                            </div>
                                        </div>

                                        <!-- Page 2 -->
                                        <div class="carousel-item">
                                            <div class="d-flex align-items-start align-items-center">
                                                <div class="w-100 overflow-hidden">
                                                    <h2 class="mt-0"><i class="mdi mdi-bullhorn-outline"></i>&nbsp;</h2>
                                                    <h3 class="m-0 fw-normal cta-box-title"><b>문자 인식</b>을 이용하여 지류로 주주 인증을 진행해보세요!
                                                        <i class="mdi mdi-arrow-right"></i>
                                                    </h3>
                                                    <button type="button" class="btn btn-danger rounded-pill" data-bs-toggle="modal" data-bs-target="#signup-modal">사진업로드</button>
                                                    <div id="signup-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                                                        <div class="modal-dialog modal-dialog-centered">
                                                            <div class="modal-content">

                                                                <div class="modal-body">
                                                                    <div class="text-center mt-2 mb-4">
                                                                        <h4 id="ocrTitle" style="color: black">OCR</h4>
<%--                                                                        <a href="index.html" class="text-success">--%>
<%--                                                                            <span><img src="assets/images/logo-dark.png" alt="" height="18"></span>--%>
<%--                                                                        </a>--%>
                                                                    </div>
<%--                                                                    <form class="ps-3 pe-3" action="#">--%>
                                                                        <div class="mb-3 text-center">
                                                                            <form id="upload-form" enctype="multipart/form-data">
                                                                                <input type="file" id="file" name="file" accept="image/*" class="form-control">
                                                                                <div id="description" class="text-muted" style="text-align: left !important;">
                                                                                    주주 인증이 가능한 지류(ex 주주총회참석장)를 선택하세요.
                                                                                </div>
                                                                                <div id="result-display" style="color: black">
                                                                                    <!-- 여기에 결과 표시 -->
                                                                                </div>
                                                                                <button type="button" id="upload-button" class="btn btn-primary rounded-pill">파일 업로드</button>
                                                                            </form>
                                                                        </div>
<%--                                                                    </form>--%>

                                                                </div>
                                                            </div><!-- /.modal-content -->
                                                        </div><!-- /.modal-dialog -->
                                                    </div><!-- /.modal -->
                                                </div>
                                                <img class="ms-3" src="../../../resources/img/ocr.png" width="110px"
                                                     alt="Generic placeholder image" style="margin-top: 20px;">
                                            </div>
                                        </div>
                                    </div>
                                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>
                            </div>
                            <!-- end card-body -->
                        </div>
                        <!-- end card-->
                    </div>
                    <div class="row">
                    <div class="owl-carousel owl-theme">
                        <c:forEach items="${accountlist}" var="account">
                            <%
                                Random random = new Random();
                                int randomValue = random.nextInt(21) - 10; // -10부터 +10까지의 랜덤 값을 생성
                                pageContext.setAttribute("randomValue", randomValue); // JSTL 변수로 저장
                            %>
                            <div class="item">
                                <div class="card tilebox-one">
                                    <div class="card-body">

                                        <c:choose>
                                            <c:when test="${account.accountNumber == '1000000000'}">
                                                <img src="../../../resources/img/company/${account.company}.png"
                                                     class="dripicons-basket float-end text-muted">
                                                <h6 class="text-muted text-uppercase mt-0">${account.company} : 지류인증</h6>
                                                <h2 class="m-b-20">지류인증</h2>
                                                <c:set var="badgeClass" value="${randomValue > 0 ? 'bg-primary' : 'bg-danger'}"/>
                                                <span class="badge ${badgeClass}"> ${randomValue}% </span>
<%--                                                <span class="text-muted">Since last week</span>--%>
                                                <a href="/mybalance/${account.accountNumber}" style="float: right">→</a>
                                            </c:when>
                                            <c:otherwise>
                                                <img src="../../../resources/img/company/${account.company}.png"
                                                     class="dripicons-basket float-end text-muted">
                                                <h6 class="text-muted text-uppercase mt-0">${account.company} : <a href="/mybalance/${account.accountNumber}">${account.accountNumber}</a></h6>
                                                <h2 class="m-b-20"><fmt:formatNumber value="${account.cash}" groupingUsed="true" pattern="#,###"/>원</h2>
                                                <c:set var="badgeClass" value="${randomValue > 0 ? 'bg-primary' : 'bg-danger'}"/>
                                                <span class="badge ${badgeClass}"> ${randomValue}% </span>
                                                <span class="text-muted">지난 주 대비</span>
                                                <a href="/mybalance/${account.accountNumber}" style="float: right">→</a>
                                            </c:otherwise>
                                        </c:choose>

                                    </div> <!-- end card-body-->
                                </div> <!--end card-->
                            </div>
                        </c:forEach>
                        <script>
                            var renderedAccountNumbers = [];
                            <c:forEach items="${accountlist}" var="account">
                            renderedAccountNumbers.push('${account.accountNumber}');
                            </c:forEach>
                        </script>
                    </div>
                    <!-- end row -->
                </div>
                    <div class="row">
                        <div class="col-lg-7">
                            <div class="card">
                                <div class="card-body">
                                    <a href="" class="btn btn-sm btn-link float-end">내보내기
                                        <i class="mdi mdi-download ms-1"></i>
                                    </a>
                                    <h4 class="header-title mt-2 mb-3">거래내역</h4>

                                    <div class="table-responsive">
                                        <table class="table table-centered table-nowrap table-hover mb-0">
                                            <tbody>
                                            <c:forEach items="${tradelist}" var="trade">
                                            <tr>
                                                <td>
                                                    <h5 class="font-14 my-1 fw-normal">${trade.isin}</h5>
                                                    <span class="text-muted font-13">${trade.tradeDate}</span>
                                                </td>
                                                <td>
                                                    <h5 class="font-14 my-1 fw-normal">${trade.price}</h5>
                                                    <span class="text-muted font-13">가격</span>
                                                </td>
                                                <td>
                                                    <h5 class="font-14 my-1 fw-normal">${trade.quantity}</h5>
                                                    <span class="text-muted font-13">수량</span>
                                                </td>
                                                <td>
                                                    <h5 class="font-14 my-1 fw-normal">${trade.price * trade.quantity}</h5>
                                                    <span class="text-muted font-13">총액</span>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div> <!-- end table-responsive-->
                                    <ul class="pagination pagination-rounded mb-0" id="paging">
                                        <li class="page-item">
                                            <a class="page-link" href="javascript: void(0);" aria-label="Previous">
                                                <span aria-hidden="true">&laquo;</span>
                                            </a>
                                        </li>
                                        <c:forEach var="i" begin="1" end="${totalPages}">
                                            <c:choose>
                                                <c:when test="${i == currentPage}">
                                                    <li class="page-item active"><a class="page-link" href="javascript: void(0);">${i}</a></li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="page-item"><a class="page-link" href="/mybalance?page=${i}">${i}</a></li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <li class="page-item">
                                            <a class="page-link" href="javascript: void(0);" aria-label="Next">
                                                <span aria-hidden="true">&raquo;</span>
                                            </a>
                                        </li>
                                    </ul>
                                </div> <!-- end card-body-->
                            </div> <!-- end card-->
                        </div>
                        <!-- end col-->

                        <div class="col-lg-5">
                            <div class="card">
                                <div class="card-body">
                                    <div class="dropdown float-end">
                                        <a href="#" class="dropdown-toggle arrow-none card-drop"
                                           data-bs-toggle="dropdown"
                                           aria-expanded="false">
                                            <i class="mdi mdi-dots-vertical"></i>
                                        </a>
                                        <div class="dropdown-menu dropdown-menu-end">
                                            <!-- item-->
                                            <a href="javascript:void(0);" class="dropdown-item">Today</a>
                                            <!-- item-->
                                            <a href="javascript:void(0);" class="dropdown-item">Yesterday</a>
                                            <!-- item-->
                                            <a href="javascript:void(0);" class="dropdown-item">Last Week</a>
                                            <!-- item-->
                                            <a href="javascript:void(0);" class="dropdown-item">Last Month</a>
                                        </div>
                                    </div>

                                    <h4 class="header-title mb-1">보유내역</h4>

                                    <div class="row text-center mt-2">
                                        <div class="col-sm-4">
                                            <i class="mdi mdi-send widget-icon rounded-circle bg-light-lighten text-muted"></i>
                                            <h3 class="fw-normal mt-3">
                                                <span>${accountlist.size()} 개</span>
                                            </h3>
                                            <p class="text-muted mb-0 mb-2"><i
                                                    class="mdi mdi-checkbox-blank-circle text-warning"></i>보유 계좌 수
                                            </p>
                                        </div>
                                        <div class="col-sm-4">
                                            <i class="mdi mdi-flag-variant widget-icon rounded-circle bg-light-lighten text-muted"></i>
                                            <h3 class="fw-normal mt-3">
                                                <span>${balancelist.size()} 개</span>
                                            </h3>
                                            <p class="text-muted mb-0 mb-2"><i
                                                    class="mdi mdi-checkbox-blank-circle text-primary"></i>보유 주식 수</p>
                                        </div>
                                        <div class="col-sm-4">
                                            <i class="mdi mdi-email-open widget-icon rounded-circle bg-light-lighten text-muted"></i>
                                            <h3 class="fw-normal mt-3">
                                                <span>${thisMonthTradeCount} 건</span>
                                            </h3>
                                            <p class="text-muted mb-0 mb-2"><i
                                                    class="mdi mdi-checkbox-blank-circle text-success"></i>당월 거래</p>
                                        </div>
                                    </div>

                                    <div dir="ltr">
                                        <div class="donut-container text-center" style="width: 100%;" data-colors2="#536de6,#10c469,#6c757d,#ff5b5b,#f9c851,#39afd1"></div>
                                        <div class="legend-chart-container text-center"></div>
                                    </div>

                                </div>
                                <!-- end card body-->
                            </div>
                            <!-- end card -->
                        </div>
                        <!-- end col-->
                    </div>
                    <!-- end row-->
                </div> <!-- End Content -->
            </div> <!-- content-page -->
        </div> <!-- end wrapper-->
    </div>
    <!-- END Container -->
</div>

<%@ include file="../include/footer.jsp" %>

<script src="../../../resources/assets/js/vendor/Chart.bundle.min.js"></script>
<script src="../../../resources/assets/js/pages/demo.profile.js"></script>

<!-- third party:js -->
<script src="../../../resources/assets/js/vendor/d3.min.js"></script>
<script src="../../../resources/assets/js/vendor/britecharts.min.js"></script>
<!-- third party end -->

<!-- demo:js -->
<script src="../../../resources/assets/js/pages/demo.britechart.js"></script>

<!-- Add before the end of your body tag -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>

<script>
    $(document).ready(function(){
        // 계좌들 슬라이드
        $(".owl-carousel").owlCarousel({
            loop: true,
            margin: 10,
            responsiveClass: true,
            responsive:{
                0:{
                    items:1,
                    nav:true
                },
                600:{
                    items:3,
                    nav:false
                },
                1000:{
                    items:4,
                    loop:false
                }
            }
        });

        // 주식 보유 내역 파이 차트
        $(".donut-container").empty();
        $(".legend-chart-container").empty();

        var totalStockPrice = ${totalStockPrice};

        var balanceData = [
            <c:forEach var="balance" items="${balancelist}" varStatus="loop">
            {
                "accountId": parseInt("${balance.accountId}"),
                "isin": "${balance.isin}",
                "gradeId": "${balance.gradeId}",
                "quantity": parseFloat("${balance.quantity}"),
                "averagePrice": parseFloat("${balance.averagePrice}")
            }<c:if test="${not loop.last}">,</c:if>
            </c:forEach>
        ];

        // 6개 이상인 경우 others로 합산 처리
        if (balanceData.length > 6) {
            let othersQuantity = 0;
            for (let i = 5; i < balanceData.length; i++) {
                othersQuantity += (balanceData[i].quantity * balanceData[i].averagePrice);
            }

            let othersPercentage = parseFloat(Math.floor((othersQuantity / totalStockPrice) * 100).toFixed(1));

            // 필요한 항목만 잘라냅니다.
            balanceData = balanceData.slice(0, 5);

            balanceData.push({
                name: "others",
                quantity: othersQuantity,
                percentage: othersPercentage
            });
        }

        var donutData = balanceData.map(function(balance, index) {
            return {
                name: balance.name || balance.isin,  // 여기서 이름을 가져옵니다.
                id: index + 1,
                quantity: balance.quantity * (balance.averagePrice || 1),
                percentage: parseFloat(Math.floor(((balance.quantity * (balance.averagePrice || 1)) / totalStockPrice) * 100).toFixed(1))
            };
        });

        console.log(donutData);

        if (jQuery(".donut-container").length > 0) {
            briteChartApp.createDonutChart(".donut-container", donutData);
        }

        // OCR
        $('#upload-button').on('click', function() {
            // 기존 업로드 버튼과 input file 숨기기
            $('#upload-button').hide();
            $('#file').hide();
            $('#description').hide();

            $('.modal-body').append('<div class="spinner-border text-success" role="status" id="spinner" style="display: flex; margin: 0 auto;"></div>');

            var form = $('#upload-form')[0];
            var data = new FormData(form);

            $.ajax({
                type: "POST",
                enctype: 'multipart/form-data',
                url: "/naverOcr",
                data: data,
                processData: false,
                contentType: false,
                cache: false,
                success: function(response) {
                    // 로딩이 끝났으므로 Spinner 제거
                    $('#spinner').remove();
                    $('#spinner').css('display', 'none');

                    // 모달에 결과를 표시
                    $('ocrTitle').val('OCR 결과');
                    $('#result-display').empty();
                    response.forEach(function(item, index) {
                        $('#result-display').append((index +1)+ ' : ' + item + '<br>');
                    });

                    // 결과 전송 및 재업로드 버튼 동적 생성
                    let sendButton = $('<button type="button" id="send-button" class="btn btn-success rounded-pill">결과 전송</button>');
                    let reuploadButton = $('<button type="button" id="reupload-button" class="btn btn-danger rounded-pill" style="margin-left: 20px">재업로드</button>');

                    // 버튼에 이벤트 핸들러 추가
                    sendButton.on('click', function() {
                        $.ajax({
                            type: "POST",
                            url: "/ocrResult",
                            data: JSON.stringify(response),
                            contentType: "application/json; charset=utf-8",
                            success: function(response) {
                                // 모달 닫기
                                $('#signup-modal').modal('hide');
                                console.log(response);
                            },
                            error: function(err) {
                                console.log('결과 전송 실패');
                                // 모달 닫기
                                $('#signup-modal').modal('hide');
                            }
                        });
                    });

                    reuploadButton.on('click', function() {
                        // input 태그를 비운 후, 사용자가 다시 파일을 선택하게 함
                        $('#file').val('');

                        // 업로드 버튼과 input file 다시 보이게 하기
                        $('#upload-button').show();
                        $('#file').show();
                        $('#description').show();
                        $('#result-display').empty();

                        // 결과 전송 및 재업로드 버튼 제거
                        $('#send-button').remove();
                        $('#reupload-button').remove();
                    });

                    // 버튼을 모달에 추가
                    $('#result-display').after(sendButton, reuploadButton);
                },
                error: function(error) {
                    // 에러가 발생하였으므로 Spinner 제거
                    $('#spinner').remove();
                    alert('인증 요청 실패');
                }
            });
        });

        // 슬라이드 돌아갈때 모달 유지하기
        $('#signup-modal').on('show.bs.modal', function() {
            $('#carouselExampleControls').carousel('pause');
        });

        $('#signup-modal').on('hidden.bs.modal', function() {
            $('#carouselExampleControls').carousel('cycle');
        });

        $('#login-modal').on('show.bs.modal', function() {
            $('#carouselExampleControls').carousel('pause');
        });

        $('#login-modal').on('hidden.bs.modal', function() {
            $('#carouselExampleControls').carousel('cycle');
        });
    });

    // authButton이 존재하는지 체크합니다.
    var authButton = document.getElementById('authButton');
    if (authButton) {
        authButton.addEventListener('click', function() {
            // Hide main content
            document.getElementById('main-content').style.display = 'none';

            // Show verification content
            document.getElementById('verification-content').style.display = 'block';
        });
    }

    document.getElementById('login-modal').addEventListener('hidden.bs.modal', function() {
        // 모달 초기화 로직을 여기에 작성합니다.

        var main_content = document.getElementById('main-content');
        if (main_content) {
            // 예를 들면, "본인인증 하기" 버튼을 보이게 하고, 본인인증 관련 내용을 숨깁니다.
            document.getElementById('main-content').style.display = 'block';
            document.getElementById('verification-content').style.display = 'none';
        }
    });

    // 본인 인증 관련 코드
    $('#request-verification').on('click', function() {
        $.ajax({
            url: '/request-verification',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                username: $('#username').val(),
                phone: $('#phone').val()
            }),
            success: function(response) {
                $('#verification-section').show();
            },
            error: function(error) {
                alert('인증 요청 실패');
            }
        });

        // 인증번호 입력칸과 타이머를 보이게 합니다.
        $('#verification-section').show();
        $('#timer').show();
        $('#verification-code').prop('disabled', false); // 입력칸을 활성화합니다.
        $('#retry-verification').hide(); // 재요청 버튼을 숨깁니다.

        // 30초 타이머 시작
        let duration = 30; // 30초
        let display = $('#timer');
        startTimer(duration, display);
    });

    // 타이머 시작 함수
    function startTimer(duration, display) {
        let timer = duration, seconds;
        let intervalId = setInterval(function () {
            seconds = parseInt(timer % 60, 10);
            seconds = seconds < 10 ? "0" + seconds : seconds;

            display.text("00:" + seconds);

            if (--timer < 0) {
                timer = duration;

                // 시간이 다 되면 타이머를 멈추고, 입력 칸을 비활성화합니다. 재요청 버튼을 보이게 합니다.
                clearInterval(intervalId);
                $('#verification-code').prop('disabled', true);
                $('#retry-verification').show();
                alert("인증 시간이 초과되었습니다.");
            }
        }, 1000);
    }

    $('#retry-verification').on('click', function() {
        $.ajax({
            url: '/request-verification',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                username: $('#username').val(),
                phone: $('#phone').val()
            }),
            success: function (response) {
                $('#verification-section').show();
            },
            error: function (error) {
                alert('인증 요청 실패');
            }
        });
    });

    $('#submit-verification').on('click', function() {
        $.ajax({
            url: '/verify-code',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                username: $('#username').val(),
                code: $('#verification-code').val(),
                phone: $('#phone').val()
            }),
            success: function (response) {
                alert('인증 성공');
                $('#signup-modal').modal('hide'); // 모달 닫기
                location.reload();
            },
            error: function (error) {
                alert('인증 실패');
                $('#signup-modal').modal('hide'); // 모달 닫기
                location.reload();
            }
        });
    });

    document.addEventListener("DOMContentLoaded", function() {
        const checkboxes = document.querySelectorAll('.custom-accordion input[type="checkbox"]');
        const nextButton = document.getElementById('nextButton');

        // JSP에서 받아온 값
        const identification = '${currentUser.identification}';

        function areAllChecked() {
            for (let checkbox of checkboxes) {
                if (!checkbox.checked) {
                    return false; // 하나라도 체크되지 않았으면 false를 반환합니다.
                }
            }
            return true; // 모든 체크박스가 체크되면 true를 반환합니다.
        }

        nextButton.addEventListener('click', function() {
            if (!areAllChecked()) {
                alert('체크해주세요');
            } else {
                callAPI('getCIByAPI', identification);
                alert('마이데이터를 위한 CI를 발급받았습니다.');
                location.reload();
            }
        });
    });

    // 모달이 열릴 때의 이벤트를 추가합니다.
    $('#login-modal').on('show.bs.modal', function() {
        const ci = '${currentUser.ci}';
        console.log(ci);

        if (ci !== '') {
            callAPI('getAccountByAPI', ci);
        }
    });

    function bindCardEvents() {
        $(".clickable").off('click').click(function(){  // 기존의 이벤트 리스너를 제거하고 새로운 리스너를 추가
            console.log("Card clicked!");
            $(this).toggleClass("selected");
        });
    }

    function callAPI(request, input) {
        let xhr = new XMLHttpRequest();
        let url = "http://localhost:8090/" + request + "/" + input;

        xhr.open('POST', url, true);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                let response = JSON.parse(xhr.responseText);
                if (response.state === "OK") {
                    console.log(response.data);

                    // 추가된 로직: 만약 API가 getAccountByAPI라면 계좌 정보를 HTML로 그립니다.
                    if (request === 'getAccountByAPI') {
                        let accountListHtml = generateAccountCardHtml(response.data);
                        $('#stockChartList').html(accountListHtml);

                        // 함수 호출 후에 이벤트 리스너를 바인딩
                        bindCardEvents();
                    }

                    // 데이터를 서버로 전송
                    sendDataToServer(response.data, request);
                } else {
                    alert('API 호출 실패.');
                }
            }
        };
        xhr.send();
    };

    function sendDataToServer(data, endpoint) {
        var xhrSend = new XMLHttpRequest();
        var urlSend = "http://localhost:8080/" + endpoint;

        xhrSend.open('POST', urlSend, true);
        xhrSend.setRequestHeader("Content-Type", "application/json;charset=UTF-8"); // JSON 형식으로 전송하기 위한 헤더 설정

        xhrSend.onreadystatechange = function() {
            if (xhrSend.readyState == 4 && xhrSend.status == 200) {
                console.log('데이터 전송 성공!');
            }
        };

        xhrSend.send(JSON.stringify(data)); // 데이터를 JSON 문자열로 변환하여 전송
    };


    // "전송" 버튼 클릭 이벤트
    $("#submitSelectedAccount").click(function(){
        let selectedAccounts = [];

        $(".selected").each(function(){
            let accountInfo = {
                company: $(this).find("h5.mb-1.mt-0").text(),
                accountNumber: $(this).find("p:nth-child(2)").text().replace('계좌번호 : ', ''),
                cash: $(this).find("p.mb-0.text-muted b").text().replace('현금 : ', ''),
                balances: []
            };

            // Getting balances for the selected account
            $(this).find(".balances div").each(function(){
                accountInfo.balances.push({
                    isin: $(this).data('isin'),
                    quantity: $(this).data('quantity'),
                    averagePrice: $(this).data('averageprice')
                });
            });

            selectedAccounts.push(accountInfo);
        });

        // 선택된 계좌 정보를 controller에 전송
        $.ajax({
            type: "POST",
            url: "/submitAccount",
            data: JSON.stringify(selectedAccounts),
            contentType: "application/json",
            success: function(response){
                // 성공 시 응답 처리
                console.log(response);
                alert('계좌 등록 완료하였습니다.');
                $('#login-modal').modal('hide'); // 모달 닫기
                location.reload();
            },
            error: function(error){
                // 오류 시 처리
                console.log(error);
            }
        });
    });
</script>
<script src="../../../resources/js/mybalance.js"></script>
</body>
</html>
