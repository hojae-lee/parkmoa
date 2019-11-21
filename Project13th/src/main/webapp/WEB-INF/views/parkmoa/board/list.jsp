<!DOCTYPE HTML>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- saved from url=(0040)https://www.goodchoice.kr/product/home/1 -->
<HTML lang="ko">
<HEAD>
<META content="IE=11.0000" http-equiv="X-UA-Compatible">

<META name="viewport"
   content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">

<META http-equiv="X-UA-Compatible" content="IE=edge">
<META http-equiv="Content-Type">
<!-- <LINK href="./resources/owl.carousel.css" rel="stylesheet"> -->
<!-- <LINK href="./resources/jquery-ui.css" rel="stylesheet"> -->
<LINK href="../../resources/product.css" rel="stylesheet">

<LINK href="//image.goodchoice.kr/images/web_v3/h1_logo_mo.png"
   rel="apple-touch-icon">
<LINK href="//image.goodchoice.kr/images/web_v3/icon_76.png"
   rel="apple-touch-icon" sizes="76x76">
<LINK href="//image.goodchoice.kr/images/web_v3/icon_120.png"
   rel="apple-touch-icon" sizes="120x120">
<LINK href="//image.goodchoice.kr/images/web_v3/icon_152.png"
   rel="apple-touch-icon" sizes="152x152">

<title>Parkmoa - Home</title>
<link rel="icon" href="../../img/Fevicon.png" type="image/png">
<!-- <LINK href="./resources/common.css" rel="stylesheet"> -->
<link rel="stylesheet" href="../../vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="../../vendors/fontawesome/css/all.min.css">
<link rel="stylesheet"
   href="../../vendors/themify-icons/themify-icons.css">
<link rel="stylesheet" href="../../vendors/linericon/style.css">
<link rel="stylesheet"
   href="../../vendors/owl-carousel/owl.theme.default.min.css">
<link rel="stylesheet"
   href="../../vendors/owl-carousel/owl.carousel.min.css">
<!-- <link rel="stylesheet" href="../../vendors/Magnific-Popup/magnific-popup.css"> -->

<link rel="stylesheet" href="../../css/style.css">
<link rel="stylesheet" href="../../css/swiper.css">
<link rel="stylesheet" href="../../css/main.css">
<link type="text/css" rel="stylesheet" href="css/reset.css"
   media="screen" />
<link type="text/css" rel="stylesheet" href="css/js-load.css"
   media="screen" />
<!-- <LINK href="https://www.goodchoice.kr/product/home/1" rel="canonical"> -->
<SCRIPT src="../../resources/jquery-1.12.4.min.js"
   type="text/javascript"></SCRIPT>
<SCRIPT>(function(a,b,c){if(c in b&&b[c]){var d,e=a.location,f=/^(a|html)$/i;a.addEventListener("click",function(a){d=a.target;while(!f.test(d.nodeName))d    =d.parentNode;"href"in d&&(d.href.indexOf("http")||~d.href.indexOf(e.host))&&(a.preventDefault(),e.href=d.href)},!1)}})(document,window.navigator,"standalone")</SCRIPT>
<META name="GENERATOR" content="MSHTML 11.00.10570.1001">
<style>
.out {
   width: 100%;
   text-align: center;
   border: 1px solid black;
   padding: 20px;
   margin: 15px;
}

.in {
   display: inline-block;
   width: 50%;
   height: 100px;
   margin-left: 100px;
}

.js-load {
   display: none;
}

.js-load.active {
   display: block;
}

.is_comp.js-load:after {
   display: none;
}

.btn-wrap, .lists, .main {
   display: block;
}

.main {
   max-width: 640px;
   margin: 0 auto;
}

.lists {
   margin-bottom: 4rem;
}

.lists__item {
   background: #59b1eb;
   padding: 20px;
   background: #EEE;
}

.btn-wrap {
   text-align: center;
}

.green_window {
   display: inline-block;
   width: 366px;
   height: 34px;
   border: 3px solid #23A19E;
   background: white;
}

.input_text {
   width: 348px;
   height: 21px;
   margin: 6px 0 0 9px;
   border: 0;
   line-height: 21px;
   font-weight: bold;
   font-size: 16px;
   outline: none;
}

.sch_smit {
   width: 54px;
   height: 40px;
   margin: 0;
   border: 0;
   vertical-align: top;
   background: #23A19E;
   color: white;
   font-weight: bold;
   border-radius: 1px;
   cursor: pointer;
}

.sch_smit:hover {
   background: #A2E9FF;
}
</style>
</HEAD>
<script>
   function Aaaa() {

      window
            .open(
                  '../member/themeRegist.do?authority=company',
                  'IDWin',
                  'width=300',
                  'height=100, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
   }
</script>
<BODY>
   <script type="text/javascript"
      src="https://nanati.me/common/js/jquery-1.11.2.min.js"></script>
   <script type="text/javascript"
      src="https://nanati.me/common/js/js-load.js"></script>
   <script>
$(window).on('load', function () {
    load('#js-load', '2');
    $("#js-btn-wrap .button").on("click", function () {
        load('#js-load', '2', '#js-btn-wrap');
    })
});
 
function load(id, cnt, btn) {
    var girls_list = id + " .js-load:not(.active)";
    var girls_length = $(girls_list).length;
    var girls_total_cnt;
    if (cnt < girls_length) {
        girls_total_cnt = cnt;
    } else {
        girls_total_cnt = girls_length;
        $('.button').hide()
    }
    $(girls_list + ":lt(" + girls_total_cnt + ")").addClass("active");
}
</script>
   <!--================ Header Top Area Start =================-->

   <c:if
      test="${not empty sessionScope.m_id and param.authority eq 'company' }">
      <section class="header-top d-none d-sm-block"
         style="background-color: #5fb6df">
         <div class="container">
            <div class="d-sm-flex justify-content-between">
               <ul class="header-top__info mb-2 mb-sm-0">
               </ul>
               <ul class="header-top__social">
                  <li>${m_id }님</li>
                  <li><a href="../member/logout.do">로그아웃</a></li>
                  <li><a href="../member/myPage.do?authority=company">마이페이지</a></li>
                  <li><a href="javascript:Aaaa();">테마파크 등록</a></li>
               </ul>
            </div>
         </div>
      </section>
   </c:if>
   <c:if
      test="${not empty sessionScope.m_id and param.authority eq 'member' }">
      <section class="header-top d-none d-sm-block"
         style="background-color: #5fb6df">
         <div class="container">
            <div class="d-sm-flex justify-content-between">
               <ul class="header-top__info mb-2 mb-sm-0">
               </ul>
               <ul class="header-top__social">
                  <li>${m_id }님</li>
                  <li><a href="../member/logout.do">로그아웃</a></li>
                  <li><a href="../member/myPage.do?authority=member">마이페이지</a></li>
               </ul>
            </div>
         </div>
      </section>

   </c:if>
   <c:if test="${empty sessionScope.m_id }">
      <section class="header-top d-none d-sm-block"
         style="background-color: #5fb6df">
         <div class="container">
            <div class="d-sm-flex justify-content-between">
               <ul class="header-top__info mb-2 mb-sm-0">
                  <!-- <li><span class="align-middle"><i class="ti-mobile"></i></span>010 0000 0000</li>
          <li><span class="align-middle"><i class="ti-email"></i></span>manamoa12.net</li> -->
               </ul>
               <ul class="header-top__social">

                  <li><a href="../member/login.do">로그인</a></li>
                  <c:if test="">
                     <li><a href="#">로그아웃</a></li>
                     <li><a href="../member/Mypage.do">마이페이지</a></li>
                  </c:if>
                  <!-- <li><a href="../member/themeRegist.do">테마파크 등록</a></li> -->
                  <li><a href="../member/policy.do">회원가입</a></li>
               </ul>
            </div>
         </div>
      </section>
   </c:if>

   <header class="header_area">
      <div class="main_menu">
         <nav class="navbar navbar-expand-lg navbar-light "
            style="background-color: #5fb6df">

            <div class="container box_1620">
               <a class="navbar-brand logo_h"
                  href="../index.do?authority=${authority }"> <img
                  src="../../img/logo.jpg" alt=""></a>
               <button class="navbar-toggler" type="button" data-toggle="collapse"
                  data-target="#navbarSupportedContent"
                  aria-controls="navbarSupportedContent" aria-expanded="false"
                  aria-label="Toggle navigation">
                  <span class="icon-bar"></span> <span class="icon-bar"></span> <span
                     class="icon-bar"></span>
               </button>

               <div class="collapse navbar-collapse offset "
                  id="navbarSupportedContent">
                  <ul class="nav navbar-nav menu_nav justify-content-end">
                     <li class="nav-item active"><a class="nav-link"
                        href="../index.do?authority=${authority }" style="color: white;">메인</a></li>
                     <li class="nav-item"><a class="nav-link"
                        href="../about.do?authority=${authority }" style="color: white">소개</a></li>

                     <li class="nav-item submenu dropdown"><a href="#"
                        class="nav-link dropdown-toggle" data-toggle="dropdown"
                        role="button" aria-haspopup="true" aria-expanded="false"
                        style="color: white">테마파크</a>
                        <ul class="dropdown-menu">
                           <li class="nav-item" style="color: white"><a
                              class="nav-link"
                              href="./list.do?tp_category=park&authority=${authority }">놀이동산</a></li>
                           <li class="nav-item" style="color: white"><a
                              class="nav-link"
                              href="./list.do?tp_category=water&authority=${authority }">워터파크</a></li>
                           <li class="nav-item" style="color: white"><a
                              class="nav-link"
                              href="./list.do?tp_category=zoo&authority=${authority }">동물원/<br />아쿠아리움
                           </a></li>
                           <li class="nav-item" style="color: white"><a
                              class="nav-link"
                              href="./list.do?tp_category=forest&authority=${authority }">수목원</a></li>
                        </ul></li>
                     <li class="nav-item"><a class="nav-link"
                        href="./infoevent.do?b_flag=event&authority=${authority }"
                        style="color: white">이벤트</a></li>
                     <li class="nav-item"><a class="nav-link"
                        href="./infoevent.do?b_flag=faq&authority=${authority }"
                        style="color: white">정보게시판</a></li>
                  </ul>
               </div>
            </div>
         </nav>
      </div>
   </header>
   <!--================Header Menu Area =================-->

   <!--================ Hero Banner start =================-->
   <section class="hero-banner hero-banner--sm">
      <div class="hero-banner__content text-center">
         <h4 style="color: white;">대한민국 1등 종합테마파크앱</h4>
         <h1 style="font-family: Youthanasia">Parkmoa</h1>
         <button class="dropdown-menu" value="버튼"
            style="visibility: collapse;">서울지역</button>
      </div>
   </section>
   <!--================ Hero Banner end =================-->
   <!--================ 파크 리스트 바로가기 section start =================-->
   <section class="section-margin" style="margin-top: 30px">
      <div class="container">
         <div class="row">
            <div class="col-sm-6 col-lg-4 col-xl-3 mb-4 mb-xl-0">
               <a href="../board/list.do?tp_category=park&authority=${authority }">
                  <div class="card card-subject">
                     <div class="card-subject__img">
                        <img class="card-img rounded-0"
                           src="../../img/banner/parkback2.jpg"
                           style="width: 350px; height: 200px;" alt="">
                        <div class="card-subject__imgOverlay">
                           <img class="ti-facebook" alt="">
                        </div>
                     </div>
                     <div class="card-subject__body">
                        <h3>놀이동산</h3>
                        <p style="text-align: center;">
                           언제어디서든 즐길수 있는 <br />테마파크를 이곳에서~
                        </p>
                     </div>
                  </div>
               </a>
            </div>
            <div class="col-sm-6 col-lg-4 col-xl-3 mb-4 mb-xl-0">
               <a
                  href="../board/list.do?tp_category=water&authority=${authority }">
                  <div class="card card-subject">
                     <div class="card-subject__img">
                        <img class="card-img rounded-0"
                           src="../../img/banner/waterpark01.png"
                           style="width: 350px; height: 200px;" alt="">
                        <div class="card-subject__imgOverlay">
                           <!-- <img src="img/home/hover-icon.png" alt=""> -->
                        </div>
                     </div>
                     <div class="card-subject__body">
                        <h3>워터파크</h3>
                        <p style="text-align: center;">
                           시원한 여름/추운 겨울에도 <br /> 즐길수 있는 워터파크~!
                        </p>
                     </div>
                  </div>
               </a>
            </div>

            <div class="col-sm-6 col-lg-4 col-xl-3 mb-4 mb-xl-0">
               <a href="../board/list.do?tp_category=zoo&authority=${authority }">
                  <div class="card card-subject">
                     <div class="card-subject__img">
                        <img class="card-img rounded-0"
                           src="../../img/banner/Everland1.jpg"
                           style="width: 350px; height: 200px;" alt="">
                        <div class="card-subject__imgOverlay">
                           <!-- <img src="img/home/hover-icon.png" alt=""> -->
                        </div>
                     </div>
                     <div class="card-subject__body">
                        <h3>동물원/아쿠아리움</h3>
                        <p style="text-align: center;">남여노소 모두가 즐길수 있는 공간을 선물합니다~</p>
                     </div>
                  </div>
               </a>
            </div>

            <div class="col-sm-6 col-lg-4 col-xl-3 mb-4 mb-xl-0">
               <a
                  href="../board/list.do?tp_category=forest&authority=${authority }">
                  <div class="card card-subject">
                     <div class="card-subject__img">
                        <img class="card-img rounded-0"
                           src="../../img/banner/forestBack5.jpg"
                           style="width: 350px; height: 200px;" alt="">
                        <div class="card-subject__imgOverlay">
                           <!--  <img src="img/home/hover-icon.png" alt=""> -->
                        </div>
                     </div>
                     <div class="card-subject__body">
                        <h3>수목원</h3>
                        <p style="text-align: center;">
                           4계절의 아름다움을 즐길수 <br />있는곳~
                        </p>
                     </div>
                  </div>
               </a>
            </div>

         </div>

         <div class="container" style="margin-top: 20px;">
            <!-- 검색폼 -->
            <form:form method="get" action="./list.do">
               <input type="hidden" name="tp_category"
                  value="${param.tp_category }" />
               <table width="100%" style="border: none;" class="class">
                  <tr>
                     <td align="center"><select name="searchColumn"
                        style="width: 140px; color: white; background-color: cornflowerblue; padding: .3em .2em; border: 1px solid #999; border-radius: 1px; -moz-appearance: none; appearance: none;">
                           <option value="tp_name">테마파크명</option>
                     </select><span class='green_window' style="border: 1px solid #23A19E;"> <input type="text"
                           name="searchWord" class="input_text" /></span>
                        <button class="sch_smit" type="submit" value="검색하기" style="background-color: cornflowerblue; height: 34px;">검색</button></td>  
                  </tr>
               </table>
            </form:form>
         </div>

      </div>
   </section>
   <!--================ Subject section end =================-->

   <div id="contents">
      <div id="js-load" class="main">
         <ul class="lists" style="width: 880px; padding-right: 150px">  
            <!-- 리스트반복 -->
            
            <c:forEach items="${lists1 }" var="row">
            <c:set var="sum" value="0" />
            <c:set var="average" value="0" />
            <c:set var="cnt" value="0" />
               <li class="lists__item js-load" style="background-color: currentColor;"><a
                  href="./listView.do?tp_category=${row.tp_category }&authority=${authority}&tp_idx=${row.tp_idx}"
                  target="_blank"><img
                     src="../../resources/upload/${row.tp_attach }" width="100%;"
                     height="460px;" /></a></li>
               <li class="lists__item js-load" style="background-color: currentColor;"><a
                  href="./listView.do?tp_category=${row.tp_category }&authority=${authority}&tp_idx=${row.tp_idx}"
                  target="_blank" style="color: white; font-size: 24px">${row.tp_name }
                     <br /> <span style="color: #a3a3a3; font-size:16px;">(${row.tp_addr1 })</span>
               </a></li>
               <li class="lists__item js-load"
                  style="background-color: white; border: 1px inset navy;"><span
                  style="color: red; font-size: 24px;"><strong>평점:</strong> <c:forEach
                        items="${lists }" var="rows" varStatus="status">
                        <c:if test="${row.tp_idx eq rows.b_bgroup }">
                           <c:set var="cnt" value="${cnt+1 }" />
                           <c:set var="sum" value="${sum+rows.b_rating }" />
                        </c:if>
                     </c:forEach><c:set var="average" value="${sum div cnt }" />  <fmt:formatNumber
                        var="ave" value="${average }" pattern=".0" /> <c:choose>
                        
                        <c:when test="${empty ave or ave eq '�' or ave eq '0.0'}">
                           등록된 리뷰가 없습니다.
                        </c:when>
                        <c:when test="${ave>='1.0' and ave < '1.5'}">
                           <img style="width: 30px; height: 30px;" id="image1"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image2"
                              src="../../resources/star/star0.png" />
                           <img style="width: 30px; height: 30px;" id="image3"
                              src="../../resources/star/star0.png" />
                           <img style="width: 30px; height: 30px;" id="image4"
                              src="../../resources/star/star0.png" />
                           <img style="width: 30px; height: 30px;" id="image5"
                              src="../../resources/star/star0.png" />
                              <span style="font-size: 20px;"><strong>(${cnt })</strong></span>
                              <span style="font-size: 20px;color: #a38a00;"><strong>${ave }</strong></span>
                              <span style="color: #a38a00; font-size: 20px;"><strong>최악이요</strong></span>
                        </c:when>
                        <c:when test="${ave>='1.5' and ave < '2.0'}">
                           <img style="width: 30px; height: 30px;" id="image1"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image2"
                              src="../../resources/star/star0.png" />
                           <img style="width: 30px; height: 30px;" id="image3"
                              src="../../resources/star/star0.png" />
                           <img style="width: 30px; height: 30px;" id="image4"
                              src="../../resources/star/star0.png" />
                           <img style="width: 30px; height: 30px;" id="image5"
                              src="../../resources/star/star0.png" />
                              <span style="font-size: 20px;"><strong>(${cnt })</strong></span>
                              <span style="font-size: 20px;color: #a38a00;"><strong>${ave }</strong></span>
                              <span style="color: #a38a00; font-size: 20px;"><strong>별로예요</strong></span>
                        </c:when>
                        <c:when test="${ave>='2.0' and ave < '2.5'}">
                           <img style="width: 30px; height: 30px;" id="image1"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image2"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image3"
                              src="../../resources/star/star0.png" />
                           <img style="width: 30px; height: 30px;" id="image4"
                              src="../../resources/star/star0.png" />
                           <img style="width: 30px; height: 30px;" id="image5"
                              src="../../resources/star/star0.png" />
                              <span style="font-size: 20px;"><strong>(${cnt })</strong></span>
                              <span style="font-size: 20px;color: #a38a00;"><strong>${ave }</strong></span>
                              <span style="color: #a38a00; font-size: 20px;"><strong>별로예요</strong></span>
                        </c:when>
                        <c:when test="${ave>='2.5' and ave < '3.0'}">
                           <img style="width: 30px; height: 30px;" id="image1"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image2"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image3"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image4"
                              src="../../resources/star/star0.png" />
                           <img style="width: 30px; height: 30px;" id="image5"
                              src="../../resources/star/star0.png" />
                              <span style="font-size: 20px;"><strong>(${cnt })</strong></span>
                              <span style="font-size: 20px;color: #a38a00;"><strong>${ave }</strong></span>
                              <span style="color: #a38a00; font-size: 20px;"><strong>만족해요</strong></span>
                        </c:when>
                        <c:when test="${ave>='3.0' and ave < '3.5'}">
                           <img style="width: 30px; height: 30px;" id="image1"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image2"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image3"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image4"
                              src="../../resources/star/star0.png" />
                           <img style="width: 30px; height: 30px;" id="image5"
                              src="../../resources/star/star0.png" />
                              <span style="font-size: 20px;"><strong>(${cnt })</strong></span>
                              <span style="font-size: 20px;color: #a38a00;"><strong>${ave }</strong></span>
                              <span style="color: #a38a00; font-size: 20px;"><strong>만족해요</strong></span>
                        </c:when>
                        <c:when test="${ave>='3.5' and ave < '4.0'}">
                           <img style="width: 30px; height: 30px;" id="image1"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image2"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image3"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image4"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image5"
                              src="../../resources/star/star0.png" />
                              <span style="font-size: 20px;"><strong>(${cnt })</strong></span>
                              <span style="font-size: 20px;color: #a38a00;"><strong>${ave }</strong></span>
                              <span style="color: #a38a00; font-size: 20px;"><strong>추천해요</strong></span>
                        </c:when>
                        <c:when test="${ave>='4.0' and ave < '4.5'}">
                           <img style="width: 30px; height: 30px;" id="image1"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image2"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image3"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image4"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image5"
                              src="../../resources/star/star0.png" />
                              <span style="font-size: 20px;"><strong>(${cnt })</strong></span>
                              <span style="font-size: 20px;color: #a38a00;"><strong>${ave }</strong></span>
                              <span style="color: #a38a00; font-size: 20px;"><strong>추천해요</strong></span>
                        </c:when>
                        <c:when test="${ave>='4.5' and ave <= '5.0'}">
                           <img style="width: 30px; height: 30px;" id="image1"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image2"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image3"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image4"
                              src="../../resources/star/star1.png" />
                           <img style="width: 30px; height: 30px;" id="image5"  
                              src="../../resources/star/star1.png" />
                              <span style="font-size: 20px;"><strong>(${cnt })</strong></span>
                              <span style="font-size: 20px;color: #a38a00;"><strong>${ave }</strong></span>
                              <span style="color: #a38a00; font-size: 20px;">
                              
                              <strong>최고예요</strong></span>
                        </c:when> 
                          
                        <c:otherwise>     
                              등록된 리뷰가 없습니다.
                           </c:otherwise>
                     </c:choose> </span>
                  <span
                  style="color: black; font-size: 24px;">
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>조회수:</strong>
                     ${row.tp_visitcount }
               </span></li>
            </c:forEach>
         </ul>
         <div id="js-btn-wrap" class="btn-wrap">
            <a href="javascript:;" class="button"
               style="width: 730px; font-size: 15px; background-color: white; display: inline-block; height: 38px; padding: 0 20px; border: 1px solid #1e1e1e; font-weight: bold; line-height: 39px; color: #1e1e1e; font-family: 'NotoSans Regular', 'Malgun Gothic', '맑은 고딕', 'Apple SD Gothic Neo', '돋움', dotum, sans-serif; text-align: center;">더보기</a>
         </div>
      </div>
   </div>

   <!-- ================ start footer Area ================= -->
   <footer class="footer-area " style="background-color: #50bcdf">
      <div class="container">
         <div class="row">
            <div class="col-lg-3  col-md-6 col-sm-6">
               <div class="single-footer-widget">
                  <h6>회사소개</h6>
                  <p>파크모아 액티비티는 파크모아 앱 하나로 전국의 액티비티 상품을 한 눈에 비교하고 손쉽게 예약할 수 있는
                     서비스입니다. 수상레저 · 테마파크 · 익스트림 · 실내체험 · 투어 · 키즈 · 원데이 클래스까지 세상의 모든
                     즐거운 경험을 제공해드립니다.</p>
               </div>
            </div>
            <div class="col-lg-3 col-md-6 col-sm-6">
               <div class="single-footer-widget">
                  <h6>페이지 바로가기</h6>
                  <div class="row">
                     <div class="col">
                        <ul>
                           <li><a href="./index.do?authority=${authority }">메인</a></li>
                           <li><a
                              href="./board/list.do?tp_category=park&authority=${authority }">놀이동산</a></li>
                           <li><a
                              href="./board/list.do?tp_category=zoo&authority=${authority }">동물원/아쿠아리움</a></li>
                           <li><a
                              href="./board/infoevent.do?b_flag=event&authority=${authority }">이벤트</a></li>
                        </ul>
                     </div>
                     <div class="col">
                        <ul>
                           <li><a href="../about.do?authority=${authority }">소개</a></li>
                           <li><a
                              href="./board/list.do?tp_category=forest&authority=${authority }">수목원</a></li>
                           <li><a
                              href="./board/list.do?tp_category=water&authority=${authority }">워타파크</a></li>
                           <li><a
                              href="./board/infoevent.do?b_flag=faq&authority=${authority }">정보게시판</a></li>
                        </ul>
                     </div>
                  </div>
               </div>
            </div>
            <div class="col-lg-3  col-md-6 col-sm-6">  
               <div class="single-footer-widget mail-chimp">
                  <h6 class="mb-20">회사소식</h6>  
                        <ul>     
                     <li style="color: #63747A">빠르고 편리한 예약</li>
                     <li style="color: #63747A">안전함과 폭넓은 활용</li>
                     <li style="color: #63747A">높은 만족도</li> 
                     <li style="color: #63747A">유일무이한 해택</li>
                  </ul>
               </div>
            </div>
            <div>
               <div class="single-footer-widget mail-chimp"> 
                  <h6 class="mb-20">고객행복센터</h6>       
                  <ul>  
                     <li style="color: #63747A;width:255px;">주소 : 서울특별시 금천구 가산동 </li>    
                     <li style="color: #63747A">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;426-5 월드 메르디앙 벤처 센터</li>    
                     <li style="color: #63747A">전화 : 1651-2233</li>    
                     <li style="color: #63747A">전자우편주소 : Help@Parkmoa.co.kr</li> 
                  </ul>
               </div>
            </div>
         </div>
      </div>
      <div class="footer-bottom">
         <div class="container">
            <div class="row align-items-center">
               <p
                  class="col-lg-8 col-sm-12 footer-text m-0 text-center text-lg-left">

                  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                  Copyright &copy;
                  <script>
                     document.write(new Date().getFullYear());
                  </script>
                  최종프로젝트 <i
                     class="fa fa-heart" aria-hidden="true"></i> by <a
                     target="_blank">Parkmoa</a>
                  <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
               </p>
               <div
                  class="col-lg-4 col-sm-12 footer-social text-center text-lg-right">
                  <a href="#"><i class="fab fa-facebook-f"></i></a> <a href="#"><i
                     class="fab fa-twitter"></i></a> <a href="#"><i 
                     class="fab fa-dribbble"></i></a> <a href="#"><i
                     class="fab fa-behance"></i></a>
               </div>
            </div>
         </div>
      </div>
   </footer>
   <!-- ================ End footer Area ================= -->
   <script src="../../vendors/bootstrap/bootstrap.bundle.min.js"></script>
   <script src="../../vendors/owl-carousel/owl.carousel.min.js"></script>
   <!--    <script src="../../vendors/Magnific-Popup/jquery.magnific-popup.min.js"></script> -->
   <script src="../../js/jquery.ajaxchimp.min.js"></script>
   <script src="../../js/mail-script.js"></script>
   <script src="../../js/main.js"></script>
   <STYLE>
.scrolltop {
   display: none;
   position: fixed;
   right: 30px;
   bottom: 50px;
   z-index: 1030;
   font-size: 1.875rem;
   color: #868e96;
   transition: all 0.5s ease-in-out;
   opacity: 0.8;
}

.scrolltop:hover, .scrolltop:focus {
   color: #dc3545;
   transition: all 0.5s ease-in-out;
}
</STYLE>
   <a id="backToTop" class="scrolltop" href="#"> <i
      class="fas fa-chevron-circle-up"></i>
   </a>
   <script
      src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <script>
      jQuery(document).ready(function () {
        $(window).scroll(function () {
          if ($(this).scrollTop() > 100) {
            $('#backToTop').fadeIn(500);
          } else {
            $('#backToTop').fadeOut('slow');
          }
        });
        $('#backToTop').click(function (e) {
          e.preventDefault();
          $('html, body').animate({scrollTop: 0}, 200);
        });
      });
    </script>



</BODY>
</HTML>