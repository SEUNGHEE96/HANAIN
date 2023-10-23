<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        .pagination {
            padding-top: 15px;
            justify-content: center;
        }
        #proposal_stockName {
            margin-bottom: 15px;
        }
        .truncated-content {
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: N; /* N은 원하는 줄 수, 예: 3이면 3줄만 표시 */
            -webkit-box-orient: vertical;
        }
    </style>
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

                    <div class="row mb-2">
                        <div class="col-sm-4">
                            <a href="/writeproposal" class="btn btn-danger rounded-pill mb-3"><i class="mdi mdi-plus"></i>새 주주제안 작성</a>
                        </div>
                        <div class="col-sm-8">
                            <div class="text-sm-end">
                                <div class="btn-group mb-3">
                                    <button type="button" class="btn btn-primary">전체보기</button>
                                </div>
                                <div class="btn-group mb-3 ms-1">
                                    <button type="button" class="btn btn-light">진행중</button>
                                    <button type="button" class="btn btn-light">마감완료</button>
                                </div>
                                <div class="btn-group mb-3 ms-2 d-none d-sm-inline-block">
                                    <button type="button" class="btn btn-secondary"><i class="dripicons-view-apps"></i></button>
                                </div>
                                <div class="btn-group mb-3 d-none d-sm-inline-block">
                                    <button type="button" class="btn btn-link text-muted"><i class="dripicons-checklist"></i></button>
                                </div>
                            </div>
                        </div><!-- end col-->
                    </div>
                    <!-- end row-->

                    <div class="row">

                        <c:forEach items="${proposallist}" var="proposal">

                            <div class="col-xxl-4">
                                <!-- project card -->
                                <div class="card d-block">
                                    <div class="card-body">
                                        <div class="dropdown card-widgets">
                                            <a href="#" class="dropdown-toggle arrow-none" data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="dripicons-dots-3"></i>
                                            </a>
                                            <div class="dropdown-menu dropdown-menu-end">
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item"><i class="mdi mdi-pencil me-1"></i>Edit</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item"><i class="mdi mdi-delete me-1"></i>Delete</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item"><i class="mdi mdi-email-outline me-1"></i>Invite</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item"><i class="mdi mdi-exit-to-app me-1"></i>Leave</a>
                                            </div>
                                        </div>

                                        <div id="proposal_stockName">
                                            <img src="../../../resources/img/logo/${proposal.isin}.png" alt="logo" style="width: 35px; height: 35px; border-radius: 50%">
                                            ${proposal.stockDTO.stockName}(${proposal.isin})
                                            <c:choose>
                                                <c:when test="${proposal.status == 1}">
                                                    <div class="badge bg-secondary mb-3">마감완료</div>
                                                </c:when>
                                                <c:when test="${proposal.status == 0}">
                                                    <div class="badge bg-success text-light mb-3">진행중</div>
                                                </c:when>
                                            </c:choose>
                                        </div>

                                        <!-- project title-->
                                        <h4 class="mt-0">
                                            <a href="${pageContext.request.contextPath}/proposal/${proposal.proposalId }" class="text-title">${proposal.title}</a>
                                        </h4>

<%--                                        <c:choose>--%>
<%--                                            <c:when test="${proposal.status == 1}">--%>
<%--                                                <div class="badge bg-secondary mb-3">마감완료</div>--%>
<%--                                            </c:when>--%>
<%--                                            <c:when test="${proposal.status == 0}">--%>
<%--                                                <div class="badge bg-success text-light mb-3">진행중</div>--%>
<%--                                            </c:when>--%>
<%--                                        </c:choose>--%>

                                        <c:choose>
                                            <c:when test="${fn:length(proposal.content) > 50}">
                                                <p class="text-muted font-13 mb-3 truncated-content">
                                                    ${fn:substring(proposal.content, 0, 50)} ...
                                                    <a href="${pageContext.request.contextPath}/proposal/${proposal.proposalId }" class="fw-bold text-muted">view more</a>
                                                </p>
                                            </c:when>

                                            <c:otherwise>
                                                <p class="text-muted font-13 mb-3">${proposal.content}</p>
                                            </c:otherwise>
                                        </c:choose>

                                        <!-- project detail-->
                                        <p class="mb-1">
<%--                                            <span class="pe-2 text-nowrap mb-2 d-inline-block">--%>
<%--                                                <i class="mdi mdi-format-list-bulleted-type text-muted"></i>--%>
<%--                                                <b>21</b> Tasks--%>
<%--                                            </span>--%>
                                            <span class="text-nowrap mb-2 d-inline-block">
                                                <i class="mdi mdi-comment-multiple-outline text-muted"></i>
                                                <b>${proposal.comments}</b> 댓글
                                            </span>
                                        </p>
                                        <div id="tooltip-container">
                                            <!-- 해당 Proposal에 연관된 전체 Union 수를 초기화 -->
                                            <c:set var="totalUnionsForProposal" value="0" />

                                            <c:forEach items="${unions}" var="union" varStatus="status">
                                                <c:if test="${union.proposalId == proposal.proposalId}">
                                                    <!-- 해당 Proposal에 연관된 전체 Union 수를 계산 -->
                                                    <c:set var="totalUnionsForProposal" value="${totalUnionsForProposal + 1}" />
                                                </c:if>
                                            </c:forEach>

                                            <c:forEach items="${unions}" var="union" varStatus="status">
                                                <c:if test="${union.proposalId == proposal.proposalId and (status.index < 3 or totalUnionsForProposal <= 3)}">
                                                    <a href="javascript:void(0);" data-bs-container="#tooltip-container" data-bs-toggle="tooltip" data-bs-placement="top" title="${union.memberId}" class="d-inline-block">
                                                        <img src="../../../resources/img/person/${union.memberId}.jpg" class="rounded-circle avatar-xs" alt="friend">
                                                    </a>
                                                </c:if>
                                            </c:forEach>

                                            <c:choose>
                                                <c:when test="${totalUnionsForProposal == 0}">
                                                    <span class="d-inline-block text-muted fw-bold ms-2">none</span>
                                                </c:when>

                                                <c:when test="${totalUnionsForProposal > 3}">
                                                    <a href="javascript:void(0);" class="d-inline-block text-muted fw-bold ms-2">
                                                        +${totalUnionsForProposal - 3} more
                                                    </a>
                                                </c:when>

                                                <c:otherwise>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div> <!-- end card-body-->
                                    <ul class="list-group list-group-flush">
                                        <li class="list-group-item p-3">
                                            <!-- project progress-->
                                            <c:set var="rate1" value="${proposal.rate1}" />
                                            <c:set var="rate2" value="${proposal.rate2}" />
                                            <c:set var="rate" value="${(rate1 > rate2) ? rate1 : rate2}" />

                                            <p class="mb-2 fw-bold">달성률<span class="float-end">${rate}%</span></p>
                                            <div class="progress progress-sm">
                                                <div class="progress-bar" role="progressbar" aria-valuenow="${rate}" aria-valuemin="0" aria-valuemax="100" style="width: ${rate}%;"></div>
                                            </div>
                                        </li>
                                    </ul>
                                </div> <!-- end card-->
                            </div> <!-- end col -->

                        </c:forEach>

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
                                        <li class="page-item"><a class="page-link" href="/proposal?page=${i}">${i}</a></li>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <li class="page-item">
                                <a class="page-link" href="javascript: void(0);" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>

                    </div>
                    <!-- end row-->

                </div>
                <!-- content -->

            </div> <!-- content-page -->

        </div> <!-- end wrapper-->
    </div>
    <!-- END Container -->

    <%@ include file="../include/footer.jsp" %>

</body>
</html>
