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
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
</head>
<script>
	function map1() {

		window
				.open(
						'KakaoMap1.do',
						'map1',
						'width=1200',
						'height=1000, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
	}
	function map2() {

		window
				.open(
						'KakaoMap2.do',
						'map2',
						'width=1200',
						'height=1000, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
	}
	function map3() {

		window
				.open(
						'KakaoMap3.do',
						'map3',
						'width=1200',
						'height=1000, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
	}
	function map4() {

		window
				.open(
						'KakaoMap4.do',
						'map4',
						'width=1200',
						'height=1000, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
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

#wrapper {
	width: 1000px;
	margin: 0 auto;
}
</style>

<body>
	<!--================ Header Top Area Start =================-->

	<!--================Header Menu Area =================-->

	<!--================ Hero Banner start =================-->


	<!--================ Work Statics section start =================-->
	<!--================ Work Statics section end =================-->
	<!--================ 파크 리스트 바로가기 section start =================-->



	<div id="wrapper">
		<table>
			<tr>
				<td colspan="2"><h2 style="text-align: center;"><img src="../img/parkmoaLogo.png"/>카테고리를
						선택해주세요.</h2></td>
			</tr>
			<tr>

				<td><a href="javascript:map1();"><button
							style="width: 500px; height: 400px;"
							class="btn btn-outline-danger">
							<span style="font-size: 32px;">놀이동산</span><br /> <i
								class='fab fa-fort-awesome' style="font-size: 48px;"></i>
						</button></a></td>
				<td><a href="javascript:map2();"><button
							style="width: 500px; height: 400px;"
							class="btn btn-outline-primary" >
							<span style="font-size: 32px;">워터파크</span><br /> <i
								class="material-icons" style="font-size: 48px;">pool</i>
						</button></a></td>
			</tr>
			<tr>
				<td><a href="javascript:map3();"><button
							style="width: 500px; height: 400px;"
							class="btn btn-outline-warning" >
							<span style="font-size: 32px;">동물원/아쿠아리움 </span><br /> <i
								class='fas fa-dog' style='font-size: 48px;'></i>/<i
								class='fas fa-fish' style='font-size: 48px;'></i>
						</button></a></td>
				<td><a href="javascript:map4();"><button
							style="width: 500px; height: 400px;"
							class="btn btn-outline-success">
							<span style="font-size: 32px;">수목원</span> <br /> <i
								class='fas fa-tree' style='font-size: 48px;'></i>
						</button></a></td>
			</tr>
		</table>
	</div>
	<!--================ Subject section end =================-->

	<!--================ Review section start ===============-->


	<!--================ Review section end =================-->







	<!--================ About section start =================-->

	<!--================ About section end =================-->

	<!--================ Cta section start =================-->



	<!-- //Ad -->

	<!-- ================ start footer Area ================= -->

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