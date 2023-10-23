<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        h6 {
            margin-top: 20px !important;
        }
        .buttons {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 30px;
        }
        .rounded-pill {
            margin: 0 30px;
        }
        .btn-success {
            background-color: #008485 !important;
            border-color: #008485 !important;
        }
        .btn-danger {
            background-color: #E90061 !important;
            border-color: #E90061 !important;
        }
        .form-control {
            height: 100px !important;
        }
        .comment-info {
            display: flex;
            color: grey;
            font-size: 80%;
            margin-top: 10px;
            margin-bottom: 20px;
        }
        .comment-info > * {
            margin-right: 10px;
        }
        .reply-btn {
            border: none;
            outline: none;
        }
        .reply-form {
            display: none;
        }
    </style>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>

<body class="loading" data-layout="detached" data-layout-config='{"leftSidebarCondensed":false,"darkMode":false, "showRightSidebarOnStart": true}'>

<%@ include file="../include/header.jsp" %>

<!-- Start Content-->
<div class="container-fluid">

    <!-- Begin page -->
    <div class="wrapper">

        <div class="content-page">
            <div class="content">

                <div class="row">
                    <div class="col-xxl-8 col-lg-6">
                        <!-- project card -->
                        <div class="card d-block">
                            <div class="card-body">
                                <div class="dropdown float-end">
                                    <a href="#" class="dropdown-toggle arrow-none card-drop" data-bs-toggle="dropdown" aria-expanded="false">
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
                                <!-- project title-->
                                <c:choose>
                                    <c:when test="${proposal.status == 1}">
                                        <div class="badge bg-secondary mb-3">마감완료</div>
                                    </c:when>
                                    <c:when test="${proposal.status == 0}">
                                        <div class="badge bg-success text-light mb-3">진행중</div>
                                    </c:when>
                                </c:choose>

                                <h3 class="mt-0">
                                    ${proposal.title }
                                </h3>

                                <p class="text-muted mb-4">
                                    ${proposal.content }
                                </p>

                                <div class="row">
                                    <div class="col-md-5">
                                        <div class="mb-4">
                                            <h5>시작일</h5>
                                            <p>
                                                ${fn:split(proposal.startDate, ' ')[0]}
                                                <small class="text-muted">
                                                ${fn:split(proposal.startDate, ' ')[1]}
                                                </small>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="col-md-5">
                                        <div class="mb-4">
                                            <h5>마감일</h5>
                                            <p>
                                                ${fn:split(proposal.endDate, ' ')[0]}
                                                <small class="text-muted">
                                                ${fn:split(proposal.endDate, ' ')[1]}
                                                </small>
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div id="tooltip-container">
                                    <h5>참여자</h5>
                                    <!-- 해당 Proposal에 연관된 전체 Union 수를 초기화 -->
                                    <c:set var="totalUnionsForProposal" value="0" />

                                    <c:forEach items="${unions}" var="union" varStatus="status">
                                        <c:if test="${union.proposalId == proposal.proposalId}">
                                            <!-- 해당 Proposal에 연관된 전체 Union 수를 계산 -->
                                            <c:set var="totalUnionsForProposal" value="${totalUnionsForProposal + 1}" />
                                        </c:if>
                                    </c:forEach>

                                    <c:forEach items="${unions}" var="union" varStatus="status">
                                        <c:if test="${union.proposalId == proposal.proposalId and (status.index < 7 or totalUnionsForProposal <= 7)}">
                                            <a href="javascript:void(0);" data-bs-container="#tooltip-container" data-bs-toggle="tooltip" data-bs-placement="top" title="${union.memberId}" class="d-inline-block">
                                                <img src="../../../resources/img/person/${union.memberId}.jpg" class="rounded-circle avatar-xs" alt="friend">
                                            </a>
                                        </c:if>
                                    </c:forEach>

                                    <c:choose>
                                        <c:when test="${totalUnionsForProposal == 0}">
                                            <span class="d-inline-block text-muted fw-bold ms-2">none</span>
                                        </c:when>

                                        <c:when test="${totalUnionsForProposal > 7}">
                                            <a href="javascript:void(0);" class="d-inline-block text-muted fw-bold ms-2">
                                                +${totalUnionsForProposal - 7} more
                                            </a>
                                        </c:when>

                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="buttons">
                                    <button type="button" class="btn btn-success rounded-pill" onclick="join()">동참하기</button>
                                    <button type="button" class="btn btn-danger rounded-pill" onclick="leave()">철회하기</button>
                                </div>

                            </div> <!-- end card-body-->

                        </div> <!-- end card-->

                        <div class="card">
                            <div class="card-body">
                                <h4 class="mt-0 mb-3">댓글 (${comments.size()})</h4>

                                <form name="replyForm">
                                <textarea class="form-control form-control-light mb-2" placeholder="메세지를 작성하세요" id="example-textarea" rows="10" name="content"></textarea>
                                <div class="text-end">
                                    <div class="btn-group mb-2">
                                        <button type="button" class="btn btn-link btn-sm text-muted font-18"><i class="dripicons-paperclip"></i></button>
                                    </div>
                                    <div class="btn-group mb-2 ms-2">
                                        <button type="button" class="btn btn-primary btn-sm" onclick="reply()">작성</button>
                                    </div>
                                </div>
                                </form>
                                <c:forEach items="${comments}" var="comment">
                                    <c:if test="${comment.indent == 1}">
                                        <!-- 기본 댓글 -->
                                        <div class="d-flex align-items-start mt-2">
                                            <img class="me-3 avatar-sm rounded-circle" src="../../../resources/img/person/${comment.memberId}.jpg" alt="Generic placeholder image">
                                            <div class="w-100 overflow-hidden">
                                                <h5 class="mt-0">${comment.memberId}</h5>
                                                <div>${comment.content}</div>
                                                <div class="comment-info">
                                                    <div>${comment.regDate}</div>
                                                    <button class="reply-btn" data-parentid="${comment.proposalCommentId}" data-indent="2">답글</button>
                                                </div>

                                                <!-- 답글 입력 폼 -->
                                                <div class="reply-form">
                                                    <textarea class="form-control form-control-light mb-2" placeholder="Write message"></textarea>
                                                    <button type="button" class="btn btn-primary btn-sm" onclick="writeReply()">작성</button>
                                                </div>

                                                <!-- 해당 댓글에 대한 답글 -->
                                                <c:forEach items="${comments}" var="reply">
                                                    <c:if test="${reply.parent == comment.proposalCommentId}">
                                                        <div class="d-flex align-items-start mt-3">
                                                            <a class="pe-3" href="#">
                                                                <img src="../../../resources/img/person/${reply.memberId}.jpg" class="avatar-sm rounded-circle" alt="Generic placeholder image">
                                                            </a>
                                                            <div class="w-100 overflow-hidden">
                                                                <h5 class="mt-0">${reply.memberId}</h5>
                                                                <div>${reply.content}</div>
                                                                <div class="comment-info">
                                                                    <div>${reply.regDate}</div>
                                                                    <button class="reply-btn" data-parentid="${reply.proposalCommentId}" data-indent="3">답글</button>
                                                                </div>

                                                                <!-- 답글 입력 폼 -->
                                                                <div class="reply-form">
                                                                    <textarea class="form-control form-control-light mb-2" placeholder="Write message"></textarea>
                                                                    <button type="button" class="btn btn-primary btn-sm" onclick="writeReply()">작성</button>
                                                                </div>

                                                                <!-- 답글에 대한 답글 -->
                                                                <c:forEach items="${comments}" var="subReply">
                                                                    <c:if test="${subReply.parent == reply.proposalCommentId}">
                                                                        <div class="d-flex align-items-start mt-3">
                                                                            <a class="pe-3" href="#">
                                                                                <img src="../../../resources/img/person/${subReply.memberId}.jpg" class="avatar-sm rounded-circle" alt="Generic placeholder image">
                                                                            </a>
                                                                            <div class="w-100 overflow-hidden">
                                                                                <h5 class="mt-0">${subReply.memberId}</h5>
                                                                                <div>${subReply.content}</div>
                                                                                <div class="comment-info">
                                                                                    <div>${subReply.regDate}</div>
                                                                                    <button class="reply-btn" data-parentid="${subReply.proposalCommentId}" data-indent="4">답글</button>
                                                                                </div>

                                                                                <!-- 답글 입력 폼 -->
                                                                                <div class="reply-form">
                                                                                    <textarea class="form-control form-control-light mb-2" placeholder="Write message"></textarea>
                                                                                    <button type="button" class="btn btn-primary btn-sm" onclick="writeReply()">작성</button>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </c:if>
                                                </c:forEach>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>

<%--                                <div class="text-center mt-2">--%>
<%--                                    <a href="javascript:void(0);" class="text-danger">Load more </a>--%>
<%--                                </div>--%>
                            </div> <!-- end card-body-->
                        </div>
                        <!-- end card-->
                    </div> <!-- end col -->

                    <div class="col-lg-6 col-xxl-4">
                        <div class="card" id="chartCard">
                            <div class="card-body">
                                <h4 class="card-title mb-3">달성율</h4>
                                <div dir="ltr">
                                    <div class="mt-3 chartjs-chart" style="height: 630px;">
                                        <h6>기준1: 3% 이상</h6>
                                        <canvas id="myChart1" width="300" height="186"></canvas>
                                        <h6>기준2: 6개월 이상 보유 1% 이상</h6>
                                        <canvas id="myChart2" width="300" height="186"></canvas>
                                    </div>
                                </div>
                                <div style="font-size: 0.8rem; color: darkgrey; margin-top: 15px; margin-bottom: 5px;">
                                    <%
                                        java.util.Date today = new java.util.Date();
                                        // 시간, 분, 초를 0으로 설정하여 정각을 얻습니다.
                                        today.setHours(0);
                                        today.setMinutes(0);
                                        today.setSeconds(0);
                                        pageContext.setAttribute("todayAtMidnight", today);
                                    %>

                                    <!-- 오늘 날짜 + 정각 표시 -->
                                    달성율 기준 : <fmt:formatDate value="${todayAtMidnight}" pattern="yyyy-MM-dd HH:mm:ss" />
                                </div>
                            </div>
                        </div>
                        <!-- end card-->

                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title mb-3">첨부파일</h5>

                                <%--
                                첨부파일 부분 주석!
                                <div class="card mb-1 shadow-none border">
                                    <div class="p-2">
                                        <div class="row align-items-center">
                                            <div class="col-auto">
                                                <div class="avatar-sm">
                                                    <span class="avatar-title rounded">
                                                        .ZIP
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col ps-0">
                                                <a href="javascript:void(0);" class="text-muted fw-bold">Hyper-admin-design.zip</a>
                                                <p class="mb-0">2.3 MB</p>
                                            </div>
                                            <div class="col-auto">
                                                <!-- Button -->
                                                <a href="javascript:void(0);" class="btn btn-link btn-lg text-muted">
                                                    <i class="dripicons-download"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="card mb-1 shadow-none border">
                                    <div class="p-2">
                                        <div class="row align-items-center">
                                            <div class="col-auto">
                                                <img src="../../../resources/assets/images/projects/project-1.jpg" class="avatar-sm rounded" alt="file-image" />
                                            </div>
                                            <div class="col ps-0">
                                                <a href="javascript:void(0);" class="text-muted fw-bold">Dashboard-design.jpg</a>
                                                <p class="mb-0">3.25 MB</p>
                                            </div>
                                            <div class="col-auto">
                                                <!-- Button -->
                                                <a href="javascript:void(0);" class="btn btn-link btn-lg text-muted">
                                                    <i class="dripicons-download"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="card mb-0 shadow-none border">
                                    <div class="p-2">
                                        <div class="row align-items-center">
                                            <div class="col-auto">
                                                <div class="avatar-sm">
                                                            <span class="avatar-title bg-secondary text-light rounded">
                                                                .MP4
                                                            </span>
                                                </div>
                                            </div>
                                            <div class="col ps-0">
                                                <a href="javascript:void(0);" class="text-muted fw-bold">Admin-bug-report.mp4</a>
                                                <p class="mb-0">7.05 MB</p>
                                            </div>
                                            <div class="col-auto">
                                                <!-- Button -->
                                                <a href="javascript:void(0);" class="btn btn-link btn-lg text-muted">
                                                    <i class="dripicons-download"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            --%>

                            </div>
                        </div>
                    </div>
                </div>
                <!-- end row -->

            </div> <!-- End Content -->

        </div> <!-- content-page -->

    </div> <!-- end wrapper-->
</div>
<!-- END Container -->

<%@ include file="../include/footer.jsp" %>

<!-- third party js -->
<script src="../../../resources/assets/js/vendor/Chart.bundle.min.js"></script>
<script src="../../../resources/assets/js/pages/demo.project-detail.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {  // 문서가 준비되면 실행됩니다.
        const ctx1 = document.getElementById('myChart1').getContext('2d');  // 2d rendering context를 가져옵니다.
        const ctx2 = document.getElementById('myChart2').getContext('2d');  // 2d rendering context를 가져옵니다.

        var rate1 = ${proposal.rate1};
        var rate2 = ${proposal.rate2};

        // rate1에 따른 데이터와 색상 설정
        var data1, backgroundColor1;
        if (rate1 <= 100) {
            data1 = [rate1, (100-rate1)];
            backgroundColor1 = ['#008485', '#F2F3F6'];
        } else {
            data1 = [(100-rate1), (200-rate1)];
            backgroundColor1 = ['#E90061', '#008485'];
        }

        // rate2에 따른 데이터와 색상 설정
        var data2, backgroundColor2;
        if (rate2 <= 100) {
            data2 = [rate2, (100-rate2)];
            backgroundColor2 = ['#008485', '#F2F3F6'];
        } else {
            data2 = [(100-rate2), (200-rate2)];
            backgroundColor2 = ['#E90061', '#008485'];
        }

        var myChart1 = new Chart(ctx1, {
            type: 'doughnut',
            data: {
                labels: [
                    '달성률',
                    '남은 비율'
                ],
                datasets: [{
                    label: 'My First Dataset',
                    data: data1,
                    backgroundColor:  backgroundColor1,
                    borderWidth: 0,
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,   // 가로 세로 비율 유지
                legend: {
                    position: 'bottom' // 이 부분을 추가해서 범례의 위치를 아래로 조정합니다.
                }
            }
        });

        var myChart2 = new Chart(ctx2, {
            type: 'doughnut',
            data: {
                labels: [
                    '달성률',
                    '남은 비율'
                ],
                datasets: [{
                    data: data2,
                    backgroundColor:  backgroundColor2,
                    borderWidth: 0,
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,   // 가로 세로 비율 유지
                legend: {
                    position: 'bottom' // 이 부분을 추가해서 범례의 위치를 아래로 조정합니다.
                }
            }
        });
    });
    var proposalId = ${proposal.proposalId};

    // 동참하기 버튼 누르기
    function join() {
        $.ajax({
            url: "/joinProposal",
            type: "POST",
            data: {
                'proposalId': proposalId
            },
            success: function(response) {
                alert(response); // 응답 메시지를 alert로 출력
                location.reload(); // 페이지 새로고침
            },
            error: function() {
                alert("동참 실패");
            },
        });
    }

    // 동참하기 버튼 누르기
    function leave() {
        $.ajax({
            url: "/leaveProposal",
            type: "POST",
            data: {
                'proposalId': proposalId
            },
            success: function(response) {
                alert(response); // 응답 메시지를 alert로 출력
                location.reload(); // 페이지 새로고침
            },
            error: function() {
                alert("철회 실패");
            },
        });
    }

    // 댓글 작성
    function reply() {
        let replyContent = document.replyForm.content.value;
        $.ajax({
            url 	: '${pageContext.request.contextPath}/reply',
            method 	: 'post',
            data 	: {
                proposalId : proposalId,
                content : replyContent,
            },
            success : function(){
                document.replyForm.content.value="";
                location.reload();
            },
            error 	: function(){
                alert('실패');
            }
        })
    }

    $(document).ready(function() {
        // 이벤트 위임을 사용하여 각 댓글 수준별로 클릭 이벤트 핸들러를 바인딩
        $('.reply-btn').click(function() {
            let $replyForm = $(this).closest('.comment-info').next('.reply-form');
            $replyForm.toggle();

            let parentId = $(this).data('parentid');
            let indentValue = $(this).data('indent');

            // 이전에 바인딩된 이벤트 핸들러 제거
            $replyForm.find('button[type="button"]').off('click').on('click', function() {
                let replyContent = $(this).prev('textarea').val();
                if(replyContent) { // 답글 내용이 있는 경우에만 AJAX 요청
                    writeReply(parentId, indentValue, replyContent);
                } else {
                    alert('내용을 입력하세요.');
                }
            });
        });
    });

    function writeReply(parentId, indentValue, replyContent) {

        $.ajax({
            url: '${pageContext.request.contextPath}/rereply',
            method: 'post',
            data: {
                proposalId: proposalId,
                content: replyContent,
                parent: parentId,
                indent: indentValue
            },
            success: function() {
                location.reload();
            },
            error: function() {
                location.reload();
            }
        });
    }
</script>

</body>
</html>