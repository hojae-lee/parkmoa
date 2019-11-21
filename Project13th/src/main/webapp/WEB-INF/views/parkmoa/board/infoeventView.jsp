<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
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
<link rel="stylesheet" href="../../css/swiper.css">
<link rel="stylesheet" href="../../css/main.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
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
					</ul>
					<ul class="header-top__social">

						<li><a href="../member/login.do">로그인</a></li>
						<li><a href="../member/policy.do">회원가입</a></li>
					</ul>
				</div>
			</div>
		</section>
	</c:if>
	<!--================ Header Top Area end =================-->

	<!--================ Header Menu Area start =================-->
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

	<!--================ Hero Banner start =================-->
	<c:choose>
		<c:when test="${dto.b_flag eq 'event' }">
			<section class="hero-banner hero-banner--sm">
				<div class="hero-banner__content text-center">
					<h2 style="color: white;">이벤트 게시판</h2>
					<h1 style="font-family: Youthanasia"></h1>
				</div>
			</section>
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${dto.b_flag eq 'faq' }">
			<section class="hero-banner hero-banner--sm">
				<div class="hero-banner__content text-center">
					<h2 style="color: white;">FAQ 게시판</h2>
					<h1 style="font-family: Youthanasia"></h1>
				</div>
			</section>
		</c:when>
	</c:choose>
	<!--================ Hero Banner end =================-->

	<c:choose>
		<c:when test="${dto.b_flag eq 'event' }">
			<section class="blog_area single-post-area section-margin">
				<div class="container">
					<div style="width: 80%; padding-left: 200px;">
						<form:form action="" name="writeFrm" method="post"
							onsubmit="return checkWrite(this);">
							<table class="table table-bordered">
								<input type="hidden" name="authority" value="${authority }" />
								<thead>
									<tr class="table table-borderless table-success">
										<td width="200px" colspan="1">번호 :&nbsp;&nbsp;${dto.b_idx }</td>
										<td></td>
										<td>작성자 : &nbsp;&nbsp;${dto.m_id }</td>
									</tr>
								</thead>
								<tbody>
									<tr class="table ">
										<td class="" name="b_title" colspan="2">제목
											:&nbsp;&nbsp;${dto.b_title }</td>
										<td>작성일: &nbsp;&nbsp;${dto.b_regidate }</td>
									</tr>
									<tr class="table ">
										<td name="b_content" height="500px" colspan="3">${dto.b_content }
										</td>
									</tr>

								</tbody>
							</table>

							<div class="row text-center" style="padding-left: 35%;">
								<button type="button" class="btn btn-warning"
									onclick="location.href='infoevent.do?b_flag=${dto.b_flag}&authority=${authority }'">리스트보기</button>
							</div>
							<div class="clearBoth">
								<br />
							</div>
						</form:form>
					</div>

				</div>
			</section>
		</c:when>
		<c:when test="${dto.b_flag eq 'faq' }">
			<section class="blog_area single-post-area section-margin">
				<div class="container">
					<div style="width: 80%; padding-left: 200px;">
						<form:form action="" name="writeFrm" method="post"
							onsubmit="return checkWrite(this);">
							<table class="table table-bordered">
								<input type="hidden" name="authority" value="${authority }" />
								<thead>
									<tr class="table table-borderless table-success">
										<td width="200px" colspan="1">번호 :&nbsp;&nbsp;${dto.b_idx }</td>
										<td></td>
										<td>작성자 : &nbsp;&nbsp;${dto.m_id }</td>
									</tr>
								</thead>
								<tbody>
									<tr class="table ">
										<td class="" name="b_title" colspan="2">제목
											:&nbsp;&nbsp;${dto.b_title }</td>
										<td>작성일: &nbsp;&nbsp;${dto.b_regidate }</td>
									</tr>
									<tr class="table ">
										<td name="b_content" height="500px" colspan="3">${dto.b_content }
										</td>
									</tr>
									<tr>
										<td class="table" colspan="3"><c:if
												test="${ not empty dto.b_realfilename }">
												<a
													href="../fileDownload.do?fileName=${dto.b_attachedfile }&oriFileName=${dto.b_realfilename}">
													${dto.b_realfilename } <img
													src="../../resources/ChumFile.png" width="20px;"
													height="20px;" alt="??" />
												</a>
											</c:if></td>
									</tr>
								</tbody>
							</table>

							<div class="row text-center" style="padding-left: 35%;">

								<c:if
									test="${not empty sessionScope.m_id and param.authority eq 'company' }">
									<a
										href="./BoardReply.do?b_idx=${dto.b_idx }&b_flag=${dto.b_flag }&authority=${authority }&nowPage=${param.nowPage }">
										<button type="button" class="btn btn-danger">답변글 쓰기</button>
									</a>
								</c:if>
								<c:if
									test="${not empty sessionScope.m_id and param.authority eq 'member' }">
									<a
										href="./BoardReply.do?b_idx=${dto.b_idx }&b_flag=${dto.b_flag }&authority=${authority }&nowPage=${param.nowPage }">
										<button type="button" class="btn btn-danger">답변글 쓰기</button>
									</a>

								</c:if>
								<button type="button" class="btn btn-warning"
									onclick="location.href='infoevent.do?b_flag=${dto.b_flag}&authority=${authority }'">리스트보기</button>
							</div>
							<div class="clearBoth">
								<br />
							</div>
						</form:form>
					</div>
			</section>
		</c:when>
	</c:choose>


</body>
</html>