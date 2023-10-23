<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        #social {
            width: 100%;
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
                    <div class="col-xxl-6 col-lg-12 order-lg-2 order-xxl-1" id="social">
                        <div class="card">
                            <div class="card-body pb-1">
                                <div class="d-flex">
                                    <img class="me-2 rounded" src="../../../resources/img/logo/${board.isin}.png"
                                         alt="Generic placeholder image" height="40">
                                    <div class="w-100">
                                        <div class="dropdown float-end text-muted">
                                            <a href="#" class="dropdown-toggle arrow-none card-drop"
                                               data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="mdi mdi-dots-horizontal"></i>
                                            </a>
                                            <div class="dropdown-menu dropdown-menu-end">
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Edit</a>
                                                <!-- item-->
                                                <a href="javascript:void(0);" class="dropdown-item">Delete</a>
                                            </div>
                                        </div>
                                        <h5 class="m-0">${board.title}</h5>
                                        <p class="text-muted">

                                            <jsp:useBean id="now" class="java.util.Date"/>
                                            <!-- 1. regDate를 Date 객체로 파싱 -->
                                            <fmt:parseDate value="${board.regDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedRegDate"/>
                                            <!-- 2. 현재 날짜와 시간을 가져옴 -->
                                            <fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" var="currentDate"/>
                                            <fmt:parseDate value="${currentDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedCurrentDate"/>
                                            <!-- 3. 두 날짜 사이의 시간 차이 계산 -->
                                            <c:set var="timeDiff" value="${parsedCurrentDate.time - parsedRegDate.time}" />
                                            <c:set var="minutesDiff" value="${timeDiff / 60000}" />
                                            <c:set var="hoursDiff" value="${timeDiff / 3600000}" />
                                            <c:set var="daysDiff" value="${timeDiff / 86400000}" />

                                            <!-- 4. 계산된 시간 차이를 바탕으로 적절한 문자열 표시 -->
                                            <c:choose>
                                                <c:when test="${daysDiff >= 1}">
                                                    약 ${Math.floor(daysDiff).intValue()}일 전
                                                </c:when>
                                                <c:when test="${hoursDiff >= 1}">
                                                    약 ${Math.floor(hoursDiff).intValue()}시간 전
                                                </c:when>
                                                <c:otherwise>
                                                    약 ${Math.floor(minutesDiff).intValue()}분 전
                                                </c:otherwise>
                                            </c:choose>
                                            <span class="mx-1">⚬</span>
                                            <span>
                                                <c:choose>
                                                    <c:when test="${board.status == 0}">
                                                        전체
                                                    </c:when>
                                                    <c:when test="${board.status == 1}">
                                                        주주만
                                                    </c:when>
                                                    <c:when test="${board.status == 2}">
                                                        등급제
                                                    </c:when>
                                                </c:choose>
                                            </span>
                                        </small></p>
                                    </div>
                                </div>

                                <hr class="m-0"/>

                                <div class="my-3">
                                    <%--                                <div class="font-16 text-center text-dark my-3">--%>
                                    <%--                                    <i class="mdi mdi-format-quote-open font-20"></i>--%>
                                    ${board.content}
                                </div>

                                <hr class="m-0"/>

                                <div class="my-1">
                                    <a href="javascript: void(0);" class="btn btn-sm btn-link text-muted ps-0"><i
                                            class='mdi mdi-heart
<%--                                            text-danger--%>
                                            '></i> 0 좋아요</a>
                                    <a href="javascript: void(0);" class="btn btn-sm btn-link text-muted"><i
                                            class='uil uil-comments-alt'></i> 0 댓글</a>
                                    <a href="javascript: void(0);" class="btn btn-sm btn-link text-muted"><i
                                            class='uil uil-share-alt'></i> 공유하기</a>
                                </div>

                                <hr class="m-0"/>

                                <div class="mt-3">
                                    <c:forEach var="comment" items="${boardCommentList}" varStatus="status">
                                        <c:if test="${comment.indent == 1}">
                                            <div class="d-flex">
                                                <img class="me-2 rounded"
                                                     src="../../../resources/img/person/${comment.memberId}.jpg"
                                                     alt="image" height="32">
                                                <div>
                                                    <h5 class="m-0">${comment.memberId} </h5>
                                                    <p class="text-muted mb-0"><small>${comment.regDate}</small></p>

                                                    <p class="my-1">${comment.content}</p>

                                                    <div>
                                                        <a href="javascript: void(0);"
                                                           class="btn btn-sm btn-link text-muted p-0">
                                                            <i class='uil uil-heart me-1'></i> 좋아요
                                                        </a>
                                                        <a href="javascript: void(0);"
                                                           class="btn btn-sm btn-link text-muted p-0 ps-2"
                                                           onclick="showReplyForm(${comment.boardCommentId})">
                                                            <i class='uil uil-comments-alt me-1'></i> 답글
                                                        </a>

                                                        <!-- 답글 입력 폼 -->
                                                        <div id="replyForm${comment.boardCommentId}" style="display: none;">
                                                            <form name="replyForm${comment.boardCommentId}" onsubmit="event.preventDefault(); reply(${comment.boardCommentId});">
                                                                <input type="text" class="form-control border-0 form-control-sm" placeholder="내용을 작성하세요" name="content" onkeydown="if (event.key == 'Enter') reply(${comment.boardCommentId});">
                                                            </form>
                                                        </div>
                                                    </div>

                                                    <!-- Sub Comments -->
                                                    <c:forEach var="subComment" items="${boardCommentList}"
                                                               varStatus="subStatus">
                                                        <c:if test="${subComment.parent == comment.boardCommentId}">
                                                            <div class="d-flex mt-3">
                                                                <img class="me-2 rounded"
                                                                     src="../../../resources/assets/images/users/avatar-8.jpg"
                                                                     alt="Generic placeholder image" height="32">
                                                                <div>
                                                                    <h5 class="m-0">${subComment.memberId} </h5>
                                                                    <p class="text-muted mb-0">
                                                                        <small>${subComment.regDate} mins ago</small>
                                                                    </p>

                                                                    <p class="my-1">${subComment.content}</p>

                                                                    <c:forEach var="subSubComment"
                                                                               items="${boardCommentList}"
                                                                               varStatus="subSubStatus">
                                                                        <c:if test="${subSubComment.parent == subComment.boardCommentId}">
                                                                            <div class="d-flex mt-3 ml-3">
                                                                                <!-- ml-3 to give some margin -->
                                                                                <img class="me-2 rounded"
                                                                                     src="../../../resources/assets/images/users/avatar-7.jpg"
                                                                                     alt="Generic placeholder image"
                                                                                     height="32">
                                                                                <div>
                                                                                    <h5 class="m-0">${subSubComment.memberId} </h5>
                                                                                    <p class="text-muted mb-0">
                                                                                        <small>${subSubComment.regDate}
                                                                                            mins ago</small></p>

                                                                                    <p class="my-1">${subSubComment.content}</p>
                                                                                </div>
                                                                            </div>
                                                                            <!-- end sub-sub comment-->
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </div>
                                                            </div>
                                                            <!-- end sub comment-->
                                                        </c:if>
                                                    </c:forEach>
                                                </div> <!-- end div -->
                                            </div>
                                            <!-- end d-flex-->
                                        </c:if>
                                    </c:forEach>
                                </div>

                                <hr/>

                                <div class="d-flex mb-2">
                                    <img src="../../../resources/img/person/${currentUser.memberId}.jpg" height="32"
                                         class="align-self-start rounded me-2" alt="Arya Stark"/>
                                    <div class="w-100">
                                        <form name="replyForm" onsubmit="event.preventDefault(); reply();">
                                        <input type="text" class="form-control border-0 form-control-sm"
                                               placeholder="내용을 작성하세요">
                                        </form>
                                    </div>
                                </div>

                            </div>
                        </div> <!-- end card-body -->
                    </div> <!-- end card -->

                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../include/footer.jsp" %>

<script>
    // 댓글 작성
    function reply() {
        let replyContent = document.replyForm.content.value;
        if (!replyContent.trim()) return; // Avoid submitting empty or whitespace strings
        $.ajax({
            url: '${pageContext.request.contextPath}/board-reply',
            method: 'post',
            data: {
                proposalId: proposalId,
                content: replyContent,
            },
            success: function () {
                document.replyForm.content.value = "";
                location.reload();
            },
            error: function () {
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

    function showReplyForm(commentId) {
        const formElement = document.getElementById(`replyForm${commentId}`);
        formElement.style.display = formElement.style.display === 'none' ? '' : 'none';
    }

    function writeReply(parentId, indentValue, replyContent) {
        $.ajax({
            url: '${pageContext.request.contextPath}/board-rereply',
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