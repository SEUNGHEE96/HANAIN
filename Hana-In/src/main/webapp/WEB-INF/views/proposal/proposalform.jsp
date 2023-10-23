<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Quill css -->
    <link href="../../../resources/assets/css/vendor/quill.core.css" rel="stylesheet" type="text/css" />
    <link href="../../../resources/assets/css/vendor/quill.snow.css" rel="stylesheet" type="text/css" />
    <style>
        .position-relative {
            width: 50%;
        }
        #datePickersContainer {
            display: flex;
            justify-content: space-between;
            gap: 10px; /* Optional, if you want some space between them */
        }
        .select2-search__field {
            width:90% !important;
        }
        .card-img-top {
            width: 150px !important;
            height: 150px !important;
            margin: 0 auto !important;
            display: flex;
            border-radius: 30% !important;
        }
        .d-block {
            border-radius: 10% !important;
            padding-top: 20px;
        }
        .form-control {
            height: auto !important;
        }
        .buttons {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
        }
        .rounded-pill {
            margin: 0 30px;
        }
    </style>
    <!-- quill js -->
    <script src="../../../resources/assets/js/vendor/quill.min.js"></script>
    <!-- quill Init js-->
    <script src="../../../resources/assets/js/pages/demo.quilljs.js"></script>
</head>
<body class="loading" data-layout="detached" data-layout-config='{"leftSidebarCondensed":false,"darkMode":false, "showRightSidebarOnStart": true}'>

<%@ include file="../include/header.jsp" %>

<script>
    $(document).ready(function() {

        $('#stockSelect').on('change', function() {
            var input = $(this).val();

            $.ajax({
                url: '/getStockInfo', // Endpoint to fetch stock info
                method: 'GET',
                data: {
                    'input' : input
                },
                success: function(data) {

                    var resultHtml = '';
                    resultHtml += '<img class="card-img-top" src="../../../resources/img/logo/' + data.isin + '.png" alt="Card image cap">';
                    resultHtml += '<div class="card-body">';
                    resultHtml += '<h5 class="card-title">' + data.stockName + '</h5>';
                    resultHtml += '<p class="card-text">' + data.stockName + '의 주식 정보입니다.</p>';
                    resultHtml += '<a href="javascript: void(0);" class="card-link text-custom">거래소</a>';
                    resultHtml += '<a href="javascript: void(0);" class="card-link text-custom">커뮤니티</a>';
                    resultHtml += '</div>';
                    $('#stockInfo').html(resultHtml);
                },
                error: function() {
                    alert('Error fetching stock info.');
                }
            });
        });
    });
</script>

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

                                <form id="postForm" action="/createPost" method="post">
                                <input type="hidden" name="memberId" id="memberId">
                                <div class="row">
                                    <div class="col-xl-8">
                                        <div class="mb-3">
                                            <label for="projectname" class="form-label">제목</label>
                                            <input type="text" id="projectname" name="title" class="form-control" placeholder="Enter project name">
                                        </div>

                                        <div class="mb-3">
                                            <label for="project-overview" class="form-label">내용</label>
                                            <!-- HTML -->
                                            <div id="snow-editor" style="height: 300px;">

                                            </div>
                                            <textarea name="content" id="hidden-textarea" style="display:none;"></textarea>
                                        </div>

                                        <div id="datePickersContainer">
                                            <!-- Date View -->
                                            <div class="mb-3 position-relative" id="datepicker1">
                                                <label class="form-label">시작일</label>
                                                <input type="text" class="form-control" name="startDate" data-provide="datepicker" data-date-container="#datepicker1" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                                            </div>

                                            <div class="mb-3 position-relative" id="datepicker2">
                                                <label class="form-label">마감일</label>
                                                <input type="text" class="form-control" name="endDate" data-provide="datepicker" data-date-container="#datepicker2" data-date-format="yyyy-mm-dd" data-date-autoclose="true">
                                            </div>
                                        </div>

                                    </div> <!-- end col-->

                                    <div class="col-xl-4">

                                        <div class="card d-block" id="stockInfo">
                                            <img class="card-img-top" src="../../../resources/img/none.png" alt="Card image cap">
                                            <div class="card-body">
                                                <h5 class="card-title">선택된 주식이 없습니다.</h5>
                                                <p class="card-text">의견을 제안할 주식을 선택해 주세요</p>
                                                <a href="javascript: void(0);" class="card-link text-custom">거래소</a>
                                                <a href="javascript: void(0);" class="card-link text-custom">커뮤니티</a>
                                            </div> <!-- end card-body-->
                                        </div> <!-- end card-->

                                        <div class="mb-3">
                                            <%--@declare id="project-overview"--%>
                                            <label for="project-overview" class="form-label">보유종목</label>
                                            <select id="stockSelect" name="isin" class="form-control select2" data-toggle="select2">
                                            <c:forEach items="${userStocks}" var="stock" varStatus="status">
                                                <option value="${stock.isin}">${stock.stockName}</option>
                                            </c:forEach>
                                            </select>
                                        </div>

                                        <div class="mb-3">
                                            <label for="example-fileinput" class="form-label">파일업로드</label>
                                            <input type="file" id="example-fileinput" class="form-control">
                                        </div>

                                    </div> <!-- end col-->
                                </div>
                                <!-- end row -->
                                <div class="buttons">
                                    <button type="submit" class="btn btn-primary rounded-pill">작성하기</button>
                                    <button type="reset" class="btn btn-light rounded-pill">닫기</button>
                                </div>
                                </form>
                            </div>
                            <!-- end card-body -->
                        </div> <!-- end card-->
                    </div> <!-- end col-->
                </div>
                <!-- end row-->
            </div> <!-- End Content -->
        </div> <!-- content-page -->
    </div> <!-- end wrapper-->
</div>
<!-- END Container -->

<%@ include file="../include/footer.jsp" %>

<script>
    var quill = new Quill('#snow-editor', {
        theme: 'snow'
    });

    var memberId = "${currentUser.memberId }";

    document.getElementById('postForm').addEventListener('submit', function() {
        var content = quill.root.innerHTML; // Quill 에디터로부터 HTML 내용을 가져옵니다.
        document.getElementById('hidden-textarea').value = content;
        document.getElementById('memberId').value = memberId;
    });
</script>

</body>
</html>