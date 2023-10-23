<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <style>
        #page {
            margin-top: 20px;
            padding-bottom: 0px;
            min-height: auto;
        }
        .w-75:hover {
            text-decoration: none;
        }
    </style>
</head>

<body class="loading" data-layout="detached" data-layout-config='{"leftSidebarCondensed":false,"darkMode":false, "showRightSidebarOnStart": true}'>

<%@ include file="../include/header.jsp" %>

<!-- Start Content-->
<div class="container-fluid">

    <!-- Begin page -->
    <div class="wrapper">
        <div class="content-page" id="page">
            <div class="content">
                <div class="row">
                    <!-- start chat users-->
                    <div class="col-lg-3 order-xl-1">
                        <div class="card">
                            <div class="card-body p-0">
                                <ul class="nav nav-tabs nav-bordered">
                                    <li class="nav-item">
                                        <a href="#allUsers" data-bs-toggle="tab" aria-expanded="false" class="nav-link active py-2">
                                            All
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#private" data-bs-toggle="tab" aria-expanded="true" class="nav-link py-2">
                                            private
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a href="#group" data-bs-toggle="tab" aria-expanded="true" class="nav-link py-2">
                                            group
                                        </a>
                                    </li>
                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane show active p-3" id="allUsers">
                                        <div class="app-search">
                                            <form>
                                                <div class="mb-2 position-relative">
                                                    <input type="text" class="form-control"
                                                           placeholder="People, groups & messages..." />
                                                    <span class="mdi mdi-magnify search-icon"></span>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="row">
                                            <div class="col">
                                                <div data-simplebar style="max-height: 560px; min-height: 560px;">
                                                    <c:forEach items="${allChatRoomList}" var="chatRoom">
                                                        <a href="javascript:void(0);" class="text-body" data-room-id="${chatRoom.roomId}" onclick="openChatRoom(${chatRoom.roomId});">
                                                            <div class="d-flex align-items-start mt-1 p-2">
                                                                <img src="../../../resources/img/person/${chatRoom.lastMessage.memberId}.jpg" class="me-2 rounded-circle" height="48" alt="User Image" />
                                                                <div class="w-100 overflow-hidden">
                                                                    <h5 class="mt-0 mb-0 font-14">

                                                                        <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="formattedCurrentDate"/>

                                                                        <fmt:parseDate value="${chatRoom.lastMessage.regDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedChatDate"/>
                                                                        <fmt:formatDate value="${parsedChatDate}" pattern="yyyy-MM-dd" var="formattedChatDate"/>
                                                                        <fmt:formatDate value="${parsedChatDate}" pattern="HH:mm" var="timePart"/>

                                                                        <c:choose>
                                                                            <c:when test="${formattedChatDate eq formattedCurrentDate}">
                                                                                <span class="float-end text-muted font-12">${timePart}</span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <fmt:formatDate value="${parsedChatDate}" pattern="EEE" var="dayOfWeek"/>
                                                                                <span class="float-end text-muted font-12">${dayOfWeek}</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                            ${chatRoom.title}
                                                                    </h5>
                                                                    <p class="mt-1 mb-0 text-muted font-14">
                                                                        <c:if test="${chatRoom.lastMessage.unreadCount >= 1}">
                                                                        <span class="w-25 float-end text-end">
                                                                            <span class="badge badge-danger-lighten">${chatRoom.lastMessage.unreadCount}</span>
                                                                        </span>
                                                                        </c:if>
                                                                        <span class="w-75">${chatRoom.lastMessage.content}</span>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </a>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Private Chat Rooms -->
                                    <div class="tab-pane p-3" id="private">
                                            <div class="app-search">
                                                <form>
                                                    <div class="mb-2 position-relative">
                                                        <input type="text" class="form-control"
                                                               placeholder="People, groups & messages..." />
                                                        <span class="mdi mdi-magnify search-icon"></span>
                                                    </div>
                                                </form>
                                            </div>
                                        <div class="row">
                                            <div class="col">
                                                <div data-simplebar style="max-height: 560px; min-height: 560px;">
                                                    <c:forEach items="${privateChatRoomList}" var="chatRoom">
                                                        <a href="javascript:void(0);" class="text-body" data-room-id="${chatRoom.roomId}" onclick="openChatRoom(${chatRoom.roomId});">
                                                            <div class="d-flex align-items-start mt-1 p-2">
                                                                <img src="../../../resources/img/person/${chatRoom.lastMessage.memberId}.jpg" class="me-2 rounded-circle" height="48" alt="User Image" />
                                                                <div class="w-100 overflow-hidden">
                                                                    <h5 class="mt-0 mb-0 font-14">

                                                                        <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="formattedCurrentDate"/>

                                                                        <fmt:parseDate value="${chatRoom.lastMessage.regDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedChatDate"/>
                                                                        <fmt:formatDate value="${parsedChatDate}" pattern="yyyy-MM-dd" var="formattedChatDate"/>
                                                                        <fmt:formatDate value="${parsedChatDate}" pattern="HH:mm" var="timePart"/>

                                                                        <c:choose>
                                                                            <c:when test="${formattedChatDate eq formattedCurrentDate}">
                                                                                <span class="float-end text-muted font-12">${timePart}</span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <fmt:formatDate value="${parsedChatDate}" pattern="EEE" var="dayOfWeek"/>
                                                                                <span class="float-end text-muted font-12">${dayOfWeek}</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                            ${chatRoom.title}
                                                                    </h5>
                                                                    <p class="mt-1 mb-0 text-muted font-14">
                                                                        <c:if test="${chatRoom.lastMessage.unreadCount >= 1}">
                                                                            <span class="w-25 float-end text-end">
                                                                                <span class="badge badge-danger-lighten">${chatRoom.lastMessage.unreadCount}</span>
                                                                            </span>
                                                                        </c:if>
                                                                        <span class="w-75">${chatRoom.lastMessage.content}</span>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </a>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Group Chat Rooms -->
                                    <div class="tab-pane p-3" id="group">
                                        <div class="app-search">
                                            <form>
                                                <div class="mb-2 position-relative">
                                                    <input type="text" class="form-control"
                                                           placeholder="People, groups & messages..." />
                                                    <span class="mdi mdi-magnify search-icon"></span>
                                                </div>
                                            </form>
                                        </div>
                                        <div class="row">
                                            <div class="col">
                                                <div data-simplebar style="max-height: 560px; min-height: 560px;">
                                                    <c:forEach items="${groupChatRoomList}" var="chatRoom">
                                                        <a href="javascript:void(0);" class="text-body" data-room-id="${chatRoom.roomId}" onclick="openChatRoom(${chatRoom.roomId});">
                                                            <div class="d-flex align-items-start mt-1 p-2">
                                                                <img src="../../../resources/img/person/${chatRoom.lastMessage.memberId}.jpg" class="me-2 rounded-circle" height="48" alt="User Image" />
                                                                <div class="w-100 overflow-hidden">
                                                                    <h5 class="mt-0 mb-0 font-14">

                                                                        <fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="formattedCurrentDate"/>

                                                                        <fmt:parseDate value="${chatRoom.lastMessage.regDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedChatDate"/>
                                                                        <fmt:formatDate value="${parsedChatDate}" pattern="yyyy-MM-dd" var="formattedChatDate"/>
                                                                        <fmt:formatDate value="${parsedChatDate}" pattern="HH:mm" var="timePart"/>

                                                                        <c:choose>
                                                                            <c:when test="${formattedChatDate eq formattedCurrentDate}">
                                                                                <span class="float-end text-muted font-12">${timePart}</span>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <fmt:formatDate value="${parsedChatDate}" pattern="EEE" var="dayOfWeek"/>
                                                                                <span class="float-end text-muted font-12">${dayOfWeek}</span>
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                            ${chatRoom.title}
                                                                    </h5>
                                                                    <p class="mt-1 mb-0 text-muted font-14">
                                                                        <c:if test="${chatRoom.lastMessage.unreadCount >= 1}">
                                                                        <span class="w-25 float-end text-end">
                                                                            <span class="badge badge-danger-lighten">${chatRoom.lastMessage.unreadCount}</span>
                                                                        </span>
                                                                        </c:if>
                                                                        <span class="w-75">${chatRoom.lastMessage.content}</span>
                                                                    </p>
                                                                </div>
                                                            </div>
                                                        </a>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div> <!-- end card-body-->
                        </div> <!-- end card-->
                    </div>
                    <!-- end chat users-->

                    <!-- chat area -->
                    <div class="col-lg-7 order-xl-2">
                        <div class="card">
                            <div class="card-body">
                                <ul class="conversation-list" data-simplebar style="max-height: 537px; min-height: 537px;">
                                    <!-- 첨부파일 예시 남겨놓기 -->
                                    <li class="clearfix odd">
                                        <div class="chat-avatar">
                                            <img src="../../../resources/assets/images/users/avatar-1.jpg" alt="dominic" class="rounded" />
                                            <i>10:05</i>
                                        </div>
                                        <div class="conversation-text">
                                            <div class="ctext-wrap">
                                                <i>Dominic</i>
                                                <p>
                                                    3pm it is. Sure, let's discuss about presentation format, it would be great to finalize today.
                                                    I am attaching the last year format and assets here...
                                                </p>
                                            </div>
                                            <div class="card mt-2 mb-1 shadow-none border text-start">
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
                                                            <a href="javascript:void(0);"
                                                               class="text-muted fw-bold">Hyper-admin-design.zip</a>
                                                            <p class="mb-0">2.3 MB</p>
                                                        </div>
                                                        <div class="col-auto">
                                                            <!-- Button -->
                                                            <a href="javascript:void(0);"
                                                               class="btn btn-link btn-lg text-muted">
                                                                <i class="dripicons-download"></i>
                                                            </a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ul>

                                <div class="row">
                                    <div class="col">
                                        <div class="mt-2 bg-light p-3 rounded">
                                            <form class="needs-validation" novalidate="" name="chat-form"
                                                  id="chat-form">
                                                <div class="row">
                                                    <div class="col mb-2 mb-sm-0">
                                                        <input type="text" class="form-control border-0" placeholder="Enter your text" required="" id="chat">
                                                        <div class="invalid-feedback">
                                                            Please enter your messsage
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-auto">
                                                        <div class="btn-group">
                                                            <a href="#" class="btn btn-light"><i class="uil uil-paperclip"></i></a>
                                                            <a href="#" class="btn btn-light"> <i class='uil uil-smile'></i> </a>
                                                            <div class="d-grid">
                                                                <button type="button" class="btn btn-success chat-send" id="sendBtn" onclick="send()"><i class='uil uil-message'></i></button>
                                                            </div>
                                                        </div>
                                                    </div> <!-- end col -->
                                                </div> <!-- end row-->
                                            </form>
                                        </div>
                                    </div> <!-- end col-->
                                </div>
                                <!-- end row -->
                            </div> <!-- end card-body -->
                        </div> <!-- end card -->
                    </div>
                    <!-- end chat area-->
                    <div class="col-lg-2 order-xl-3">
                        <div class="card">
                            <div class="card-body">
                                <h5 style="text-align: center;">채팅상대</h5>
                                <hr/>
                                <div class="participation-list" data-simplebar style="max-height: 582px; min-height: 582px;">

                                </div>
                            </div>
                        </div>
                    </div>
                </div> <!-- end row-->

            </div> <!-- End Content -->
        </div> <!-- content-page -->
    </div> <!-- end wrapper-->
</div>
<!-- END Container -->

<%@ include file="../include/footer.jsp" %>
<script>
    var currentUserId = "${currentUser.memberId}";
</script>
<script src="../../../resources/js/chat.js"></script>

</body>
</html>
