<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>파크모아 관리자</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet"
	href="../assets/materialize/css/materialize.min.css"
	media="screen,projection" />
<!-- Bootstrap Styles-->
<link href="../assets/css/bootstrap.css" rel="stylesheet" />
<!-- FontAwesome Styles-->
<link href="../assets/css/font-awesome.css" rel="stylesheet" />
<!-- Morris Chart Styles-->
<link href="../assets/js/morris/morris-0.4.3.min.css" rel="stylesheet" />
<!-- Custom Styles-->
<link href="../assets/css/custom-styles.css" rel="stylesheet" />
<!-- Google Fonts-->
<link href='http://fonts.googleapis.com/css?family=Open+Sans'
	rel='stylesheet' type='text/css' />
<link rel="stylesheet"
	href="../assets/js/Lightweight-Chart/cssCharts.css">

<script src='https://kit.fontawesome.com/a076d05399.js'></script>
</head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<!--javascript-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/waypoints/2.0.3/waypoints.min.js"></script>
<script src="../assets/jquery.counterup.js"></script>
<script>
	$(document).ready(function() {
		$('.counter').counterUp();
	});
	function printTime() {

		var clock = document.getElementById("clock"); // 출력할 장소 선택

		var now = new Date(); // 현재시간

		var nowTime = "Time" + " " + now.getFullYear() + "/"
				+ (now.getMonth() + 1) + "/" + now.getDate() + " "
				+ now.getHours() + ":" + now.getMinutes() + ":"
				+ now.getSeconds();

		clock.innerHTML = nowTime; // 현재시간을 출력

		setTimeout("printTime()", 1000); // setTimeout(“실행할함수”,시간) 시간은1초의 경우 1000

	}

	window.onload = function() { // 페이지가 로딩되면 실행

		printTime();

	}
</script>
</script>
<body>




	<div id="wrapper">
		<nav class="navbar navbar-default top-navbar" role="navigation">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle waves-effect waves-dark"
					data-toggle="collapse" data-target=".sidebar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand waves-effect waves-dark"
					href="./AdminIndex.do"><i class='fab fa-kickstarter'
					style='font-size: 24px'></i> <strong>ParkMoa</strong></a>
			</div>
			<form:form method="post"
				action="${pageContext.request.contextPath }/admin/logout">
				<div align="right" style="width: 100%; margin-right: 15px;">
					<button type="submit" class="btn btn-default btn-sm"
						style="height: 5.0em; margin-right: 15px; border: 0; outline: 0; box-shadow: none;">
						<i class='fas fa-external-link-square-alt'></i> Logout
					</button>
				</div>
			</form:form>
		</nav>
		<!--/. NAV TOP  -->
		<nav class="navbar-default navbar-side" role="navigation">
			<div class="sidebar-collapse">
				<ul class="nav" id="main-menu">

					<li><a class="active-menu waves-effect waves-dark"
						href="./AdminIndex.do"><i class='fab fa-kickstarter'></i>ParkMoa</a></li>

					<li><a href="#" class="waves-effect waves-dark"><i
							class="fa fa-sitemap"></i> 게시판<c:if test="${faqcount != 0 }">
								<i class='fas fa-exclamation-circle'
									style="font-size: 16pt; color: yellow;"></i>
							</c:if><span class="fa arrow"></span></a>
						<ul class="nav nav-second-level">
							<li><a href="./BoardList.do?boardname=event"
								class="waves-effect waves-dark"><i class="fa fa-table"></i>
									이벤트공지게시판</a></li>
							<li><a href="./BoardList.do?boardname=faq"
								class="waves-effect waves-dark"><i class="fa fa-table"></i>
									FAQ게시판<c:if test="${faqcount != 0 }">
										<i class='fas fa-exclamation-circle'
											style="font-size: 16pt; color: yellow;"></i>
									</c:if></a></li>
							<li><a href="#" class="waves-effect waves-dark"><i
									class="fa fa-table"></i> 테마파크 리스트<span class="fa arrow"></span></a>
								<ul class="nav nav-second-level">
									<li><a href="./BoardList.do?boardname=park">놀이동산</a></li>
									<li><a href="./BoardList.do?boardname=water">워터파크</a></li>
									<li><a href="./BoardList.do?boardname=zoo">동물원/아쿠아리움</a></li>
									<li><a href="./BoardList.do?boardname=forest">수목원</a></li>
								</ul></li></li>
				</ul>

				<li><a href="#" class="waves-effect waves-dark"><i
						class="fa fa-edit"></i> 파크모아회원 <span class="fa arrow"></span></a>
					<ul class="nav nav-second-level">
						<li><a href="./BoardList.do?boardname=member"><i
								class='fas fa-address-book'></i>일반회원</a></li>
						<li><a href="./BoardList.do?boardname=company"><i
								class='fas fa-address-book'></i>기업회원</a></li>
						<li><a href="./BoardList.do?boardname=admin"><i
								class='fas fa-address-book'></i>관리자</a></li>
						<li><a href="./BoardList.do?boardname=disabled"><i
								class='fas fa-address-book'></i>비활성회원</a></li>
						<!-- 리스트만볼수있음 -->
					</ul></li>
				<li><a href="./BoardList.do?boardname=payment"
					class="waves-effect waves-dark"><i class="fa fa-fw fa-file"></i>
						결제정보</a></li>
				<li><a href="./BoardList.do?boardname=themeconfirm"
					class="waves-effect waves-dark"><i class="fa fa-fw fa-file"></i>
						테마파크승인 <c:if test="${themeregistcount != 0 }">
							<i class='fas fa-exclamation-circle'
								style="font-size: 16pt; color: yellow;"></i>
						</c:if> </a></li>
				<li><a href="./BoardList.do?boardname=tickets"
					class="waves-effect waves-dark"><i class="fa fa-fw fa-file"></i>
						이용권정보</a></li>
				</ul>
			</div>

		</nav>
		<!-- /. NAV SIDE  -->

		<div id="page-wrapper">
			<div class="header">
				<h1 class="page-header">
					PARKMOA-AdminPage<span id="clock" style="color: gray;"></span>
				</h1>
				<input type="hidden" name="m_id" value="${m_id }" />
				<ol class="breadcrumb">
					<li><a href="#">Home</a></li>
					<li><a href="#">Dashboard</a></li>
					<li class="active">Data</li>
				</ol>

			</div>
			<div id="page-inner" align="center" style="min-height: 800px;">

				<div class="dashboard-cards" align="center">
					<div class="row" align="center">
						<a href="./BoardList.do?boardname=park"
							style="text-align: center;">
							<div class="col-xs-12 col-sm-6 col-md-3">

								<div class="card horizontal cardIcon waves-effect waves-dark"
									align="center;">
									<div class="card-image red">
										<i class="fa fa-list" style="font-size: 48px; color: white;"></i>
									</div>
									<div class="card-stacked red">
										<div class="card-content">
											<h3>게시판리스트</h3>

										</div>
										<div class="card-action">
											<strong>BOARD</strong>
										</div>
									</div>
								</div>
							</div>
						</a> <a href="./BoardList.do?boardname=themeconfirm">
							<div class="col-xs-12 col-sm-6 col-md-3">

								<div class="card horizontal cardIcon waves-effect waves-dark">
									<div class="card-image blue">
										<i class="material-icons dp48">stars</i>
									</div>
									<div class="card-stacked blue">
										<div class="card-content">
											<h3>승인리스트</h3>
										</div>
										<div class="card-action">
											<strong>PARK</strong>
										</div>
									</div>
								</div>
							</div>
						</a> <a href="./BoardList.do?boardname=member">
							<div class="col-xs-12 col-sm-6 col-md-3">

								<div class="card horizontal cardIcon waves-effect waves-dark">
									<div class="card-image green">
										<i class="material-icons dp48">supervisor_account</i>
									</div>
									<div class="card-stacked green">
										<div class="card-content">
											<h3>회원리스트</h3>
										</div>
										<div class="card-action">
											<strong>VISITS</strong>
										</div>
									</div>
								</div>
							</div>
						</a> <a href="./BoardList.do?boardname=payment">
							<div class="col-xs-12 col-sm-6 col-md-3">
								<div class="card horizontal cardIcon waves-effect waves-dark">
									<div class="card-image orange">
										<i class="material-icons dp48">shopping_cart</i>
									</div>
									<div class="card-stacked orange">
										<div class="card-content">
											<h3>결제정보리스트</h3>
										</div>
										<div class="card-action">
											<strong>PAY</strong>
										</div>
									</div>
								</div>
							</div>
						</a>
					</div>
				</div>
				<!-- /. ROW  -->
				<div class="row">
					<div class="col-xs-12 col-sm-12 col-md-12">
						<div class="cirStats">
							<div class="row">
								<div class="col-xs-12 col-sm-6 col-md-6">
									<div class="card-panel text-center">
										<h2>전체회원수</h2>
										<div class="easypiechart">
											<span class="counter" style="font-size: 64pt;">${totalmembercount }</span>

										</div>
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-6">
									<div class="card-panel text-center">
										<h4 style="color: red;">일반회원</h4>
										<div class="easypiechart" id="easypiechart-red"
											data-percent="${membercount }">
											<span class="percent">${membercount }%</span>
										</div>
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-6">
									<div class="card-panel text-center">
										<h4 style="color: #02ddc4">기업회원</h4>
										<div class="easypiechart" id="easypiechart-teal"
											data-percent="${companycount }">
											<span class="percent">${companycount }%</span>
										</div>
									</div>
								</div>
								<div class="col-xs-12 col-sm-6 col-md-6">
									<div class="card-panel text-center">
										<h4 style="color: #FE9800;">비활성회원</h4>
										<div class="easypiechart" id="easypiechart-orange"
											data-percent="${slavecount }">
											<span class="percent">${slavecount }%</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!--/.row-->
				</div>
				
			</div>
			<!-- /. PAGE INNER  -->
		</div>
		<!-- /. PAGE WRAPPER  -->
	</div>
	<!-- /. WRAPPER  -->
	<!-- JS Scripts-->
	<!-- jQuery Js -->
	<!-- Bootstrap Js -->
	<script src="../assets/js/bootstrap.min.js"></script>
	<script src="../assets/materialize/js/materialize.min.js"></script>

	<!-- Metis Menu Js -->
	<script src="../assets/js/jquery.metisMenu.js"></script>
	<!-- Morris Chart Js -->
	<script src="../assets/js/morris/raphael-2.1.0.min.js"></script>


	<script src="../assets/js/easypiechart.js"></script>
	<script src="../assets/js/easypiechart-data.js"></script>

	<script src="../assets/js/Lightweight-Chart/jquery.chart.js"></script>

	<!-- Custom Js -->
	<script src="../assets/js/custom-scripts.js"></script>



</body>

</html>