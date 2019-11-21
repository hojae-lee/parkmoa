<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
<style>
.order_summary {
	margin: 0 22px;
	height: auto;
	display: block;
	padding: 20px 0 0 0;
	height: auto;
	margin-bottom: 12px;
	/* text-align: right; */
	min-height: 40px;
}

.text__value {
	font-weight: bold;
	color: #ff3c50;
	font-size: 30px;
	/*  color: #000; */
	letter-spacing: -0.7px;
	font-weight: bold;
	line-height: 41px;
}

.label {
	font-size: 16px;
	line-height: 24px;
	color: #000;
	letter-spacing: -0.5px;
	line-height: 40px;
	font-weight: normal;
	/* text-align:: right; */
}
</style>

</head>
<script>
	function Aaaa() {
		window.open('../member/themeRegist.do?authority=company','IDWin','width=300','height=100, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
	}
	
	//세자리마다 콤마찍기
	function numberWithCommas(n) {
	    var parts=n.toString().split(".");
	    return parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",") + (parts[1] ? "." + parts[1] : "");
	}
	
	var checkFlag = 'false'; // false면 전체선택, true이면 전체해제

	function check(field) {
		if (checkFlag == 'false') {
			for (i = 0; i < field.length; i++) {
				field[i].checked = true; // 모든 체크박스를 체크한다.
			}
			checkFlag = "true";
			return "전체 해제"; // 버튼객체의 value속성으로 반환(this.value.list로 넘겨져왔기 때문에)
		} else {
			for (i = 0; i < field.length; i++) {
				field[i].checked = false; // 모든 체크박스를 해제한다.
			}
			checkFlag = "false";
			return "전체 선택"; // 버튼객체의 vaule속성으로 반환
		}
	}

	//뒤로가기
	function goBack() {
		window.history.back(-1);
	}

	//결제목록가기
	function paymentHistory() {
		var f = document.myCart;

		f.action = "./paymentHistory.do";
		f.method = "post";

		f.submit();
	}

	//결제하기
	function paymentAction(field) {

		//체크박스 속성을 checked로 변경
		$("input:checkbox[name='rechk']").each(function(e) {
			this.checked = true;
		});

		var f = document.myCart;

		f.action = "./payment.do";
		f.method = "post";

		f.submit();
	}

	$(function() {

		getTotalPrice();

		//한줄삭제
		$(document).on("click", ".del", function() {

			var chkArr = new Array();
			chkArr[0] = $(this).attr('name');

			//장바구니 테이블에서 삭제처리 ajax
			cartDelete(chkArr);

			$('#' + chkArr[0]).remove();

			getTotalPrice();
		});
		//전체선택
		$('#selectAll').click(function() {
			chkFlag = false;
			$("input:checkbox[name='rechk']").each(function() {
				if (this.checked != true) {
					this.checked = true;
					chkFlag = true;
				}
			});

			if (chkFlag == false) {
				$("input:checkbox[name='rechk']").each(function() {
					this.checked = false;
				});
			}
		});

		//선택항목 모두 삭제
		$(document).on("click",".delAll",function() {

			var chkArr = new Array();
			var i = 0;

			//체크선택된 r_idx 배열에 담기
			$('input[name="rechk"]:checked').each(function() {
				chkArr[i] = $(this).val();
				i++;
			});
			//장바구니 테이블에서 삭제처리 ajax
			cartDelete(chkArr);

			for (var j = 0; j < chkArr.length; j++) {
				$('#' + chkArr[j]).remove();
			}

			getTotalPrice();
		});

		//수량변경 이벤트
		$(document).on("change", ".cnt",function() {
			getTotalPrice();
		});
	});

	function getTotalPrice() {

		var priceArr = new Array();
		var i = 0;
		var idx = 0;

		//계산값 배열에 넣기
		$('input[class="cnt"]').each(function() {

			idx = $(this).attr('id');

			priceArr[i] = $(this).val() * $('#price' + idx).val();
			i++;
		});

		if (priceArr.length == 0) {
			$('#totalPrice').text("총 결제금액 : 0원");
			$('#total_Price').val(0);
		} else {

			$.ajax({
				url : "../pay/total_price.do",
				type : "post",
				contentType : "application/x-www-form-urlencoded;charset=UTF-8",
				data : {
					'array' : priceArr
				},
				traditional : true,
				dataType : "JSON",
				beforeSend : function(xhr) {
					/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
					xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
				},
				success : function(r) {
					$('#totalPrice').text("총 결제금액 : "+ numberWithCommas(r.total_price)+ "원");
					$('#total_Price').val(r.total_price);
				},
				error : function(e) {
					alert('오류발생' + e.status+ ":"+ e.statusText);
				}
			});
		}

	}

	function cartDelete(arr) {

		$.ajax({
			url : "../pay/cartDelete.do",
			type : "post",
			contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			data : {
				'chk' : arr
			},
			traditional : true,
			dataType : "JSON",
			beforeSend : function(xhr) {
				/*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
				xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
			},
			success : function(r) {
				alert('장바구니에서 삭제하였습니다.');
			},
			error : function(e) {
				alert('오류발생' + e.status+ ":"+ e.statusText);
			}
		});
	}
</script>
<body>
	<!--================ Header Top Area Start =================-->
	<section class="header-top d-none d-sm-block"
		style="background-color: #5fb6df">
		<div class="container">
			<div class="d-sm-flex justify-content-between">
				<ul class="header-top__info mb-2 mb-sm-0">
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
			<h1 style="color: white">내가 남긴 리뷰</h1>
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
					<DIV class="table_area table_area2">
						<SECTION class="contents-cart async-content" id="contents-cart">
							<img src="../../img/cartimage.png"> <br /> <br /> <br />
							<form:form name="myCart">
								<input type="hidden" name="authority" value="${authority }" />
								<DIV id="cartContent">
									<DIV class="tabs-wrap">
										<DIV class="tabs"></DIV>
									</DIV>
									<TABLE style="text-align: center;"
										summary="장바구니 상품명, 제품가격, 선택한수량, 총결제비용 정보 및 결제 상품으로 선택,해제 및 수량변경, 삭제 기능 제공표">
										<CAPTION class="none">장바구니</CAPTION>
										<COLGROUP>
											<COL width="5%">
											<COL width="15%">
											<COL width="*">
											<COL width="10%">
											<COL width="17%">
											<COL width="15%">
											<COL width="17%">
										</COLGROUP>
										<THEAD>
											<TR class="head">
												<TH scope="col" style="padding: none;"></TH>
												<TH scope="col" style="text-align: center;">상품종류</TH>
												<TH scope="col" style="text-align: center;">상품정보</TH>
												<TH scope="col" style="text-align: center;">구매개수</TH>
												<TH scope="col" style="text-align: center;">가격</TH>
												<TH scope="col" style="text-align: center;">이용날짜</TH>
												<TH scope="col" style="text-align: center;">취소</TH>
											</TR>
										</THEAD>
										<c:choose>
											<c:when test="${not empty lists}">
												<c:forEach items="${lists }" var="row">
													<tr id="${row.r_idx }">
														<td><input type="hidden" name="tp_idxconfirm"
															value=${row.tp_idx } /><input type="checkbox"
															name="rechk" value="${row.r_idx }" /></td>
														<td style="text-align: center;">${row.tp_name }<input
															type="hidden" name="tp_name${row.r_idx }"
															value="${row.tp_name }" /> <input type="hidden"
															name="tp_idx${row.r_idx }" value="${row.tp_idx }" />
														</td>
														<td>${row.t_name }<input type="hidden"
															name="t_name${row.r_idx }" value="${row.t_name }" /></td>
														<td><input type="number" class="cnt"
															id="${row.r_idx }" min="1" name="cnt${row.r_idx }"
															value="${row.r_cnt }" style="width: 50px" /></td>
														<td>
														<fmt:formatNumber value="${row.t_price }" pattern="#,###"/> 원
														<input type="hidden"
															id="price${row.r_idx }" value="${row.t_price }" /></td>
														<td>${row.r_useregi }<input type="hidden"
															name="r_useregi${row.r_idx }"
															value="${fn:substring(row.r_useregi,0,10)}" /></td>
														<td class="text-center">
															<button type="button" name="${row.r_idx }"
																class="btn btn-primary btn-sm del"
																style="align-items: center;">구매취소</button>
														</td>
													</tr>
												</c:forEach>
											</c:when>
											<c:otherwise>
												<tr>
													<td colspan="7">장바구니가 비었습니다.</td>
												</tr>
											</c:otherwise>
										</c:choose>

									</TABLE>

								</div>
								</br>
								<div class="order-table-foot">
									<span class="all-select-product"> <label>
											<button type="button"
												onclick="this.value=check(this.form.rechk);"
												class="btn btn-primary" id="selectAll">전체선택</button>
									</label> <label>
											<button type="button" class="btn btn-danger delAll">선택삭제</button>
									</label>
									</span>
									<div class="order_summary" align="center">
										<strong class="text__value"><span id=totalPrice></span><input
											type="hidden" name="total_Price" id="total_Price" /></strong>
									</div>
									<DIV align="center">
										<a onClick="goBack();">
											<button type="button" class="btn btn-success btn-lg">돌아가기</button>
										</a>&nbsp;&nbsp;&nbsp;<a href="#">
											<button type="button" class="btn btn-danger btn-lg"
												onclick="paymentAction(this.form.rechk);">결제하기</button>
										</a>
									</DIV>
									<IFRAME width="0" height="0" class="ab_test" id="ab_iframe"
										src="about:blank" frameborder="0" vspace="0"></IFRAME>
								</DIV>

							</form:form>
							<DIV class="cart-no-item">
								<H2 class="sr-only">장바구니</H2>
								<!-- <P class="txt">장바구니에 담은 상품이 없습니다.</P> -->
							</DIV>
						</SECTION>
			</FIELDSET>
		</UL>
	</DIV>
	</div>
</body>
</html>

