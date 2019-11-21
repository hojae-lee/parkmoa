<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge"> 
<title>Parkmoa - Home</title>
<link rel="icon" href="../img/Fevicon.png" type="image/png">
<script
	src='http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js'></script>
<!-- Compiled and minified CSS -->
<link rel="stylesheet" href="../css/materialize.css">
<!-- Compiled and minified JavaScript -->
<script src="../js/materialize.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="../vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="../vendors/fontawesome/css/all.min.css">
<link rel="stylesheet" href="../vendors/themify-icons/themify-icons.css">
<link rel="stylesheet" href="../vendors/linericon/style.css">
<link rel="stylesheet"
	href="../vendors/owl-carousel/owl.theme.default.min.css">
<link rel="stylesheet"
	href="../vendors/owl-carousel/owl.carousel.min.css">
<link rel="stylesheet"
	href="../vendors/Magnific-Popup/magnific-popup.css">

<link rel="stylesheet" href="../css/style.css">
<link rel="stylesheet" href="../css/swiper.css">
<link rel="stylesheet" href="../css/main.css">
<style>
#sp_nws1_base{
	display: none;
}
#sp_nws2_base{
	display: none;
}
#sp_nws3_base{
	display: none;
}
#sp_nws4_base{
	display: none;
}
#sp_nws8_base{
	display: none; 
}
#sp_nws9_base{
	display: none;
}
#sp_nws13_base{
	display: none;
}
#sp_nws14_base{
	display: none;
}
#sp_nws15_base{ 	 
	display: none;
}
#sp_nws16_base{
	display: none;
}
#sp_nws17_base{
	display: none;
}
#sp_nws18_base{ 
	display: none;
}
a.bt_scial2.naver-splugin{display: none;} 
div.thumb{width:100px; height:100px; display:none;} 
a._sp_each_url._sp_each_title{font-size:22pt;color:#0042f7;} 
dt{padding-top: 15px; border-top:1px solid lightgrey;} 
a._sp_each_title{font-size:22pt;color:#0042f7;}
div.newr_more{display:none;} 
</style>
</head>
<script>
	function Aaaa() {

		window
				.open(
						'./member/themeRegist.do?authority=company',
						'IDWin',
						'width=300',
						'height=100, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
	}
	
	function Bbbb(){
		alert("기업회원만 접근가능합니다");
		location.href='/project3rd/parkmoa/index.do?authority=member';
		return false;
	}
	function Cccc(){
		alert("기업회원만 접근가능합니다");
		location.href='/project3rd/parkmoa/index.do?authority=';
		return false;
	}
</script>
<style>
.rate_widget {
	border: none;
	overflow: visible;
	padding: 10px;
	position: relative;
	width: 200px;
	height: 32px;
}

.ratings_stars {
	background: url('../img/star_empty.png') no-repeat;
	float: left;
	height: 30px;
	padding: 2px;
	width: 30px;
	align: center;
}

.ratings_vote {
	background: url('../img/star_full.png') no-repeat;
}

.ratings_over {
	background: url('../img/star_full.png') no-repeat;
}

.total_votes {
	background: #eaeaea;
	top: 40px;
	left: 0;
	padding: 5px;
	position: absolute;
}

.movie_choice {
	font: 10px verdana, sans-serif;
	margin: 0 auto 40px auto;
	width: 180px;
}
</style>

<body>
	<!--================ Header Top Area Start =================-->

	<c:choose>
		<c:when
			test="${not empty sessionScope.m_id and param.authority eq 'member' }">
			<%@ include file="./MemberTopArea.jsp"%>
		</c:when>
		<c:when
			test="${not empty sessionScope.m_id and param.authority eq 'company' }">
			<%@ include file="./CompanyTopArea.jsp"%>
		</c:when>
		<c:otherwise>
			<%@ include file="./BasicTopArea.jsp"%>
		</c:otherwise>
	</c:choose>

	<!--================Header Menu Area =================-->

	<!--================ Hero Banner start =================-->
	<script>
		$(document).ready(function() {
			$('.slider').slider();
		});
	</script>
	<section>
		<div class="slider" style="height: 640px;">
			<ul class="slides" style="height: 600px;">
				<li><img src="../img/banner/parkback2.jpg"> <!-- random image -->
					<div class="caption center-align">
						<h1
							style="padding-top: 100px; color: #040405; font-size: 75px; font-weight: 1">Parkmoa</h1>

					</div></li>
				<li><img src="../img/banner/waterpark01.jpg"> <!-- random image -->
					<div class="caption left-align"></div></li>
				<li><img src="../img/banner/Everland1.jpg"> <!-- random image -->
					<div class="caption right-align"></div></li>
				<li><img src="../img/banner/forestBack5.jpg"> <!-- random image -->
					<div class="caption center-align"></div></li>
			</ul>
		</div>
	</section>
	<!--================ Hero Banner end =================-->


	<!--================ Work Statics section start =================-->
	<!--================ Work Statics section end =================-->
	<!--================ 파크 리스트 바로가기 section start =================-->
	<section class="section-margin" style="margin-top: 30px">
		<div class="container">
			<div class="row">
				<div class="col-sm-6 col-lg-4 col-xl-3 mb-4 mb-xl-0">
					<a href="./board/list.do?tp_category=park&authority=${authority }">
						<div class="card card-subject">
							<div class="card-subject__img">
								<img class="card-img rounded-0"
									src="../img/banner/parkback2.jpg"
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
					<a href="./board/list.do?tp_category=water&authority=${authority }">
						<div class="card card-subject">
							<div class="card-subject__img">
								<img class="card-img rounded-0"
									src="../img/banner/waterpark01.png"
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
					<a href="./board/list.do?tp_category=zoo&authority=${authority }">
						<div class="card card-subject">
							<div class="card-subject__img">
								<img class="card-img rounded-0"
									src="../img/banner/Everland1.jpg"
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
						href="./board/list.do?tp_category=forest&authority=${authority }">
						<div class="card card-subject">
							<div class="card-subject__img">
								<img class="card-img rounded-0"
									src="../img/banner/forestBack5.jpg"
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
		</div>
	</section>
	<!--================ Subject section end =================-->

	<!--================ Review section start ===============-->
	<section class="section-margin--large">
		<div class="container">
			<h4 style="text-align: left;">최근 리뷰</h4>
			<p>(전체 리뷰: ${reviewcount })</p>
			<table width="90%" class="table table-condensed"
				style="border: none;">
				<c:choose>
					<c:when test="${empty reviewlists }">
						<tr>
							<td colspan="4" class="text-center">작성된 리뷰가 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${reviewlists }" var="row" varStatus="loop">
							<tr>
								<th class="text-center">${row.m_id }</th>
								<td class="text-left"><c:choose>
										<c:when test="${fn:length(row.b_content) > 40}">
											<a
												href="./board/listActionView.do?tp_idx=${row.b_bgroup }&authority=${authority}"
												target="_blank"
												style="color: #000000; text-decoration: none;">${fn:substring(row.b_content,0,38)}....</a>
										</c:when>
										<c:otherwise>
											<a
												href="./board/listActionView.do?tp_idx=${row.b_bgroup }&authority=${authority}"
												target="_blank"
												style="color: #000000; text-decoration: none;">${row.b_content}</a>
										</c:otherwise>
									</c:choose></td>
								<td class="text-center"><c:if
										test="${empty row.b_rating or row.b_rating eq '0'}">
										<img style="width: 30px; height: 30px;" id="image1"
											src="../resources/star/star0.png" />
										<img style="width: 30px; height: 30px;" id="image2"
											src="../resources/star/star0.png" />
										<img style="width: 30px; height: 30px;" id="image3"
											src="../resources/star/star0.png" />
										<img style="width: 30px; height: 30px;" id="image4"
											src="../resources/star/star0.png" />
										<img style="width: 30px; height: 30px;" id="image5"
											src="../resources/star/star0.png" />
									</c:if> <c:if test="${row.b_rating eq '1'}">
										<img style="width: 30px; height: 30px;" id="image1"
											src="../resources/star/star1.png" />
										<img style="width: 30px; height: 30px;" id="image2"
											src="../resources/star/star0.png" />
										<img style="width: 30px; height: 30px;" id="image3"
											src="../resources/star/star0.png" />
										<img style="width: 30px; height: 30px;" id="image4"
											src="../resources/star/star0.png" />
										<img style="width: 30px; height: 30px;" id="image5"
											src="../resources/star/star0.png" />
									</c:if> <c:if test="${row.b_rating eq '2'}">
										<img style="width: 30px; height: 30px;" id="image1"
											src="../resources/star/star1.png" />
										<img style="width: 30px; height: 30px;" id="image2"
											src="../resources/star/star1.png" />
										<img style="width: 30px; height: 30px;" id="image3"
											src="../resources/star/star0.png" />
										<img style="width: 30px; height: 30px;" id="image4"
											src="../resources/star/star0.png" />
										<img style="width: 30px; height: 30px;" id="image5"
											src="../resources/star/star0.png" />
									</c:if> <c:if test="${row.b_rating eq '3'}">
										<img style="width: 30px; height: 30px;" id="image1"
											src="../resources/star/star1.png" />
										<img style="width: 30px; height: 30px;" id="image2"
											src="../resources/star/star1.png" />
										<img style="width: 30px; height: 30px;" id="image3"
											src="../resources/star/star1.png" />
										<img style="width: 30px; height: 30px;" id="image4"
											src="../resources/star/star0.png" />
										<img style="width: 30px; height: 30px;" id="image5"
											src="../resources/star/star0.png" />
									</c:if> <c:if test="${row.b_rating eq '4'}">
										<img style="width: 30px; height: 30px;" id="image1"
											src="../resources/star/star1.png" />
										<img style="width: 30px; height: 30px;" id="image2"
											src="../resources/star/star1.png" />
										<img style="width: 30px; height: 30px;" id="image3"
											src="../resources/star/star1.png" />
										<img style="width: 30px; height: 30px;" id="image4"
											src="../resources/star/star1.png" />
										<img style="width: 30px; height: 30px;" id="image5"
											src="../resources/star/star0.png" />
									</c:if> <c:if test="${row.b_rating eq '5'}">
										<img style="width: 30px; height: 30px;" id="image1"
											src="../resources/star/star1.png" />
										<img style="width: 30px; height: 30px;" id="image2"
											src="../resources/star/star1.png" />
										<img style="width: 30px; height: 30px;" id="image3"
											src="../resources/star/star1.png" />
										<img style="width: 30px; height: 30px;" id="image4"
											src="../resources/star/star1.png" />
										<img style="width: 30px; height: 30px;" id="image5"
											src="../resources/star/star1.png" />
									</c:if></td>

								<td class="text-center">${row.b_regidate }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</table>
		</div>
	</section>


	<!--================ Review section end =================-->







	<!--================ About section start =================-->
<!-- 	<section class="d-lg-flex align-items-center section-margin--large"
		style="padding-right: 130px; padding-left: 130px;">
		<div class="container">
			<div class="about__content">
				<h3>테마파크 예매의 선두 주자 테마파크 예매 사이트</h3>
				<p>파크모아는 업계 선두의 온라인 테마파크 예매 사이트입니다.</p>
				<p>전 세계 90개 현지 웹사이트에서 41개 언어로 유용한 정보와 상품을 제공하고 있으며 놀이동산, 아쿠아리움
					동물원,</p>
				<p>수목원, 워터파크, 숨겨진 놀거리, 잘알려지지 않은 테마파크 등 원하는 곳을 마음껏 예매하실 수 있어요.</p>
				<p>또한, 전 세계 200여 개국과 지역에서 수십만 개의 테마파크에 가격 보장 혜택을 드립니다.</p>
				<p>파크모아의 혁신적인 온라인 도구와 모바일 앱을 지금 이용해 보세요.</p>
				<p>파크모아와 함께라면 예매 더 이상 어렵지 않아요.</p>
			</div>
		</div>
		<div class="about__videoWrapper">
			<div class="about__video">
				<div class="about__video-image">
					<img class="card-img" src="../img/home/everland2.jpg" alt="">
				</div>
				<div class="about__videoContent">
					<a id="play-home-video" class="video-play-button"
						href="https://www.youtube.com/watch?v=-S5dVTSis_I"> <span></span>
					</a>
				</div>
			</div>
		</div>

	</section> -->
	<!--================ About section end =================-->

	<!--================ Cta section start =================-->
		<div class="ad_ask">
		<!-- Pc -->
		<ul class="pc">
		<c:choose>
		<c:when
			test="${not empty sessionScope.m_id and param.authority eq 'member' }">
			<li><a href="javascript:Bbbb();"><img alt="테마파크등록하기"
					src="../img/MainAD/ad_02_171012.png"></a></li>
		</c:when>
		<c:when
			test="${not empty sessionScope.m_id and param.authority eq 'company' }">
			<li><a href="javascript:Aaaa();"><img alt="테마파크등록하기"
					src="../img/MainAD/ad_02_171012.png"></a></li>
		</c:when>
		<c:otherwise>
			<li><a href="javascript:Cccc();"><img alt="테마파크등록하기"
					src="../img/MainAD/ad_02_171012.png"></a></li>
		</c:otherwise>
	</c:choose>
			
			<li><a href="KakaoMap.do" target="_blank"><img
					alt="내주변 테마파크 검색" src="../img/MainAD/ad_01_171013.jpg"></a></li>
		</ul>
	</div>
	<section class="section-margin--large">
      <div id="js-load" class="main">	
         <div class="container">
            <h2 style="text-align: left;color:#79bfed">파크모아 뉴스</h2> 
            <table width="90%" class="table table-condensed"
               style="border: none;">
               <c:choose>
                  <c:when test="${empty currentInfo }">
                     <tr>
                        <td colspan="4">아무일도없었다.</td>
                     </tr>
                  </c:when>
                  <c:otherwise>
                     <c:forEach items="${currentInfo }" var="row" varStatus="loop">
                        <tr>
                           <td colspan="4">${row }</td>
                        </tr>
                     </c:forEach>
                  </c:otherwise>
               </c:choose>
            </table>
         </div>
      </div>
   </section> 
	<!-- <DIV class="event_main">
		<SECTION class="swiper-container">
			<UL class="swiper-wrapper">
				<LI class="swiper-slide"><X href="#"> <IMG
						alt="추석연휴 쿠폰할인 혜택"
						src="../img/MainAD/bf3f49d52b17cdd3744420b4b15b36a2.jpg"> </A></LI>
				<LI class="swiper-slide"><A href="#"><IMG
						alt="8월 카카오페이 즉시할인"
						src="../img/MainAD/22c7cb7e6a7d6b38df4b69ef80b86530.png"></A></LI>
				<LI class="swiper-slide"><a href="#"><img
						alt="매일 1만원 선착순 할인!"
						src="../img/MainAD/b42ef43dbdd536fb53360a76c6bb3437.jpg"></A></LI>
				<LI class="swiper-slide"><a href="#"><img
						alt="우리카드 포인트로 예약하세요!"
						src="../img/MainAD/91d3f8ae9baf9957615e7ee75f3875de.png"></A></LI>
				<LI class="swiper-slide"><a href="#"><img
						alt="페이백 50﹪ 쿠폰 이벤트"
						src="../img/MainAD/3916f6ec748f33b2b2dbdfca8c4ade60.png"></A></LI>
			</UL>
			Add Pagination

			<DIV class="swiper-pagination"></DIV>
		</SECTION>
	</DIV> -->
	<!-- //EVENT -->
	<!-- Ad -->




	<!-- //Ad -->

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
	<script>
		jQuery(document).ready(function() {
			$(window).scroll(function() {
				if ($(this).scrollTop() > 100) {
					$('#backToTop').fadeIn(500);
				} else {
					$('#backToTop').fadeOut('slow');
				}
			});
			$('#backToTop').click(function(e) {
				e.preventDefault();
				$('html, body').animate({
					scrollTop : 0
				}, 200);
			});
		});
	</script>
	<script src="../vendors/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="../vendors/owl-carousel/owl.carousel.min.js"></script>
	<script src="../vendors/Magnific-Popup/jquery.magnific-popup.min.js"></script>
	<script src="../js/jquery.ajaxchimp.min.js"></script>
	<script src="../js/mail-script.js"></script>
	<script src="../js/main.js"></script>
</body>
</html>