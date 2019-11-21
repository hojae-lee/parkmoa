<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script>
	function Aaaa() {

		window
				.open(
						'member/themeRegist.do?authority=company',
						'IDWin',
						'width=300',
						'height=100, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
	}
</script>
<section class="header-top d-none d-sm-block"
	style="background-color: #5fb6df">
	<div class="container">
		<div class="d-sm-flex justify-content-between">
			<ul class="header-top__info mb-2 mb-sm-0">
			</ul>
			<ul class="header-top__social">
				<li>${m_id }님</li>
				<li><a href="member/logout.do">로그아웃</a></li>
				<li><a href="member/myPage.do?authority=company">마이페이지</a></li>
				<li><a href="javascript:Aaaa();">테마파크 등록</a></li>
			</ul>
		</div>
	</div>
</section>

<header class="header_area">
	<div class="main_menu">
		<nav class="navbar navbar-expand-lg navbar-light "
			style="background-color: #5fb6df">

			<div class="container box_1620">
				<a class="navbar-brand logo_h" href="./index.do?authority=company"><img
					src="../img/logo.jpg" alt=""></a>
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
							href="./index.do?authority=company" " style="color: white;">메인</a></li>
						<li class="nav-item"><a class="nav-link"
							href="./about.do?authority=company" style="color: white">소개</a></li>

						<li class="nav-item submenu dropdown"><a href="#"
							class="nav-link dropdown-toggle" data-toggle="dropdown"
							role="button" aria-haspopup="true" aria-expanded="false"
							style="color: white">테마파크</a>
							<ul class="dropdown-menu">
								<li class="nav-item" style="color: white"><a
									class="nav-link"
									href="board/list.do?tp_category=park&authority=company">놀이동산</a></li>
								<li class="nav-item" style="color: white"><a
									class="nav-link"
									href="board/list.do?tp_category=water&authority=company">워터파크</a></li>
								<li class="nav-item" style="color: white"><a
									class="nav-link"
									href="board/list.do?tp_category=zoo&authority=company">동물원/<br />아쿠아리움
								</a></li>
								<li class="nav-item" style="color: white"><a
									class="nav-link"
									href="board/list.do?tp_category=forest&authority=company">수목원</a></li>
							</ul></li>
						<li class="nav-item"><a class="nav-link"
							href="board/infoevent.do?b_flag=event&authority=company"
							style="color: white">이벤트</a></li>
						<li class="nav-item"><a class="nav-link"
							href="board/infoevent.do?b_flag=faq&authority=company"
							style="color: white">정보게시판</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</div>
</header>