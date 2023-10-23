<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
</head>

<%@ include file="../include/header.jsp" %>

<body class="loading" data-layout="detached" data-layout-config='{"leftSidebarCondensed":false,"darkMode":false, "showRightSidebarOnStart": true}'>

<!-- Start Content-->
<div class="container-fluid">
    <!-- Begin page -->
    <div class="wrapper">
        <div class="content-page">
            <div class="content">
                <div class="row">
                    <div class="col-sm-12">
                        <!-- Profile -->
                        <div class="card">
                            <div class="card-body">
                                ${balancelist }
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

</body>
</html>
