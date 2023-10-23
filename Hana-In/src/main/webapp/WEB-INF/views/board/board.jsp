<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
</head>
<body class="loading" data-layout="detached"
      data-layout-config='{"leftSidebarCondensed":false,"darkMode":false, "showRightSidebarOnStart": true}'>

<script src="../../../resources/js/jquery-3.5.1.min.js"></script>
<script src="../../../resources/js/bootstrap.bundle.min.js"></script>
<script>
    // This will initialize all popovers
    var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
    var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
        return new bootstrap.Popover(popoverTriggerEl)
    })
</script>

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
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row mb-2">
                                    <div class="col-sm-5">
                                        <a href="javascript:void(0);" class="btn btn-danger mb-2"><i
                                                class="mdi mdi-plus-circle me-2"></i>새 게시물 작성</a>
                                    </div>
                                    <div class="col-sm-7">
                                        <div class="text-sm-end">
                                            <button type="button" class="btn btn-success mb-2 me-1">
<%--                                                <i class="mdi mdi-cog-outline"></i>--%>
                                                전체보기
                                            </button>
                                            <button type="button" class="btn btn-light mb-2 me-1">보유종목</button>
                                            <button type="button" class="btn btn-light mb-2">관심종목</button>
                                        </div>
                                    </div><!-- end col-->
                                </div>

                                <div class="table-responsive">
                                    <table class="table table-centered w-100 dt-responsive nowrap"
                                           id="products-datatable">
                                        <thead class="table-light">
                                        <tr>
                                            <th class="all">제목</th>
                                            <th>작성자</th>
                                            <th>작성일</th>
                                            <th>평균단가</th>
                                            <th>보유수량</th>
                                            <th>조건</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${boardlist}" var="board">
                                        <tr>
                                            <td>
                                                <img src="../../../resources/img/logo/${board.isin}.png" alt="contact-img"
                                                     title="contact-img" class="rounded me-3" height="48"/>
                                                <p class="m-0 d-inline-block align-middle font-16">
                                                    <span style="color: grey; font-size: 0.8rem">${board.stockDTO.stockName}</span>
                                                    <br/>
                                                    <a href="${pageContext.request.contextPath}/board/${board.boardId }" class="text-body">${board.title}</a>
                                                </p>
                                            </td>
                                            <td>
                                                <p class="m-0 d-inline-block align-middle font-16">
<%--                                                    ${board.memberId}--%>

                                                    <!-- 회원 아이디 버튼 -->
                                                    <button type="button"
                                                            data-bs-container="body"
                                                            data-bs-toggle="popover"
                                                            data-bs-placement="right"
                                                            data-bs-html="true"
                                                            data-bs-content='<a href="/chatWithMember?memberId=${board.memberId}">채팅하기</a>'
                                                            style="color: black; background-color: transparent; border: transparent;">
                                                            ${board.memberId}
                                                    </button>

                                                    <br/>
                                                    <c:forEach var="i" begin="1" end="5">
                                                        <c:choose>
                                                            <c:when test="${board.balanceDTO != null and board.balanceDTO.gradeId >= i+1}">
                                                                <span class="text-warning mdi mdi-star"></span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-warning mdi mdi-star-outline"></span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </p>
                                            </td>
                                            <td>
                                                ${board.regDate}
                                            </td>
                                            <td>
                                                ${board.balanceDTO.averagePrice}
                                            </td>

                                            <td>
                                                ${board.balanceDTO.quantity}
                                            </td>
                                            <td>
                                            <c:choose>
                                                <c:when test="${board.status == 0}">
                                                    <span class="badge bg-success">전체</span>
                                                </c:when>
                                                <c:when test="${board.status == 1}">
                                                    <span class="badge bg-warning">주주만</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">등급제</span>
                                                </c:otherwise>
                                            </c:choose>
                                            </td>
                                        </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div> <!-- end card-body-->
                        </div> <!-- end card-->
                    </div> <!-- end col -->
                </div>
                <!-- end row -->
            </div>
            <!-- content -->
        </div>
        <!-- content-page -->
    </div>
    <!-- end wrapper-->
</div>
<!-- END Container -->

<%@ include file="../include/footer.jsp" %>

<script>
    function startChat() {
        alert('채팅을 시작합니다.');
    }
</script>
</body>
</html>
