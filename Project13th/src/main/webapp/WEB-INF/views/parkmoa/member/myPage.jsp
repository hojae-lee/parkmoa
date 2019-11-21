<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
						<li>${m_id }님</li>
						<li><a href="../member/logout.do">로그아웃</a></li>
						<li><a href="../member/myPage.do?authority=member">마이페이지</a></li>
					</c:if>
					<c:if
						test="${not empty sessionScope.m_id and param.authority eq 'company' }">
						<li>${m_id }님</li>
						<li><a href="../member/logout.do">로그아웃</a></li>
						<li><a href="../member/myPage.do?authority=company">마이페이지</a></li>
						<li><a href="javascript:Aaaa();">테마파크
								등록</a></li>

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
			<h1 style="color: white">회원정보수정</h1>
			<nav aria-label="breadcrumb" class="banner-breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="#">Home</a></li>
					<li class="breadcrumb-item active" aria-current="page">Event</li>
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
								onclick="location.href='./myPage.do?authority=${authority}';"
								style="color: white;">회원정보수정</button>
						</div>
						<div class="col-sm-3" style="background-color: #5fb6df;"
							align="center">
							<button type="button" class="btn"
								onclick="location.href='./myPageReview.do?authority=${authority}';"
								style="color: white;">리뷰보기</button>
						</div>
						<div class="col-sm-3" style="background-color: #5fb6df;"
							align="center">
							<button type="button" class="btn"
								onclick="location.href='../pay/cart.do?authority=${authority}';" style="color: white;">담은목록보기</button>
						</div>
						<div class="col-sm-3" style="background-color: #5fb6df;"
							align="center">
							<button type="button" class="btn" onclick="location.href='../pay/paymentHistory.do?authority=${authority}';"
								style="color: white;">구매내역확인</button>
						</div>

					</DIV>
					<DIV class="table_area table_area2">
						<form:form id="mypage" action="../member/myPageaction.do"
							autocomplete="off" method="post">
							<input type="hidden" name="authority"
								value="${param.authority }" />
							<TABLE>
								<CAPTION>회원정보 수정에 관한 테이블</CAPTION>
								<COLGROUP>
									<COL class="w14_pc">
									<COL style="width: 75%;">
								</COLGROUP>
								<TBODY>
									<TR>
										<TH scope="row" style="padding: 30px 50px;"><LABEL for="infoId"><SPAN
												class="ftclr_red1"></SPAN><SPAN>아이디</SPAN><SPAN></SPAN></LABEL></TH>
										<TD>
											<DIV class="input_box bdnone">
												<DIV class="input_wrap">
													<input type="text" class="form-control" name="m_id"
														placeholder="아이디" value="${dto.m_id }">
												</DIV>
											</DIV>
										</TD>
									</TR>
									<TH scope="row" style="padding: 30px 50px;"><LABEL for="infoId"><SPAN
											class="ftclr_red1"></SPAN><SPAN>이메일</SPAN><SPAN></SPAN></LABEL></TH>
									<TD>
										<DIV class="">
											<input type="text" class="form-control" placeholder="이메일"
												name="m_email" value="${dto.m_email }" style="width: 70%">
										</DIV>
									</TD>
									</TR>
									<TR>
										<TH scope="row" style="padding: 30px 50px;"><LABEL for="password"><SPAN
												class="ftclr_red1"></SPAN>비밀번호</LABEL></TH>
										<TD>
											<DIV class="">
												<input type="password" class="form-control" name="m_pw"
													value="${dto.m_pw }" placeholder="비밀번호" style="width: 40%">
											</DIV>
											<p></p>
										</TD>
									</TR>
									<TR>
										<TH scope="row" style="padding: 30px 50px;"><LABEL for="infoName"><SPAN
												class="ftclr_red1"></SPAN>이름</LABEL></TH>
										<TD>
											<DIV class="input_box bdnone">
												<DIV class="input_wrap">
													<INPUT name="m_name" id="infoName" type="text" readonly=""
														value="${dto.m_name }">
												</DIV>
											</DIV>
										</TD>
									</TR>

									<TR>
										<TH scope="row" style="padding: 30px 50px;"><SPAN class="ftclr_red1"></SPAN>휴대폰</TH>

										<TD>
											<DIV class="input_wrap">
												<input type="text" name="m_mobile" class="form-control"
													placeholder="휴대폰" style="width: 40%"
													value="${dto.m_mobile }">
											</DIV>
										</TD>
									</TR>
									<TR>
										<TH scope="row" style="padding: 30px 50px;"><SPAN class="ftclr_red1"></SPAN>회원등급</TH>

										<TD>
											<DIV class="input_box bdnone">
												<DIV class="input_wrap">
													<input type="text" class="form-control" placeholder="회원등급"
														value="${dto.authority }" readonly="readonly">
												</DIV>
											</DIV>
										</TD>
									</TR>
									<TR>
										<TH scope="row" style="padding: 30px 50px;"><SPAN class="ftclr_red1"></SPAN>마일리지</TH>

										<TD>
											<DIV class="input_box bdnone">
												<DIV class="input_wrap">
													<c:set var="mileage" value="${dto.m_membership }"></c:set> 
													<fmt:formatNumber var="mileages" value="${mileage }" pattern="#,###" />
													<input type="text" class="form-control" placeholder="" value="${mileages }원"
													readonly="readonly">
												</DIV>
											</DIV>
										</TD>
									</TR>
								</TBODY>
							</TABLE>
							<div align="center">
								<button type="submit" class="btn btn-danger"
									style="width: 150px;">수정</button>
								<button type="button" class="btn btn-danger"
									style="width: 150px;" onClick="">취소</button>
							</div>
						</form:form>
				</SECTION>
			</FIELDSET>
		</UL>
	</DIV>

	</div>
</body>
</html>