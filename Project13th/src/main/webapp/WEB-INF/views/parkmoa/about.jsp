<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Parkmoa - About us</title>
<link rel="icon" href="../img/Fevicon.png" type="image/png">

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
</head>
<style>
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

	<!--================ Hero sm Banner start =================-->
	<section class="hero-banner hero-banner--sm">
		<div class="hero-banner__content text-center">
			<h4 style="color: white;">대한민국 1등 종합테마파크앱</h4>
			<h1 style="font-family: Youthanasia">Parkmoa</h1>
		</div>
	</section>
	<!--================ Hero sm Banner end =================-->


	<!--================ About section start =================-->
	<section class="d-lg-flex align-items-center section-margin--large">
		<!-- <div class="about__videoWrapper">
      <div class="about__video">
        <div class="about__video-image">
          <img class="card-img" src="img/home/video-bg.png" alt="">
        </div>
        <div class="about__videoContent">
          <a id="play-home-video" class="video-play-button" href="https://www.youtube.com/watch?v=vParh5wE-tM">
            <span></span>
          </a>
          <h4>Watch our video</h4>
        </div>
      </div>
    </div> -->
		<div class="container">
			<div>
				<h3>쉼 없이 달려가는 일상 속에서 잠시 휴식과 영감을 얻기 위해 놀고 싶은 순간, 망설임 없이</h3>
				<ul class="mission_column">
					<li>
						<h4>누구나</h4>
						<div class="mission_underline">&nbsp;</div>
						<div class="mission_circle">&nbsp;</div>모든 테마파크가 다양한 가격대 모든 지역 /
						내국인 &amp; 외국인
					</li>
					<li>
						<h4>마음 편히</h4>
						<div class="mission_underline">&nbsp;</div>
						<div class="mission_circle">&nbsp;</div>편하고, 안정적이고, 정확한 서비스, 신뢰할 수
						있는 테마파크, 즐겁게 놀수 있는 공간 &amp; 쉴수있는 공간
					</li>
					<li>
						<h4>놀 수 있게</h4>
						<div class="mission_underline">&nbsp;</div>
						<div class="mission_circle">&nbsp;</div>놀고 싶어지는 이야기 놀기 좋은 테마파크 놀기
						편한 다양한 서비스
					</li>
				</ul>
				<!--  <a class="button mt-xl-3" href="#">Learn More</a> -->
			</div>
		</div>
	</section>
	<!--================ About section end =================-->

	<section class="bg-albaster section-padding--small ">
		<div class="container">
			<div class="section-intro text-center pb-65px">
				<h2 class="section-intro__title">우리의 존재 이유</h2>
				<p>이용자에게 더 빠르고 편한 서비스를 제공하고 행복한 시간을 선물하기 위해 이 사이트를 구축하게되었음</p>
			</div>
		</div>
	</section>

	<!--================ 맴버소개 section start =================-->
	<section class="bg-albaster section-padding--small"
		style="background-color: white">
		<div class="container">
			<div class="section-intro text-center pb-65px">
				<h2 class="section-intro__title">맴버소개</h2>
				<p></p>
			</div>

			<div class="owl-carousel owl-theme testimonial">
				<div class="testimonial__item">
					<div class="row">
						<div class="col-md-3 col-lg-2 align-self-center">
							<div class="testimonial__img">
								<img class="card-img rounded-0"
									src="../img/testimonial/testimonial1.png" alt="">

							</div>
						</div>
						<div class="col-md-9 col-lg-10">
							<div class="testimonial__content mt-3 mt-sm-0">
								<h3 style="text-align: left;">이재호</h3>
								<p>팀장</p>
								<p class="testimonial__i">팀장으로 프로젝트 총괄 지휘</p>
								<span class="testimonial__icon"><i class=""></i></span>
							</div>
						</div>
					</div>
				</div>
				<div class="testimonial__item">
					<div class="row">
						<div class="col-md-3 col-lg-2 align-self-center">
							<div class="testimonial__img">
								<img class="card-img rounded-0"
									src="../img/testimonial/testimonial1.png" alt="">
							</div>
						</div>
						<div class="col-md-9 col-lg-10">
							<div class="testimonial__content mt-3 mt-sm-0">
								<h3 style="text-align: left;">김영준</h3>
								<p>부매니저</p>
								<p class="testimonial__i">장바구니와 결제시스템</p>
								<span class="testimonial__icon"><i class=""></i></span>
							</div>
						</div>
					</div>
				</div>
				<div class="testimonial__item">
					<div class="row">
						<div class="col-md-3 col-lg-2 align-self-center">
							<div class="testimonial__img">
								<img class="card-img rounded-0"
									src="../img/testimonial/testimonial1.png" alt="">
							</div>
						</div>
						<div class="col-md-9 col-lg-10">
							<div class="testimonial__content mt-3 mt-sm-0">
								<h3 style="text-align: left;">이환진</h3>
								<p>팀원</p>
								<p class="testimonial__i">회원관리</p>
								<span class="testimonial__icon"><i class=""></i></span>
							</div>
						</div>
					</div>
				</div>
				<div class="testimonial__item">
					<div class="row">
						<div class="col-md-3 col-lg-2 align-self-center">
							<div class="testimonial__img">
								<img class="card-img rounded-0"
									src="../img/testimonial/testimonial1.png" alt="">
							</div>
						</div>
						<div class="col-md-9 col-lg-10">
							<div class="testimonial__content mt-3 mt-sm-0">
								<h3 style="text-align: left;">김동하</h3>
								<p>멤버</p>
								<p class="testimonial__i">리뷰/별점게시판</p>
								<span class="testimonial__icon"><i class=""></i></span>
							</div>
						</div>
					</div>
				</div>
				<div class="testimonial__item">
					<div class="row">
						<div class="col-md-3 col-lg-2 align-self-center">
							<div class="testimonial__img">
								<img class="card-img rounded-0"
									src="../img/testimonial/testimonial1.png" alt="">
							</div>
						</div>
						<div class="col-md-9 col-lg-10">
							<div class="testimonial__content mt-3 mt-sm-0">
								<h3 style="text-align: left;">손하슬람</h3>
								<p>멤버</p>
								<p class="testimonial__i">프론트</p>
								<span class="testimonial__icon"><i class=""></i></span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--================ 맴버소개 section end =================-->




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
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
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

	<script src="../vendors/jquery/jquery-3.2.1.min.js"></script>
	<script src="../vendors/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="../vendors/owl-carousel/owl.carousel.min.js"></script>
	<script src="../vendors/Magnific-Popup/jquery.magnific-popup.min.js"></script>
	<script src="../js/jquery.ajaxchimp.min.js"></script>
	<script src="../js/mail-script.js"></script>
	<script src="../js/main.js"></script>
</body>
</html>