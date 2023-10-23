<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <meta http-equiv="X-UA-Compatible" content="ie=edge">

    <link rel="icon" href="../../resources/img/logo.png" type="image/png">
    <title>HANAIN</title>

    <link rel="stylesheet" href="../../resources/css/maicons.css">
    <link rel="stylesheet" href="../../resources/css/bootstrap.css">
    <link rel="stylesheet" href="../../resources/vendor/animate/animate.css">
    <link rel="stylesheet" href="../../resources/css/theme.css">

    <!-- Owl Carousel CSS -->
    <link rel="stylesheet" href="../../resources/owlcarousel/owl.carousel.css">
    <link rel="stylesheet" href="../../resources/owlcarousel/owl.theme.default.css">
    <style>
        .page-banner {
            height: 450px !important;
        }
        .owl-item {
            margin-top: 20px !important;
        }
    </style>
</head>
<body>

<jsp:include page="include/header.jsp"/>

<div class="page-section" id="first_page">

    <div class="container">
        <div class="page-banner home-banner">
            <div class="owl-carousel owl-theme">
                <!-- 첫 번째 슬라이드 -->
                <div class="item">
                    <div class="row align-items-center flex-wrap-reverse h-100">
                        <div class="col-md-6 wow fadeInLeft">
                            <h1 class="mb-4">투자한 회사의 가치를<br/>높일 수 있는 유일한 방법</h1>
                            <p class="text-lg text-grey mb-5">주주는 단순히 투자자가 아닙니다. <br/>변화의 주역! 우리의 목소리로 기업의 미래를 모양합시다!
                            </p>
                            <a href="#" class="btn btn-primary btn-split">제안하러가기
                                <div class="fab"><span class="mai-play"></span></div>
                            </a>
                        </div>
                        <div class="col-md-6 wow zoomIn">
                            <div class="img-fluid text-center">
                                <img src="../../../resources/img/service.png" alt="" width="300px">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 두 번째 슬라이드 -->
                <div class="item">
                    <div class="row align-items-center flex-wrap-reverse h-100">
                        <div class="col-md-6 wow fadeInLeft">
                            <h1 class="mb-4">주식의 세계,<br/>그 속의 깊은 이야기를 탐험하다</h1>
                            <p class="text-lg text-grey mb-5">다양한 시장 및 재무정보로 경쟁사와의 비교 분석을 넘어서,<br/> 더 깊고 풍부한 투자 지식을 얻어보세요
                            </p>
                            <a href="#" class="btn btn-primary btn-split">기업정보보기
                                <div class="fab"><span class="mai-play"></span></div>
                            </a>
                        </div>
                        <div class="col-md-6 wow zoomIn">
                            <div class="img-fluid text-center">
                                <img src="../../../resources/img/stockinfo.png" alt="" width="300px">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 세 번째 슬라이드 -->
                <div class="item">
                    <div class="row align-items-center flex-wrap-reverse h-100">
                        <div class="col-md-6 wow fadeInLeft">
                            <h1 class="mb-4">실시간 주식 거래의 진수,<br/>손 안에서 전개되는 주식시장</h1>
                            <p class="text-lg text-grey mb-5">실시간 호가 정보와 고급 주가 분석 도구로,<br/>스마트하게 투자하고 빠르게 반응하는 거래 경험을 선사합니다
                            </p>
                            <a href="#" class="btn btn-primary btn-split">거래하러가기
                                <div class="fab"><span class="mai-play"></span></div>
                            </a>
                        </div>
                        <div class="col-md-6 wow zoomIn">
                            <div class="img-fluid text-center">
                                <img src="../../../resources/img/marketmain.png" alt="" width="330px">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 네 번째 슬라이드 -->
                <div class="item">
                    <div class="row align-items-center flex-wrap-reverse h-100">
                        <div class="col-md-6 wow fadeInLeft">
                            <h1 class="mb-4">주주들 간의 강력한 연결 고리,<br/>새로운 소통의 차원을 열다</h1>
                            <p class="text-lg text-grey mb-5">단체 채팅으로 시작하여 개인간의 대화로 이어지는,<br/>주주제안의 힘을 최대한 활용하는 소통의 플랫폼
                            </p>
                            <a href="#" class="btn btn-primary btn-split">채팅하러가기
                                <div class="fab"><span class="mai-play"></span></div>
                            </a>
                        </div>
                        <div class="col-md-6 wow zoomIn">
                            <div class="img-fluid text-center">
                                <img src="../../../resources/img/chatting.png" alt="" width="300px">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 다섯 번째 슬라이드 -->
                <div class="item">
                    <div class="row align-items-center flex-wrap-reverse h-100">
                        <div class="col-md-6 wow fadeInLeft">
                            <h1 class="mb-4">진정한 주주만의 특별한 모임,<br/>고급진 토론의 장을 만나다</h1>
                            <p class="text-lg text-grey mb-5">등급제를 통한 우수한 게시글 필터링과 함께,<br/>같은 생각을 가진 주주들과 깊고 의미있는 대화를 나눠보세요
                            </p>
                            <a href="#" class="btn btn-primary btn-split">커뮤니티가기
                                <div class="fab"><span class="mai-play"></span></div>
                            </a>
                        </div>
                        <div class="col-md-6 wow zoomIn">
                            <div class="img-fluid text-center">
                                <img src="../../../resources/img/communitymain.png" alt="" width="300px" id="community">
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 여섯 번째 슬라이드 -->
                <div class="item">
                    <div class="row align-items-center flex-wrap-reverse h-100">
                        <div class="col-md-6 wow fadeInLeft">
                            <h1 class="mb-4">소액주주의 힘,<br/>새로운 패러다임을 제시하다</h1>
                            <p class="text-lg text-grey mb-5">주주제안을 통해 안건을 제시하고 함께 의사를 표현하세요<br/>시각적 달성 비율과 함께, 동참한 주주들과의 실시간 채팅까지!
                            </p>
                            <a href="#" class="btn btn-primary btn-split">제안하러가기
                                <div class="fab"><span class="mai-play"></span></div>
                            </a>
                        </div>
                        <div class="col-md-6 wow zoomIn">
                            <div class="img-fluid text-center">
                                <img src="../../../resources/img/proposal.png" alt="" width="300px">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
<%--            <a href="#about" class="btn-scroll" data-role="smoothscroll"><span class="mai-arrow-down"></span></a>--%>
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

<div class="page-section" id="about">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-6 py-3 wow fadeInUp">
                <span class="subhead">서비스소개</span>
                <h2 class="title-section">소액주주들의 주주행동주의</h2>
                <div class="divider"></div>
                <p>최근 들어 코리아 디스카운트의 실체를 드러내고 이를 타개하려는 적극적 움직임이 보입니다. 투자 방법론으로서 기관투자자의 전유물로 여겨지던 ‘주주 행동주의’가 바로 그것입니다. 혹자는 올해를 ‘주주 행동주의의 원년’으로 부르기도 할 정도입니다.</p>
                <p>주주라면 누구나 참여가능합니다. 그리고 하나인은 소액주주들끼리 모여 주주행동주의를 실천할 수 있는 온라인 공간을 제공합니다.</p>
                <a href="about" class="btn btn-primary mt-3">서비스 소개</a>
            </div>
            <div class="col-lg-6 py-3 wow fadeInRight">
                <div class="img-fluid py-3 text-center">
<%--                    <img src="../../resources/img/about_frame.png" alt="">--%>
    <img src="../../../resources/img/service.png" alt="" width="450px">
                </div>
            </div>
        </div>
    </div> <!-- .container -->
</div> <!-- .page-section -->
<%--
<div class="page-section bg-light">
    <div class="container">
        <div class="text-center wow fadeInUp">
            <div class="subhead">Our services</div>
            <h2 class="title-section">How SEO Team Can Help</h2>
            <div class="divider mx-auto"></div>
        </div>

        <div class="row">
            <div class="col-sm-6 col-lg-4 col-xl-3 py-3 wow zoomIn">
                <div class="features">
                    <div class="header mb-3">
                        <span class="mai-business"></span>
                    </div>
                    <h5>OnSite SEO</h5>
                    <p>We analyse your website's structure, internal architecture & other key</p>
                </div>
            </div>
            <div class="col-sm-6 col-lg-4 col-xl-3 py-3 wow zoomIn">
                <div class="features">
                    <div class="header mb-3">
                        <span class="mai-business"></span>
                    </div>
                    <h5>OnSite SEO</h5>
                    <p>We analyse your website's structure, internal architecture & other key</p>
                </div>
            </div>
            <div class="col-sm-6 col-lg-4 col-xl-3 py-3 wow zoomIn">
                <div class="features">
                    <div class="header mb-3">
                        <span class="mai-business"></span>
                    </div>
                    <h5>OnSite SEO</h5>
                    <p>We analyse your website's structure, internal architecture & other key</p>
                </div>
            </div>
            <div class="col-sm-6 col-lg-4 col-xl-3 py-3 wow zoomIn">
                <div class="features">
                    <div class="header mb-3">
                        <span class="mai-business"></span>
                    </div>
                    <h5>OnSite SEO</h5>
                    <p>We analyse your website's structure, internal architecture & other key</p>
                </div>
            </div>
            <div class="col-sm-6 col-lg-4 col-xl-3 py-3 wow zoomIn">
                <div class="features">
                    <div class="header mb-3">
                        <span class="mai-business"></span>
                    </div>
                    <h5>OnSite SEO</h5>
                    <p>We analyse your website's structure, internal architecture & other key</p>
                </div>
            </div>
            <div class="col-sm-6 col-lg-4 col-xl-3 py-3 wow zoomIn">
                <div class="features">
                    <div class="header mb-3">
                        <span class="mai-business"></span>
                    </div>
                    <h5>OnSite SEO</h5>
                    <p>We analyse your website's structure, internal architecture & other key</p>
                </div>
            </div>
            <div class="col-sm-6 col-lg-4 col-xl-3 py-3 wow zoomIn">
                <div class="features">
                    <div class="header mb-3">
                        <span class="mai-business"></span>
                    </div>
                    <h5>OnSite SEO</h5>
                    <p>We analyse your website's structure, internal architecture & other key</p>
                </div>
            </div>
            <div class="col-sm-6 col-lg-4 col-xl-3 py-3 wow zoomIn">
                <div class="features">
                    <div class="header mb-3">
                        <span class="mai-business"></span>
                    </div>
                    <h5>OnSite SEO</h5>
                    <p>We analyse your website's structure, internal architecture & other key</p>
                </div>
            </div>
        </div>

    </div> <!-- .container -->
</div> <!-- .page-section -->
--%>
<div class="page-section banner-seo-check">
    <div class="wrap bg-image" style="background-image: url(../../resources/img/searchbg.jpg);">
        <div class="container text-center">
            <div class="row justify-content-center wow fadeInUp">
                <div class="col-lg-8">
                    <h2 class="mb-4">주주 제안 검색하기</h2>
                    <form action="#">
                        <input type="text" class="form-control" placeholder="">
                        <button type="submit" class="btn" style="background-color:#008485; color: white;">검색</button>
                    </form>
                </div>
            </div>
        </div> <!-- .container -->
    </div> <!-- .wrap -->
</div> <!-- .page-section -->

<%--
<div class="page-section">
    <div class="container">
        <div class="text-center wow fadeInUp">
            <div class="subhead">Pricing Plan</div>
            <h2 class="title-section">Choose plan the right for you</h2>
            <div class="divider mx-auto"></div>
        </div>
        <div class="row mt-5">
            <div class="col-lg-4 py-3 wow zoomIn">
                <div class="card-pricing">
                    <div class="header">
                        <div class="pricing-type">Basic</div>
                        <div class="price">
                            <span class="dollar">$</span>
                            <h1>39<span class="suffix">.99</span></h1>
                        </div>
                        <h5>Per Month</h5>
                    </div>
                    <div class="body">
                        <p>25 Analytics <span class="suffix">Campaign</span></p>
                        <p>1,300 Change <span class="suffix">Keywords</span></p>
                        <p>Social Media <span class="suffix">Reviews</span></p>
                        <p>1 Free <span class="suffix">Optimization</span></p>
                        <p>24/7 <span class="suffix">Support</span></p>
                    </div>
                    <div class="footer">
                        <a href="#" class="btn btn-pricing btn-block">Subscribe</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 py-3 wow zoomIn">
                <div class="card-pricing marked">
                    <div class="header">
                        <div class="pricing-type">Standar</div>
                        <div class="price">
                            <span class="dollar">$</span>
                            <h1>59<span class="suffix">.99</span></h1>
                        </div>
                        <h5>Per Month</h5>
                    </div>
                    <div class="body">
                        <p>25 Analytics <span class="suffix">Campaign</span></p>
                        <p>1,300 Change <span class="suffix">Keywords</span></p>
                        <p>Social Media <span class="suffix">Reviews</span></p>
                        <p>1 Free <span class="suffix">Optimization</span></p>
                        <p>24/7 <span class="suffix">Support</span></p>
                    </div>
                    <div class="footer">
                        <a href="#" class="btn btn-pricing btn-block">Subscribe</a>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 py-3 wow zoomIn">
                <div class="card-pricing">
                    <div class="header">
                        <div class="pricing-type">Professional</div>
                        <div class="price">
                            <span class="dollar">$</span>
                            <h1>99<span class="suffix">.99</span></h1>
                        </div>
                        <h5>Per Month</h5>
                    </div>
                    <div class="body">
                        <p>25 Analytics <span class="suffix">Campaign</span></p>
                        <p>1,300 Change <span class="suffix">Keywords</span></p>
                        <p>Social Media <span class="suffix">Reviews</span></p>
                        <p>1 Free <span class="suffix">Optimization</span></p>
                        <p>24/7 <span class="suffix">Support</span></p>
                    </div>
                    <div class="footer">
                        <a href="#" class="btn btn-pricing btn-block">Subscribe</a>
                    </div>
                </div>
            </div>

        </div>
    </div> <!-- .container -->
</div> <!-- .page-section -->

<!-- Banner info -->
<div class="page-section banner-info">
    <div class="wrap bg-image" style="background-image: url(../../resources/img/bg_pattern.svg);">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 py-3 pr-lg-5 wow fadeInUp">
                    <h2 class="title-section">SEO to Improve Brand <br> Visibility</h2>
                    <div class="divider"></div>
                    <p>We're an experienced and talented team of passionate consultants who breathe with search engine
                        marketing.</p>

                    <ul class="theme-list theme-list-light text-white">
                        <li>
                            <div class="h5">SEO Content Strategy</div>
                            <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
                                tempor</p>
                        </li>
                        <li>
                            <div class="h5">B2B SEO</div>
                            <p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
                                tempor</p>
                        </li>
                    </ul>
                </div>
                <div class="col-lg-6 py-3 wow fadeInRight">
                    <div class="img-fluid text-center">
                        <img src="../../resources/img/banner_image_2.svg" alt="">
                    </div>
                </div>
            </div>
        </div>
    </div> <!-- .wrap -->
</div> <!-- .page-section -->
--%>
<!-- Blog -->
<div class="page-section">
    <div class="container">
        <div class="text-center wow fadeInUp">
            <div class="subhead">최신 뉴스</div>
            <h2 class="title-section">행동주의 관련 최신 뉴스</h2>
            <div class="divider mx-auto"></div>
        </div>

        <div class="row mt-5">
            <div class="col-lg-4 py-3 wow fadeInUp">
                <div class="card-blog">
                    <div class="header">
                        <div class="post-thumb">
                            <img src="https://newsimg.sedaily.com/2023/09/20/29UR9EQP0N_2.png" alt="">
                        </div>
                    </div>
                    <div class="body">
                        <h5 class="post-title"><a href="https://www.sedaily.com/NewsView/29UR9EQP0N">찬바람 부니 다시 고개 드는 주주 행동주의</a></h5>
                        <div class="post-date">Posted on <a href="#">20 Sep 2023</a></div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 py-3 wow fadeInUp">
                <div class="card-blog">
                    <div class="header">
                        <div class="post-thumb">
                            <img src="https://cdn.bloter.net/news/photo/202309/606080_209462_2437.png" alt="">
                        </div>
                    </div>
                    <div class="body">
                        <h5 class="post-title"><a href="https://www.bloter.net/news/articleView.html?idxno=606080">[지배구조 새 물결]① '형편없는 상장사, 우리가 직접 바꾼다' 원년 맞이한 주주 행동주의</a></h5>
                        <div class="post-date">Posted on <a href="#">05 Sep 2023</a></div>
                    </div>
                </div>
            </div>

            <div class="col-lg-4 py-3 wow fadeInUp">
                <div class="card-blog">
                    <div class="header">
                        <div class="post-thumb">
                            <img src="http://www.naeil.com/AttachFile/PREV/2023/09/20/00236937_P.jpg" alt="">
                        </div>
                    </div>
                    <div class="body">
                        <h5 class="post-title"><a href="http://www.naeil.com/news_view/?id_art=474399">"주주환원 가치주에 주목 … 장기적 주가 상승 전망"</a></h5>
                        <div class="post-date">Posted on <a href="#">20 Sep 2023</a></div>
                    </div>
                </div>
            </div>

            <div class="col-12 mt-4 text-center wow fadeInUp">
                <a href="blog" class="btn btn-primary">더보기</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="include/footer.jsp"/>

<!-- Owl Carousel -->
<script src="../../resources/owlcarousel/owl.carousel.js"></script>
<script src="../../resources/owlcarousel/owl.autoplay.js"></script>
<script src="../../resources/owlcarousel/owl.navigation.js"></script>
<script>
    $(function () {
        $('.owl-carousel').owlCarousel({
            items: 1,
            animateOut: 'fadeOut',
            margin: 10,
            loop: true,
            // nav: true,
            // navText: ['이전', '다음'],
            autoplay: true,
            autoplayTimeout: 4000,
            autoplayHoverPause: true,
            smartSpeed: 1000
        });
    });
</script>

</body>
</html>