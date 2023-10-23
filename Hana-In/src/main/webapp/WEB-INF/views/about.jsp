<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../../resources/css/bootstrap.css">
</head>
<body>

<jsp:include page="include/header.jsp"/>

<div class="page-section">

    <div class="container">
        <div class="page-banner">
            <div class="row justify-content-center align-items-center h-100">
                <div class="col-md-6">
                    <nav aria-label="Breadcrumb">
                        <ul class="breadcrumb justify-content-center py-0 bg-transparent">
                            <li class="breadcrumb-item"><a href="/">메인</a></li>
                            <li class="breadcrumb-item active">서비스소개</li>
                        </ul>
                    </nav>
                    <h1 class="text-center">서비스소개</h1>
                </div>
            </div>
        </div>
    </div>

    <div class="container">

        <div class="row align-items-center">
            <div class="col-lg-6 py-3">
                <h2 class="title-section">주주제안, 주주행동주의의 새로운 장</h2>
                <div class="divider"></div>
                <p>주주 행동주의는 주식 시장에서 주주들의 권리와 이익을 대표하고, 회사 경영에 직접적인 영향을 미치기 위한 움직임입니다. 이는 단순히 투자의 수익률을 높이기 위한 것이 아닌, 주주와 기업 간의 상생적인 발전을 위한 활동으로 볼 수 있습니다.</p>
                <p>주주제안 서비스는 이러한 주주행동주의의 핵심입니다. 소액주주들이 주주행동주의의 안건을 제시하고, 다른 주주들은 해당 안건에 대한 동참 또는 반대 의견을 표출할 수 있습니다. 이를 통해 주주들은 회사 경영에 대한 자신들의 생각과 의견을 명확하게 전달하며, 회사에 변화를 가져오기 위한 노력을 함께할 수 있습니다.</p>
                <p>하나인의 주주제안 서비스는 주주들의 목소리를 집대성하여, 회사와 주주, 그리고 주주 간의 상호 소통의 장을 만들어줍니다. 주주들의 활발한 참여와 의견 교환을 통해 기업의 미래를 함께 모양하는데 기여하게 됩니다.</p>
            </div>

            <div class="col-lg-6 py-3">
                <div class="img-fluid py-3 text-center">
                    <img src="../../../resources/img/proposal.png" alt="" width="400px">
                </div>
            </div>

        </div>

        <div class="row align-items-center">

            <div class="col-lg-6 py-3">
                <div class="img-fluid py-3 text-center">
                    <img src="../../../resources/img/chatting.png" alt="" width="400px">
                </div>
            </div>

            <div class="col-lg-6 py-3">
                <h2 class="title-section">주주들 간의 연결, 개인 및 단체 채팅방</h2>
                <div class="divider"></div>

                <p>최근 주식 시장은 단순한 투자의 장에서 끝나지 않고, 주주들 간의 깊은 소통과 협력의 필요성이 대두되고 있습니다. 이러한 움직임 속에서 주주들은 자신들의 목소리를 높이기 위해 다양한 플랫폼을 통해 의견을 교환하고 있습니다.</p>
                <p>개인 채팅방에서는 주주 간의 1:1 소통이 가능하여, 더 깊은 투자 전략이나 주식에 대한 정보 교환, 심지어는 투자에 관한 감정적인 부분까지 나눌 수 있습니다. 한편, 단체 채팅방에서는 다양한 주주들의 의견을 한눈에 파악하며, 다양한 주제에 대한 토론을 펼칠 수 있습니다.</p>
                <p>하나인은 주주들의 다양한 소통 요구를 충족시키기 위해 개인 및 단체 채팅방을 제공합니다. 주주들의 진정한 목소리를 듣고, 함께 나누며, 그들만의 특별한 소통의 장을 만들어 가는 것이 우리의 목표입니다.</p>
            </div>

        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-lg-4">
                <div class="card-service">
                    <div class="header">
<%--                        <img src="../../resources/img/services/service-1.svg" alt="">--%>
                        <img src="../../../resources/img/company.png" alt="" width="110px">
                    </div>
                    <div class="body">
                        <h5 class="text-secondary">기업정보</h5>
                        <p>내가 궁금한 주식의 재무 정보, 시장 정보를 확인하고 경쟁사와 함께 비교해보세요!</p>
                        <a href="/stockinfo" class="btn btn-primary">바로가기</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="card-service">
                    <div class="header">
<%--                        <img src="../../resources/img/services/service-2.svg" alt="">--%>
                        <img src="../../../resources/img/market.png" alt="" width="110px">
                    </div>
                    <div class="body">
                        <h5 class="text-secondary">거래소</h5>
                        <p>내 하나증권 계좌와 연동하여 주식을 사고 팔아보세요! 실시간 호가와 이동평균선도 조회할 수 있습니다!</p>
                        <a href="/market" class="btn btn-primary">바로가기</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="card-service">
                    <div class="header">
<%--                        <img src="../../resources/img/services/service-3.svg" alt="">--%>
                        <img src="../../../resources/img/community.png" alt="" width="110px">
                    </div>
                    <div class="body">
                        <h5 class="text-secondary">커뮤니티</h5>
                        <p>인증된 주주들과 함께 주식에 대해 이야기 해보세요! 원하는 조건의 게시물만 조회할 수 있습니다!</p>
                        <a href="/board" class="btn btn-primary">바로가기</a>
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- .container -->
</div> <!-- .page-section -->

<jsp:include page="include/footer.jsp"/>

</body>
</html>