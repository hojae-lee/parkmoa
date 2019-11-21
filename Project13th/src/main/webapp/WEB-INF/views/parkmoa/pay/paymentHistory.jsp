<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>마이페이지</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="icon" href="../../img/Fevicon.png" type="image/png">
<LINK href="../../css/mypage_fonts.css" rel="stylesheet" type="text/css">
<LINK href="../../css/mypage_reset.css" rel="stylesheet" type="text/css">
<LINK href="../../css/mypage_common.css" rel="stylesheet"
	type="text/css">
<LINK href="../../css/mypage_inc.css" rel="stylesheet" type="text/css">
<LINK href="../../css/mypage_layout.css" rel="stylesheet"
	type="text/css">
<LINK href="../../css/mypage_popup.css" rel="stylesheet" type="text/css">
<LINK href="../../css/mypage_member.css" rel="stylesheet"
	type="text/css">

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
<link rel="stylesheet" href="../../css/swiper.css">
<link rel="stylesheet" href="../../css/main.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<script>
	function Aaaa() {
		window.open('../member/themeRegist.do?authority=company','IDWin','width=300','height=100, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
	}
</script>
<body>
	<!--================ Header Top Area Start =================-->
	<section class="header-top d-none d-sm-block"
		style="background-color: #5fb6df">
		<div class="container">
			<div class="d-sm-flex justify-content-between">
				<ul class="header-top__info mb-2 mb-sm-0">
					<!-- <li><span class="align-middle"><i class="ti-mobile"></i></span>010 0000 0000</li>
          <li><span class="align-middle"><i class="ti-email"></i></span>manamoa12.net</li> -->
				</ul>
				<ul class="header-top__social">

					<c:if
						test="${not empty sessionScope.m_id and param.authority eq 'member' }">
						<li>${sessionScope.m_id }님</li>
						<li><a href="../member/logout.do">로그아웃</a></li>
						<li><a href="../member/myPage.do?authority=member">마이페이지</a></li>
					</c:if>
					<c:if
						test="${not empty sessionScope.m_id and param.authority eq 'company' }">
						<li>${sessionScope.m_id }님</li>
						<li><a href="../member/logout.do">로그아웃</a></li>
						<li><a href="../member/myPage.do?authority=company">마이페이지</a></li>
						<li><a href="javascript:Aaaa();">테마파크 등록</a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</section>

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
										href="../board/list.do?tp_category=park&authority=${authority }">놀이동산</a></li>
									<li class="nav-item" style="color: white"><a
										class="nav-link"
										href="../board/list.do?tp_category=water&authority=${authority }">워터파크</a></li>
									<li class="nav-item" style="color: white"><a
										class="nav-link"
										href="../board/list.do?tp_category=zoo&authority=${authority }">동물원/<br />아쿠아리움
									</a></li>
									<li class="nav-item" style="color: white"><a
										class="nav-link"
										href="../board/list.do?tp_category=forest&authority=${authority }">수목원</a></li>
								</ul></li>
							<li class="nav-item"><a class="nav-link"
								href="../board/infoevent.do?b_flag=event&authority=${authority }"
								style="color: white">이벤트</a></li>
							<li class="nav-item"><a class="nav-link"
								href="../board/infoevent.do?b_flag=faq&authority=${authority }"
								style="color: white">정보게시판</a></li>
						</ul>
					</div>
				</div>
			</nav>
		</div>
	</header>
	<!--================ Header Top Area end =================-->

	<!--================ Header Menu Area start =================-->

	<!--================Header Menu Area =================-->

	<!--================ Hero sm Banner start =================-->
	<section class="hero-banner hero-banner--sm">
		<div class="hero-banner__content text-center">
			<h1 style="color: white">구매내역확인</h1>
			<nav aria-label="breadcrumb" class="banner-breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="#">MyPage</a></li>
					<li class="breadcrumb-item active" aria-current="page">Review</li>
				</ol>
			</nav>
		</div>
	</section>
	<!--================ Hero sm Banner end =================-->
	<div class="container">

		<UL class="dex4">
			<FIELDSET>
				<SECTION class="sect1 step04">
					<DIV class="row" style="text-align: right;">
						<div class="col-sm-3" style="background-color: #5fb6df;"
							align="center">
							<button type="button" class="btn"
								onclick="location.href='../member/myPage.do?authority=${authority}';"
								style="color: white;">회원정보수정</button>
						</div>
						<div class="col-sm-3" style="background-color: #5fb6df;"
							align="center">
							<button type="button" class="btn"
								onclick="location.href='../member/myPageReview.do?authority=${authority}';"
								style="color: white;">리뷰보기</button>
						</div>
						<div class="col-sm-3" style="background-color: #5fb6df;"
							align="center">
							<button type="button" class="btn"
								onclick="location.href='../pay/cart.do?authority=${authority}';"
								style="color: white;">담은목록보기</button>
						</div>
						<div class="col-sm-3" style="background-color: #5fb6df;"
							align="center">
							<button type="button" class="btn"
								onclick="location.href='../pay/paymentHistory.do?authority=${authority}';"
								style="color: white;">구매내역확인</button>
						</div>
					</DIV> 
					<DIV class="table_area table_area2" style="padding-top: 0px;">
					<SECTION class="contents-cart async-content" id="contents-cart">
<!-- 					<CAPTION class="none">결제내역</CAPTION> -->
						<input type="hidden" name="authority" value="${authority }" />
						<input type="hidden" name="m_id" value="${m_id }" />
						<table width="90%" class="table table-bordered" style="text-align: center;">
							<c:forEach items="${map }" var="row" varStatus="loop">
								<c:choose>
									<c:when test="${row.value[0].pay_group eq null }">
										<tr>
											<td>구매내역이 없습니다.</td>
										</tr>
									</c:when>
									<c:otherwise>
										<tr>
											<td colspan="4" style="border: 1px inset black; background-color: darkcyan; color: white; font-size: 20px">
												최근 ${loop.count }번째 결제내역</td>
										</tr>
										<tr style="background: #50C8FF; color: white;">
											<th width="25%" style="background: #50C8FF; text-align: center; color: white;">결제번호</th>
											<th width="*" style="background: #50C8FF; text-align: center; color: white;">구매자</th>
											<th width="15%" style="background: #50C8FF; text-align: center; color: white;">결제금액</th>
											<th width="20%" style="background: #50C8FF; text-align: center; color: white;">구매일</th>
										</tr>
										<tr>
											<td style="text-align: center;">${row.value[0].pay_group }</td>
											<td style="text-align: center;">${row.value[0].m_id }</td>
											<td style="text-align: center;"><fmt:formatNumber value="${row.value[0].pay_price }" pattern="#,###"/></td>
											<td style="text-align: center;">${fn:substring(row.value[0].pay_regidate,0,10) }</td>
										</tr>
										<tr>
											<th style="background: #50C8FF; text-align: center; color: white;">테마파크명</th>
											<th style="background: #50C8FF; text-align: center; color: white;">이용권</th>
											<th style="background: #50C8FF; text-align: center; color: white;">주차번호</th>
											<th style="background: #50C8FF; text-align: center; color: white;">이용날짜</th>
										</tr>
										<tr>
											<td style="border-bottom-color: black; width: 100%; ">
												<c:forEach items="${row.value }" var="list">
													<span style="width: 90%">${list.tp_name }</span><br />
												</c:forEach>
											</td>
											<td style="border-bottom-color: black; text-align: center;">
												<c:forEach items="${row.value }" var="list">
													${list.t_name }<br />
												</c:forEach>
											</td>
											<td style="border-bottom-color: black; text-align: center;">
												<c:forEach items="${row.value }" var="list">
													<c:choose>
														<c:when test="${list.p_num eq 0 }">
                                 							예약없음<br />
														</c:when>
														<c:otherwise>
                                 							${list.p_num }<br />
														</c:otherwise>
													</c:choose>
												</c:forEach></td>
											<td style="border-bottom-color: black; text-align: center;">
												<c:forEach items="${row.value }" var="list">
                           							${fn:substring(list.r_useregi,0,10) } &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                           							<a href="../board/listView.do?tp_idx=${list.tp_idx}&authority=${authority}">
														<i class='fas fa-edit' style='font-size: 18px'></i> 리뷰쓰기
													</a>
													<br />
												</c:forEach>
											</td>
										</tr>
										<tr> 
											<td colspan="4" style="border-left-color: white; border-right-color: white;">&nbsp;</td>
										</tr>
										<br />
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<tr>
								<td colspan="4" style="border-left-color: white; border-right-color: white; text-align: center;">
									<a href="../../parkmoa/index.do?authority=${authority }">
										<button type="button" class="btn btn-primary" style="margin-bottom: 5px;">
											메인으로가기
										</button>
									</a>
								</td>
							</tr>
						</table>
					</DIV>
				</SECTION>
			</FIELDSET>
		</UL>
	</DIV>
	</div>
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
</body>
</html>