<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>Parkmoa</title> 
<link rel="icon" href="../../img/Fevicon.png" type="image/png">

<link rel="stylesheet" href="../../vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="../../vendors/fontawesome/css/all.min.css">
<link rel="stylesheet"
	href="../../vendors/themify-icons/themify-icons.css">
<link rel="stylesheet" href="../../vendors/linericon/style.css">
<link rel="stylesheet"
	href="../../vendors/owl-carousel/owl.theme.default.min.css">
<link rel="stylesheet"
	href="../../vendors/owl-carousel/owl.carousel.min.css">
<link rel="stylesheet"
	href="../../vendors/Magnific-Popup/magnific-popup.css">

<link rel="stylesheet" href="../../css/style.css">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
	integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
	crossorigin="anonymous">
</head>


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
<body>
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
						href="../index.do?authority=${authority }"><img
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

	<!--================ Hero sm Banner start =================-->
	<c:choose>
		<c:when test="${b_flag eq 'event' }">
			<section class="hero-banner hero-banner--sm">
				<div class="hero-banner__content text-center">
					<h2 style="color: white;">
						이벤트 게시판
						</h4>
						<h1 style="font-family: Youthanasia"></h1>
				</div>
			</section>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${b_flag eq 'faq' }">
			<section class="hero-banner hero-banner--sm">
				<div class="hero-banner__content text-center">
					<h2 style="color: white;">
						FAQ 게시판
						</h4>
						<h1 style="font-family: Youthanasia"></h1>
				</div>
			</section>
		</c:when>
	</c:choose>


	<!--================ Hero sm Banner end =================-->

	<!-- ================ contact section start ================= -->
	<section class="section-margin--large">

		<c:choose>
			<c:when test="${b_flag eq 'faq' }">
				<div class="container">
					<h2>FAQ 게시판</h2>
					<!-- 검색폼 -->



					<!-- 검색폼 -->
					<form:form method="get" action="./infoevent.do">
						<input type="hidden" name="b_flag" value="${param.b_flag }" />
						<div class="input-group">
							<select name="searchColumn"
								style="width: 140px; color: white; background-color: cornflowerblue; border: 1px solid #999; border-radius: 1px; -moz-appearance: none; appearance: none;">
								<option value="b_title">제목</option>
								<option value="b_content">내용</option>
							</select> <input type="text" class="form-control table-borderless"
								placeholder="Search" name="searchWord"
								style="width: 50%; align-items: center;">

							<button class="btn btn-default input-group-append" type="submit"
								value="검색하기" style="background-color: cornflowerblue;">
								<i class="fas fa-search" style="color: white;"></i>
							</button>

						</div>
					</form:form>
					<table width="90%" class="table table-bordered">
						<tr>
							<th width="10%"
								style="background: #5fb6df; text-align: center; color: white;">번호</th>
							<th width="*"
								style="background: #5fb6df; text-align: center; color: white;">제목</th>
							<th width="15%"
								style="background: #5fb6df; text-align: center; color: white;">작성자</th>
							<th width="15%"
								style="background: #5fb6df; text-align: center; color: white;">작성일</th>
							<th width="10%"
								style="background: #5fb6df; text-align: center; color: white;">첨부파일</th>
						</tr>

						<c:choose>
							<c:when test="${empty lists }">
								<tr>
									<td colspan="5" class="text-center">등록된 게시물이 없습니다 ^^*</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach items="${lists }" var="row" varStatus="loop">
									<tr>
										<td class="text-center">${totalRecordCount - (((nowPage -1) * pageSize) + loop.index) }</td>
										<td class="text-left"><a
											href="../board/infoeventView.do?b_flag=${b_flag }&authority=${authority }&b_idx=${row.b_idx }&nowPage=${nowPage}">${row.b_title }</a>
										</td>
										<td class="text-center">${row.m_id }</td>
										<td class="text-center">${row.b_regidate }</td>
										<td class="text-center"><c:if
												test="${ not empty row.b_realfilename }">
												<a
													href="../fileDownload.do?fileName=${row.b_attachedfile }&oriFileName=${row.b_realfilename}">
													<img src="../../resources/ChumFile.png" width="20px;"
													height="20px;" alt="" />
												</a>
											</c:if></td>
									</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					</table>

					<table width="100%" style="border: none;">
						<tr>
							<td align="center" width="100%">
								<ul class="pagination" style="justify-content: center;">
									${pagingImg }
								</ul>
							</td>
						</tr>

					</table>
			</c:when>
		</c:choose>

		<section class="section-margin--large">
			<c:choose> 
				<c:when test="${b_flag eq 'event' }">
					<div class="container">
						<h2>Event 게시판</h2>
						<!-- 검색폼 -->
						<form:form method="get" action="./infoevent.do">
							<input type="hidden" name="b_flag" value="${param.b_flag }" />
							<div class="input-group">
								<select name="searchColumn"
									style="width: 140px; color: white; background-color: cornflowerblue; border: 1px solid #999; border-radius: 1px; -moz-appearance: none; appearance: none;">
									<option value="b_title">제목</option>
									<option value="b_content">내용</option>
								</select> <input type="text" class="form-control table-borderless"
									placeholder="Search" name="searchWord"
									style="width: 50%; align-items: center;">
 
								<button class="btn btn-default input-group-append" type="submit"
									style="background-color: cornflowerblue;" value="검색하기">
									<i class="fas fa-search" style="color: white;"></i>
								</button>

							</div>
						</form:form>

						<table width="90%" class="table table-bordered">
							<tr>
								<th width="10%"
									style="background: #5fb6df; text-align: center; color: white;">번호</th>
								<th width="*"
									style="background: #5fb6df; text-align: center; color: white;">제목</th>
								<th width="15%"
									style="background: #5fb6df; text-align: center; color: white;">작성자</th>
								<th width="15%"
									style="background: #5fb6df; text-align: center; color: white;">작성일</th>
							</tr>

							<c:choose>
								<c:when test="${empty lists }">
									<tr>
										<td colspan="5" class="text-center">등록된 게시물이 없습니다 ^^*</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${lists }" var="row" varStatus="loop">
										<tr>
											<td class="text-center">${totalRecordCount - (((nowPage -1) * pageSize) + loop.index) }</td>
											<td class="text-left"><a
												href="../board/infoeventView.do?b_flag=${b_flag }&authority=${authority }&b_idx=${row.b_idx }&nowPage=${nowPage}">${row.b_title }</a>
											</td>
											<td class="text-center">${row.m_id }</td>
											<td class="text-center">${row.b_regidate }</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</table>

						<table width="100%" style="border: none;">
							<tr>
								<td align="center" width="100%">
									<ul class="pagination" style="justify-content: center;">
										${pagingImg }
									</ul>
								</td>
							</tr>

						</table>
				</c:when>
			</c:choose>
			</div>
			</div>
		</section>

	</section>
	<!-- ================ contact section end ================= -->



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


	<script src="../../vendors/jquery/jquery-3.2.1.min.js"></script>
	<script src="../../vendors/bootstrap/bootstrap.bundle.min.js"></script>
	<script src="../../vendors/owl-carousel/owl.carousel.min.js"></script>
	<script src="../../vendors/Magnific-Popup/jquery.magnific-popup.min.js"></script>
	<script src="../../js/jquery.form.js"></script>
	<script src="../../js/jquery.validate.min.js"></script>
	<script src="../../js/contact.js"></script>
	<script src="../../js/jquery.ajaxchimp.min.js"></script>
	<script src="../../js/mail-script.js"></script>
	<script src="../../js/main.js"></script>
</body>
</html>