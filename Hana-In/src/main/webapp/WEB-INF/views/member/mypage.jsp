<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <style>
        .pagination {
            padding-top: 15px;
            justify-content: center;
        }
        .bg-info {
            background-color: yellow !important;
        }
        #submit-verification {
            margin-top: 1.5rem;
        }
        #retry-verification {
            margin-top: 1.5rem;
        }
        #toll-free-box {
            background-color: #AD9A5F;
        }
    </style>
</head>

<%@ include file="../include/header.jsp" %>

<body class="loading" data-layout="detached"
      data-layout-config='{"leftSidebarCondensed":false,"darkMode":false, "showRightSidebarOnStart": true}'>

<!-- Start Content-->
<div class="container-fluid">

    <!-- Begin page -->
    <div class="wrapper">

        <div class="content-page">
            <div class="content">
                <div class="row">
                    <div class="col-sm-12">
                        <!-- Profile -->
                        <div class="card bg-primary">
                            <div class="card-body profile-user-box">

                                <div class="row">
                                    <div class="col-sm-8">
                                        <div class="row align-items-center">
                                            <div class="col-auto">
                                                <div class="avatar-lg">
                                                    <img src="../../../resources/img/person/${currentUser.memberId}.jpg"
                                                         alt="" class="rounded-circle img-thumbnail">
                                                </div>
                                            </div>
                                            <div class="col">
                                                <div>
                                                    <h4 class="mt-1 mb-1 text-white">${currentUser.name}</h4>
                                                    <p class="font-13 text-white-50"> 주주 </p>

<%--                                                    <ul class="mb-0 list-inline text-light">--%>
<%--                                                        <li class="list-inline-item me-3">--%>
<%--                                                            <h5 class="mb-1">$ 25,184</h5>--%>
<%--                                                            <p class="mb-0 font-13 text-white-50">Total Revenue</p>--%>
<%--                                                        </li>--%>
<%--                                                        <li class="list-inline-item">--%>
<%--                                                            <h5 class="mb-1">5482</h5>--%>
<%--                                                            <p class="mb-0 font-13 text-white-50">Number of Orders</p>--%>
<%--                                                        </li>--%>
<%--                                                    </ul>--%>
                                                </div>
                                            </div>
                                        </div>
                                    </div> <!-- end col-->

                                    <div class="col-sm-4">
                                        <div class="text-center mt-sm-0 mt-3 text-sm-end">
                                            <button type="button" class="btn btn-light">
                                                <i class="mdi mdi-account-edit me-1"></i>정보 수정
                                            </button>
                                        </div>
                                    </div> <!-- end col-->
                                </div> <!-- end row -->

                            </div> <!-- end card-body/ profile-user-box-->
                        </div><!--end profile/ card -->
                    </div> <!-- end col-->
                </div>
                <!-- end row -->


                <div class="row">
                    <div class="col-xl-4">
                        <!-- Personal-Information -->
                        <div class="card">
                            <div class="card-body">
                                <h4 class="header-title mt-0 mb-3">회원정보</h4>
<%--                                <p class="text-muted font-13">--%>
<%--                                    Hye, I’m Michael Franklin residing in this beautiful world. I create websites and--%>
<%--                                    mobile apps with great UX and UI design. I have done work with big companies like--%>
<%--                                    Nokia, Google and Yahoo. Meet me or Contact me for any queries. One Extra line for--%>
<%--                                    filling space. Fill as many you want.--%>
<%--                                </p>--%>
<%--                                --%>
<%--                                <hr/>--%>

                                <div class="text-start">
                                    <p class="text-muted"><strong>이름 :</strong> <span class="ms-2">${currentUser.name}</span>
                                    </p>

                                    <p class="text-muted"><strong>연락처 :</strong><span
                                            class="ms-2">${currentUser.phone}</span></p>

                                    <p class="text-muted"><strong>이메일 :</strong> <span class="ms-2">${currentUser.email}</span>
                                    </p>

                                    <p class="text-muted"><strong>주소 :</strong> <span class="ms-2">${currentUser.address}</span></p>

                                    <p class="text-muted"><strong>본인인증 :</strong>
                                        <c:choose>
                                            <c:when test="${currentUser.status == 0}">
                                                <!-- Signup modal-->
                                                <button type="button" class="badge bg-primary rounded-pill" data-bs-toggle="modal" data-bs-target="#signup-modal" style="border-color: #008485">본인인증 하기</button>
                                                <div id="signup-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                                                    <div class="modal-dialog modal-dialog-centered">
                                                        <div class="modal-content">

                                                            <div class="modal-body">
                                                                <div class="text-center mt-2 mb-4">
<%--                                                                    <a href="index.html" class="text-success">--%>
<%--                                                                        <span><img src="assets/images/logo-dark.png" alt="" height="18"></span>--%>
<%--                                                                    </a>--%>
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
                                                        </div><!-- /.modal-content -->
                                                    </div><!-- /.modal-dialog -->
                                                </div><!-- /.modal -->
                                            </c:when>
                                            <c:when test="${currentUser.status == 1}">
                                                <span class="ms-2">인증완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- 만약 필요하다면, 다른 상태를 위한 기본 텍스트를 여기에 추가하세요. -->
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
<%--                                    <p class="text-muted mb-0" id="tooltip-container"><strong>Elsewhere :</strong>--%>
<%--                                        <a class="d-inline-block ms-2 text-muted" data-bs-container="#tooltip-container"--%>
<%--                                           data-bs-placement="top" data-bs-toggle="tooltip" href="" title="Facebook"><i--%>
<%--                                                class="mdi mdi-facebook"></i></a>--%>
<%--                                        <a class="d-inline-block ms-2 text-muted" data-bs-container="#tooltip-container"--%>
<%--                                           data-bs-placement="top" data-bs-toggle="tooltip" href="" title="Twitter"><i--%>
<%--                                                class="mdi mdi-twitter"></i></a>--%>
<%--                                        <a class="d-inline-block ms-2 text-muted" data-bs-container="#tooltip-container"--%>
<%--                                           data-bs-placement="top" data-bs-toggle="tooltip" href="" title="Skype"><i--%>
<%--                                                class="mdi mdi-skype"></i></a>--%>
<%--                                    </p>--%>
                                </div>
                            </div>
                        </div>
                        <!-- Personal-Information -->

                        <!-- Toll free number box-->
                        <div class="card text-white bg-info overflow-hidden">
                            <div class="card-body" id="toll-free-box">
                                <div class="toll-free-box text-center">
                                    <h4> <i class="mdi mdi-headset"></i> 도움이 필요하신 가요? 1588-3111 </h4>
                                </div>
                            </div> <!-- end card-body-->
                        </div> <!-- end card-->
                        <!-- End Toll free number box-->

                        <!-- Messages-->
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h4 class="header-title">채팅</h4>
                                    <a href="/chat" style="font-size: 1.1em; color: black;">→</a>
                                </div>
                                <div class="inbox-widget">
                                    <c:set var="endIndex" value="${allChatRoomList.size() <= 5 ? allChatRoomList.size() : 5}" />
                                    <c:forEach items="${allChatRoomList}" var="chatRoom" begin="0" end="${endIndex - 1}">
                                    <div class="inbox-item">
                                        <div class="inbox-item-img"><img src="../../../resources/img/person/${chatRoom.lastMessage.memberId}.jpg"
                                                class="rounded-circle" alt=""></div>
                                        <p class="inbox-item-author">${chatRoom.title}</p>
                                        <p class="inbox-item-text">${chatRoom.lastMessage.content}</p>
                                        <p class="inbox-item-date">
                                            <a href="#" class="btn btn-sm btn-link text-info font-13">답장</a>
                                        </p>
                                    </div>
                                    </c:forEach>
                                </div> <!-- end inbox-widget -->
                            </div> <!-- end card-body-->
                        </div> <!-- end card-->

                    </div> <!-- end col-->

                    <div class="col-xl-8">
                        <div class="card">
                            <div class="card-body">
                                <div class="dropdown float-end">
                                    <a href="#" class="dropdown-toggle arrow-none card-drop" data-bs-toggle="dropdown"
                                       aria-expanded="false">
                                        <i class="mdi mdi-dots-vertical"></i>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-end">
                                        <!-- item-->
                                        <a href="javascript:void(0);" class="dropdown-item">Weekly Report</a>
                                        <!-- item-->
                                        <a href="javascript:void(0);" class="dropdown-item">Monthly Report</a>
                                        <!-- item-->
                                        <a href="javascript:void(0);" class="dropdown-item">Action</a>
                                        <!-- item-->
                                        <a href="javascript:void(0);" class="dropdown-item">Settings</a>
                                    </div>
                                </div>
                                <h4 class="header-title mb-4">주주제안 달성도</h4>

                                <div dir="ltr">
                                    <div class="mt-3 chartjs-chart" style="height: 320px;">
                                        <canvas id="task-area-chart" data-bgColor="#536de6"
                                                data-borderColor="#536de6"></canvas>
                                    </div>
                                </div>

                            </div> <!-- end card body-->
                        </div> <!-- end card -->

                        <div class="card">
                            <div class="card-body">
                                <div class="dropdown float-end">
                                    <a href="#" class="dropdown-toggle arrow-none card-drop" data-bs-toggle="dropdown"
                                       aria-expanded="false">
                                        <i class="mdi mdi-dots-vertical"></i>
                                    </a>
                                    <div class="dropdown-menu dropdown-menu-end">
                                        <!-- item-->
                                        <a href="javascript:void(0);" class="dropdown-item">Weekly Report</a>
                                        <!-- item-->
                                        <a href="javascript:void(0);" class="dropdown-item">Monthly Report</a>
                                        <!-- item-->
                                        <a href="javascript:void(0);" class="dropdown-item">Action</a>
                                        <!-- item-->
                                        <a href="javascript:void(0);" class="dropdown-item">Settings</a>
                                    </div>
                                </div>
                                <h4 class="header-title mb-3">주주제안 상세내역</h4>

                                <p>총 ${totalProposals}개의 주주제안 중 진행 중 : <b>${countOnGoing}개</b> </p>

                                <div class="table-responsive">
                                    <table class="table table-centered table-nowrap table-hover mb-0">
                                        <tbody>
                                        <c:forEach items="${participatedProposalList}" var="proposal">

                                            <fmt:parseDate value="${proposal.startDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedStartDate"/>
                                            <fmt:parseDate value="${proposal.endDate}" pattern="yyyy-MM-dd HH:mm:ss" var="parsedEndDate"/>

                                            <c:set var="timeDiff1" value="${now.time - parsedEndDate.time}" />
                                            <c:set var="timeDiff2" value="${now.time - parsedStartDate.time}" />

                                            <c:set var="days1" value="${Math.floor(timeDiff1 / 86400000).longValue()}" />

                                            <c:set var="minutes" value="${Math.floor(timeDiff2 / 60000 % 60).longValue()}" />
                                            <c:set var="hours" value="${Math.floor(timeDiff2 / 3600000 % 24).longValue()}" />
                                            <c:set var="days" value="${Math.floor(timeDiff2 / 86400000).longValue()}" />
                                            <tr>
                                                <td>
                                                    <h5 class="font-14 my-1"><a href="javascript:void(0);" class="text-body">${proposal.proposalId} : ${proposal.title}</a></h5>
                                                    <span class="text-muted font-13">
                                                    <c:choose>
                                                        <c:when test="${days1 < 0}">
                                                            ${Math.abs(days1)}일 이내 마감
                                                        </c:when>
                                                        <c:otherwise>
                                                            ${days1}일 전 마감
                                                        </c:otherwise>
                                                    </c:choose>
                                                </span>
                                                </td>
                                                <td>
                                                    <span class="text-muted font-13">상태</span> <br/>
                                                    <c:choose>
                                                        <c:when test="${proposal.status == 2}">
                                                            <span class="badge badge-danger-lighten">기간만료</span>
                                                        </c:when>
                                                        <c:when test="${proposal.status == 1}">
                                                            <span class="badge badge-success-lighten">연대완료</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge badge-warning-lighten">진행중</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <span class="text-muted font-13">제안 작성자</span>
                                                    <h5 class="font-14 mt-1 fw-normal">${proposal.memberId}</h5>
                                                </td>
                                                <td>
                                                    <span class="text-muted font-13">시간 경과</span>
                                                    <h5 class="font-14 mt-1 fw-normal">
                                                        <c:choose>
                                                            <c:when test="${days > 0}">
                                                                ${days}일
                                                            </c:when>
                                                            <c:otherwise></c:otherwise>
                                                        </c:choose>
                                                            ${hours}시간 ${minutes}분
                                                    </h5>
                                                </td>
                                                <c:choose>
                                                    <c:when test="${proposal.memberId eq currentUser.memberId}">
                                                        <td class="table-action" style="width: 90px;">
                                                            <a href="javascript: void(0);" class="action-icon"> <i class="mdi mdi-pencil"></i></a>
                                                            <a href="javascript: void(0);" class="action-icon"> <i class="mdi mdi-delete"></i></a>
                                                        </td>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <td class="table-action" style="width: 90px;">
                                                        </td>
                                                    </c:otherwise>
                                                </c:choose>
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
                                                <li class="page-item"><a class="page-link" href="/mypage?page=${i}">${i}</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <li class="page-item">
                                        <a class="page-link" href="javascript: void(0);" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </div> <!-- end card body-->
                        </div> <!-- end card -->
                    </div>
                    <!-- end col -->
                </div>
                <!-- end row -->
            </div> <!-- End Content -->
        </div> <!-- content-page -->
    </div> <!-- end wrapper-->
</div>
<!-- END Container -->

<%@ include file="../include/footer.jsp" %>

<script src="../../../resources/assets/js/vendor/Chart.bundle.min.js"></script>
<script src="../../../resources/assets/js/pages/demo.profile.js"></script>
<script src="../../../resources/assets/js/pages/demo.dashboard-projects.js"></script>

<script type="text/javascript">
    $(document).ready(function () {
        // 주주제안 달성도 차트 관련 코드

        // Java 객체를 JavaScript 객체로 변환
        var participatedProposalList = [
            <c:forEach var="proposal" items="${participatedProposalList2}" varStatus="loop">
            {
                "proposalId": ${proposal.proposalId},
                "memberId": "${proposal.memberId}",
                "isin": "${proposal.isin}",
                "title": "${proposal.title}",
                "content": "${proposal.content}",
                "startDate": "${proposal.startDate}",
                "endDate": "${proposal.endDate}",
                "regDate": "${proposal.regDate}",
                "rate1": ${proposal.rate1},
                "rate2": ${proposal.rate2},
                "viewCount": ${proposal.viewCount},
                "likeCount": ${proposal.likeCount},
                "status": ${proposal.status}
            }<c:if test="${not loop.last}">,</c:if>
            </c:forEach>
        ];

        var labels = [];
        var data = [];

        // ProposalDTO 객체들을 순회하며, labels와 data 배열을 만듭니다.
        for (var i = 0; i < participatedProposalList.length; i++) {
            var proposal = participatedProposalList[i];
            labels.push('Proposal ' + proposal.proposalId); // Proposal의 Id를 사용하여 라벨을 만듭니다.
            data.push(Math.max(proposal.rate1, proposal.rate2)); // rate1과 rate2 중 더 큰 값을 데이터로 사용합니다.
        }

        var canvasId = 'task-area-chart';
        var container = $('#' + canvasId).parent();

        // 기존 차트의 인스턴스를 얻습니다.
        // var oldChartInstance = $('#task-area-chart').data('_chartInstance');
        //
        // // 기존 차트의 옵션을 얻습니다.
        // var oldOptions = oldChartInstance ? oldChartInstance.options : {};

        // 기존의 <canvas> 엘리먼트를 제거
        $('#' + canvasId).remove();

        // 새로운 <canvas> 엘리먼트를 생성
        var newCanvas = $('<canvas>').attr('id', canvasId);
        container.append(newCanvas);

        var ctx = newCanvas.get(0).getContext('2d');

        var myChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: $('#task-area-chart').data('bgcolor') || '#727cf5',
                    borderColor: $('#task-area-chart').data('bordercolor') || '#727cf5'
                }]
            },
            // options: oldOptions // 기존 차트의 옵션을 사용
            options: {
                maintainAspectRatio: false,
                legend: { display: false },
                tooltips: { intersect: false },
                hover: { intersect: true },
                plugins: { filler: { propagate: false } },
                scales: {
                    xAxes: [{
                        barPercentage: .7,
                        categoryPercentage: .5,
                        reverse: true,
                        gridLines: { color: "rgba(0,0,0,0.05)" }
                    }],
                    yAxes: [{
                        ticks: { stepSize: 10, display: false },
                        min: 10,
                        max: 100,
                        display: true,
                        borderDash: [5, 5],
                        gridLines: { color: "rgba(0,0,0,0)", fontColor: "#fff" }
                    }]
                }
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
                success: function(response) {
                    alert('인증 성공');
                    $('#signup-modal').modal('hide'); // 모달 닫기
                    location.reload();
                },
                error: function(error) {
                    alert('인증 실패');
                    $('#signup-modal').modal('hide'); // 모달 닫기
                    location.reload();
                }
            });
        });
    });
</script>

</body>
</html>
