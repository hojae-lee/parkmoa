<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Parkmoa - Admin</title>
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
</head>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<script>
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
</script>

<script>
	//일반회원 전체 비활성화 유효성 검사
	function checkBoxInvalid() {

		var fn = document.frm;

		if (fn.chk[0].checked == false) {
			alert("전체선택후 다시 눌러주시기 바랍니다.");
			return false;
		}

		else {
			fn.submit()
		}

	}
</script>

<script>
	//기업회원 전체 비활성화 유효성
	function checkBoxInvalid2() {

		var fnc = document.frmc;

		if (fnc.chk[0].checked == false) {
			alert("전체선택후 다시 눌러주시기 바랍니다.");
			return false;
		} else {
			fnc.submit()
		}

	}
</script>

<script>
	//비활성화 회원 게시판 전체 유효성
	function checkBoxInvalid3() {

		var fni = document.frmi;

		if (fni.chk[0].checked == false) {
			alert("전체선택후 다시 눌러주시기 바랍니다.");
			return false;
		} else {
			fni.submit()
		}

	}
</script>



<script>
	//일반회원정보 선택 비활성화 유효성
	function MemberInvalid() {

		var fn = document.frm;
		var checkboxs = document.getElementsByName("chk");
		var box_count = 0;

		for (var i = 0; i < checkboxs.length; i++) {
			if (checkboxs[i].checked == true) {
				box_count++;
			}
		}
		if (box_count <= 0) {
			alert("삭제할 내역을 체크 부탁드립니다.");
			return;
		} else {
			fn.submit();
		}

	}
</script>

<script>
	//선택 기업정보 선택 비활성화 유효성
	function MemberInvalid2() {

		var fn = document.frmc;
		var checkboxs = document.getElementsByName("chk");
		var box_count = 0;

		for (var i = 0; i < checkboxs.length; i++) {
			if (checkboxs[i].checked == true) {
				box_count++;
			}
		}
		if (box_count <= 0) {
			alert("삭제할 내역을 체크 부탁드립니다.");
			return;
		} else {
			fn.submit();
		}
	}
</script>

<script>
	//비활성화 회원 선택 유효성
	function MemberInvalid3() {

		var fni = document.frmi;
		var checkboxs = document.getElementsByName("chk");
		var box_count = 0;

		for (var i = 0; i < checkboxs.length; i++) {
			if (checkboxs[i].checked == true) {
				box_count++;
			}
		}
		if (box_count <= 0) {
			alert("삭제할 내역을 체크 부탁드립니다.");
			return;
		} else {
			fni.submit();
		}
	}
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
						href="./AdminIndex.do"><i class='fab fa-kickstarter'></i>
							ParkMoa</a></li>

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
									문의게시판 <c:if test="${faqcount != 0 }">
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

		<c:choose>
			<c:when test="${flag eq 'park' }">
				<div id="page-wrapper">
					<div class="header">
						<h1 class="page-header">놀이동산리스트</h1>
						<ol class="breadcrumb">
							<li><a href="#">Home</a></li>
							<li><a href="#">놀이동산리스트</a></li>
							<li class="active">Data</li>
						</ol>
					</div>
					<div id="page-inner">
						<div class="row">
							<div class="col-md-12">
								<div class="card">
									<div class="card-action">놀이동산리스트</div>
									<div>
										<form:form class="form-inline" method="get"
											action="./BoardList.do">
											<input type="hidden" name="boardname"
												value=${param.boardname } />
											<br />
											<div class="form-group" style="width: 1000px;">
												<select name="searchColumn" class="form-control"
													style="width: 10%">
													<option value="tp_name">제목</option>
													<option value="m_id">등록자</option>
												</select>
												<div class="input-group" style="width: 70%">
													<input type="text" name="searchWord" class="form-control"
														style="width: 50%;" />
													<button type="submit" class="btn btn-default">
														<i class='fas fa-search'></i>
													</button>
												</div>
											</div>
										</form:form>
									</div>

									<div class="card-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover"
												id="dataTables-example">
												<tr>
													<th width="10%"text-align:center;>번호</th>
													<th width="*%"text-align:center;>제목</th>
													<th width="15%"text-align:center;>등록자</th>
													<th width="10%"text-align:center;>작성일</th>
													<th width="10%"text-align:center;>첨부파일</th>
												</tr>
												<c:choose>
													<c:when test="${empty lists4 }">
														<tr>
															<td colspan="5" class="text-center">등록된 게시물이 없습니다 ^^
															</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach items="${lists4 }" var="row" varStatus="loop">
															<tr>
																<td class="text-center">${row.tp_idx }</td>
																<td class="text-left"><a
																	href="./View.do?boardname=${flag }&tp_idx=${row.tp_idx }&nowPage=${param.nowPage}">${row.tp_name }</a></td>
																<td class="text-center">${row.m_id }</td>
																<td class="text-center">${row.tp_regidate }</td>
																<td class="text-center">${row.tp_realfilename }</td>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</table>
											<table width="100%" style="border: none;">
												<tr>
													<td align="center" width="100%" style="padding-left: 50%">
														<ul class="pagination" style="justify-content: center;">
															<li>${pagingImg }</li>
														</ul>
													</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:when>
		</c:choose>

		<c:choose>
			<c:when test="${flag eq 'water' }">
				<div id="page-wrapper">
					<div class="header">
						<h1 class="page-header">워터파크리스트</h1>
						<ol class="breadcrumb">
							<li><a href="#">Home</a></li>
							<li><a href="#">워터파크리스트</a></li>
							<li class="active">Data</li>
						</ol>
					</div>
					<div id="page-inner">
						<div class="row">
							<div class="col-md-12">
								<div class="card">
									<div class="card-action">워터파크리스트</div>
									<div>
										<form:form class="form-inline" method="get"
											action="./BoardList.do">
											<input type="hidden" name="boardname"
												value="${param.boardname }" />
											<br />
											<div class="form-group" style="width: 1000px;">
												<select name="searchColumn" class="form-control"
													style="width: 10%">
													<option value="tp_name">제목</option>
													<option value="m_id">등록자</option>
												</select>
												<div class="input-group" style="width: 70%">
													<input type="text" name="searchWord" class="form-control"
														style="width: 50%;" />
													<button type="submit" name="검색하기" class="btn btn-default">
														<i class='fas fa-search'></i>
													</button>
												</div>
											</div>
										</form:form>
									</div>

									<div class="card-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover"
												id="dataTables-example">
												<tr>
													<th width="10%"text-align:center;>번호</th>
													<th width="*%"text-align:center;>제목</th>
													<th width="15%"text-align:center;>등록자</th>
													<th width="10%"text-align:center;>작성일</th>
													<th width="10%"text-align:center;>첨부파일</th>
												</tr>
												<c:choose>
													<c:when test="${empty lists4 }">
														<tr>
															<td colspan="5" class="text-center">등록된 게시물이 없습니다 ^^
															</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach items="${lists4 }" var="row" varStatus="loop">
															<tr>
																<td class="text-center">${row.tp_idx }</td>
																<td class="text-left"><a
																	href="./View.do?boardname=${flag }&tp_idx=${row.tp_idx }&nowPage=${param.nowPage}">${row.tp_name }</a></td>
																<td class="text-center">${row.m_id }</td>
																<td class="text-center">${row.tp_regidate }</td>
																<td class="text-center">${row.tp_realfilename }</td>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</table>
											<table width="100%" style="border: none;">
												<tr>
													<td align="center" width="100%" style="padding-left: 50%">
														<ul class="pagination pagination-sm"
															style="justify-content: center;">
															<li>${pagingImg }</li>
														</ul>
													</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:when>
		</c:choose>
		<c:choose>
			<c:when test="${flag eq 'zoo' }">
				<div id="page-wrapper">
					<div class="header">
						<h1 class="page-header">동물원/아쿠아리움</h1>
						<ol class="breadcrumb">
							<li><a href="#">Home</a></li>
							<li><a href="#">동물원/아쿠아리움</a></li>
							<li class="active">Data</li>
						</ol>
					</div>
					<div id="page-inner">
						<div class="row">
							<div class="col-md-12">
								<div class="card">
									<div class="card-action">동물원/아쿠아리움</div>
									<div>
										<form:form class="form-inline" method="get"
											action="./BoardList.do">
											<input type="hidden" name="boardname"
												value="${param.boardname }" />
											<br />
											<div class="form-group" style="width: 1000px;">
												<select name="searchColumn" class="form-control"
													style="width: 10%">
													<option value="tp_name">제목</option>
													<option value="m_id">등록자</option>
												</select>
												<div class="input-group" style="width: 70%">
													<input type="text" name="searchWord" class="form-control"
														style="width: 50%;" />
													<button type="submit" name="검색하기" class="btn btn-default">
														<i class='fas fa-search'></i>
													</button>
												</div>
											</div>
										</form:form>
									</div>

									<div class="card-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover"
												id="dataTables-example">
												<tr>
													<th width="10%"text-align:center;>번호</th>
													<th width="*%"text-align:center;>제목</th>
													<th width="15%"text-align:center;>등록자</th>
													<th width="10%"text-align:center;>작성일</th>
													<th width="10%"text-align:center;>첨부파일</th>
												</tr>
												<c:choose>
													<c:when test="${empty lists4 }">
														<tr>
															<td colspan="5" class="text-center">등록된 게시물이 없습니다 ^^
															</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach items="${lists4 }" var="row" varStatus="loop">
															<tr>
																<td class="text-center">${row.tp_idx }</td>
																<td class="text-left"><a
																	href="./View.do?boardname=${flag }&tp_idx=${row.tp_idx }&nowPage=${param.nowPage}">${row.tp_name }</a></td>
																<td class="text-center">${row.m_id }</td>
																<td class="text-center">${row.tp_regidate }</td>
																<td class="text-center">${row.tp_realfilename }</td>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</table>
											<table width="100%" style="border: none;">
												<tr>
													<td align="center" width="100%" style="padding-left: 50%">
														<ul class="pagination pagination-sm"
															style="justify-content: center;">
															<li>${pagingImg }</li>
														</ul>
													</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:when>
		</c:choose>
		<c:choose>
			<c:when test="${flag eq 'forest' }">
				<div id="page-wrapper">
					<div class="header">
						<h1 class="page-header">수목원리스트</h1>
						<ol class="breadcrumb">
							<li><a href="#">Home</a></li>
							<li><a href="#">수목원리스트</a></li>
							<li class="active">Data</li>
						</ol>
					</div>
					<div id="page-inner">
						<div class="row">
							<div class="col-md-12">
								<div class="card">
									<div class="card-action">수목원리스트</div>
									<div>
										<form:form class="form-inline" method="get"
											action="./BoardList.do">
											<input type="hidden" name="boardname"
												value="${param.boardname }" />
											<br />
											<div class="form-group" style="width: 1000px;">
												<select name="searchColumn" class="form-control"
													style="width: 10%">
													<option value="tp_name">제목</option>
													<option value="m_id">등록자</option>
												</select>
												<div class="input-group" style="width: 70%">
													<input type="text" name="searchWord" class="form-control"
														style="width: 50%;" />
													<button type="submit" name="검색하기" class="btn btn-default">
														<i class='fas fa-search'></i>
													</button>
												</div>
											</div>
										</form:form>
									</div>

									<div class="card-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover"
												id="dataTables-example">
												<tr>
													<th width="10%"text-align:center;>번호</th>
													<th width="*%"text-align:center;>제목</th>
													<th width="15%"text-align:center;>등록자</th>
													<th width="10%"text-align:center;>작성일</th>
													<th width="10%"text-align:center;>첨부파일</th>
												</tr>
												<c:choose>
													<c:when test="${empty lists4 }">
														<tr>
															<td colspan="5" class="text-center">등록된 게시물이 없습니다 ^^
															</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach items="${lists4 }" var="row" varStatus="loop">
															<tr>
																<td class="text-center">${row.tp_idx }</td>
																<td class="text-left"><a
																	href="./View.do?boardname=${flag }&tp_idx=${row.tp_idx }&nowPage=${param.nowPage}">${row.tp_name }</a></td>
																<td class="text-center">${row.m_id }</td>
																<td class="text-center">${row.tp_regidate }</td>
																<td class="text-center">${row.tp_realfilename }</td>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</table>
											<table width="100%" style="border: none;">
												<tr>
													<td align="center" width="100%" style="padding-left: 50%">
														<ul class="pagination pagination-sm"
															style="justify-content: center;">
															<li>${pagingImg }</li>
														</ul>
													</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:when>
		</c:choose>
		<c:choose>
			<c:when test="${flag eq 'themeconfirm' }">
				<div id="page-wrapper">
					<div class="header">
						<h1 class="page-header">테마파크승인리스트</h1>
						<ol class="breadcrumb">
							<li><a href="#">Home</a></li>
							<li><a href="#">테마파크승인리스트</a></li>
							<li class="active">Data</li>
						</ol>
					</div>
					<div id="page-inner">
						<div class="row">
							<div class="col-md-12">
								<div class="card">
									<div class="card-action">테마파크승인리스트</div>
									<div>
										<form:form class="form-inline" method="get"
											action="./BoardList.do">
											<input type="hidden" name="boardname"
												value="${param.boardname }" />
											<br />
											<div class="form-group" style="width: 1000px;">
												<select name="searchColumn" class="form-control"
													style="width: 15%">
													<option value="tp_category">카테고리</option>
												</select>
												<div class="input-group" style="width: 70%">
													<input type="text" name="searchWord" class="form-control"
														style="width: 50%;" />
													<button type="submit" class="btn btn-default">
														<i class='fas fa-search'></i>
													</button>
												</div>
											</div>
										</form:form>
									</div>

									<div class="card-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover"
												id="dataTables-example">
												<tr>
													<th width="10%"text-align:center;>번호</th>
													<th width="*%"text-align:center;>카테고리</th>
													<th width="35%"text-align:center;>테마파크이름</th>
													<th width="15%"text-align:center;>등록자</th>
													<th width="10%"text-align:center;>작성일</th>
													<th width="10%"text-align:center;>첨부파일</th>
												</tr>
												<c:choose>
													<c:when test="${empty lists2 }">
														<tr>
															<td colspan="6" class="text-center">등록된 게시물이 없습니다 ^^
															</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach items="${lists2 }" var="row" varStatus="loop">
															<tr>
																<td class="text-center">${row.tp_idx }</td>
																<td class="text-center">${row.tp_category }</td>
																<td class="text-left"><a
																	href="Tp_registconfirm.do?tp_idx=${row.tp_idx }&boardname=${row.tp_category }&nowPage=${param.nowPage}">${row.tp_name }</a></td>
																<td class="text-center">${row.m_id }</td>
																<td class="text-center">${row.tp_regidate }</td>
																<td class="text-center">${row.tp_realfilename }</td>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</table>
											<table width="100%" style="border: none;">
												<tr>
													<td align="center" width="100%" style="padding-left: 50%">
														<ul class="pagination pagination-sm"
															style="justify-content: center;">
															<li>${pagingImg }</li>
														</ul>
													</td>
												</tr>
											</table>

											<%-- <div class="row text-center" style="padding-left: 10%;">
												<a href="./adminthemeRegist.do?boardname=${flag }"><button
														type="submit" class="btn btn-primary">글 쓰기</button></a>
											</div> --%>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:when>

			<c:when test="${flag eq 'payment' }">
				<div id="page-wrapper">
					<div class="header">
						<h1 class="page-header">결제정보 리스트</h1>
						<ol class="breadcrumb">
							<li><a href="#">Home</a></li>
							<li><a href="#">결제정보 리스트</a></li>
							<li class="active">Data</li>
						</ol>
					</div>
					<div id="page-inner">
						<div class="row">
							<div class="col-md-12">
								<div class="card">
									<div class="card-action">결제정보</div>
									<div>
										<form:form class="form-inline" method="get"
											action="BoardList.do">
											<input type="hidden" name="boardname" value="${flag }" />
											<br />
											<div class="form-group" style="width: 1000px;">
												<select name="searchColumn" class="form-control"
													style="width: 10%">
													<option value="m_id">아이디</option>
												</select>
												<div class="input-group" style="width: 70%">
													<input type="text" name="searchWord" class="form-control"
														style="width: 50%;" />
													<button type="submit" name="검색하기" class="btn btn-default">
														<i class='fas fa-search'></i>
													</button>
												</div>
											</div>
										</form:form>
									</div>

									<div class="card-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover"
												id="dataTables-example"> 
												<tr>
													<th width="10%"text-align:center;>번호</th>
													<th width="*%"text-align:center;>회원님의 결제내역</th>
													<th width="23%"text-align:center;>핸드폰번호</th>
													<th width="23%"text-align:center;>이메일</th>
												</tr>
												<c:choose>
													<c:when test="${empty paylists }">
														<tr>
															<td colspan="4" class="text-center">등록된 게시물이 없습니다 ^^
															</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach items="${paylists }" var="row" varStatus="loop">
															<tr>
																<td class="text-center">${loop.count }</td>
																<td class="text-center">
																	<a href="./paymentView.do?boardname=${flag }&m_id=${row.m_id}">
																		${row.m_id }님의 결제내역
																	</a>
																</td>
																<td class="text-center">${row.m_mobile }</td>
																<td class="text-center">${row.m_email }</td>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</table>
											<table width="100%" style="border: none;">
												<tr>
													<td align="center" width="100%" style="padding-left: 50%">
														<ul class="pagination pagination-sm"
															style="justify-content: center;">
															<li>${pagingImg }</li>
														</ul>
													</td>
												</tr>
											</table>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:when>

			<c:when test="${flag eq 'event' }">
				<div id="page-wrapper">
					<div class="header">
						<h1 class="page-header">공지사항/이벤트 게시판</h1>
						<ol class="breadcrumb">
							<li><a href="#">Home</a></li>
							<li><a href="#">공지사항/이벤트 게시판</a></li>
							<li class="active">Data</li>
						</ol>
					</div>
					<div id="page-inner">
						<div class="row">
							<div class="col-md-12">
								<div class="card">
									<div class="card-action">공지사항/이벤트</div>
									<div>
										<form:form class="form-inline" method="get"
											action="BoardList.do">
											<input type="hidden" name="boardname" value="${flag }" />
											<br />
											<div class="form-group" style="width: 1000px;">
												<select name="searchColumn" class="form-control"
													style="width: 10%">
													<option value="b_title">제목</option>
													<option value="b_content">내용</option>
												</select>
												<div class="input-group" style="width: 70%">
													<input type="text" name="searchWord" class="form-control"
														style="width: 50%;" />
													<button type="submit" name="검색하기" class="btn btn-default">
														<i class='fas fa-search'></i>
													</button>
												</div>
											</div>
										</form:form>
									</div>

									<div class="card-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover"
												id="dataTables-example">
												<tr>
													<th width="10%"text-align:center;>번호</th>
													<th width="*%"text-align:center;>제목</th>
													<th width="10%"text-align:center;>작성자</th>
													<th width="10%"text-align:center;>등록일</th>
													<th width="10%"text-align:center;>구분</th>
												</tr>
												<c:choose>
													<c:when test="${empty lists }">
														<tr>
															<td colspan="7" class="text-center">등록된 게시물이 없습니다 ^^
															</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach items="${lists }" var="row" varStatus="loop">
															<tr>
																<td class="text-center">${row.b_idx }</td>
																<td class="text-center"><a
																	href="./View.do?boardname=${flag }&b_idx=${row.b_idx }&nowPage=${param.nowPage}">${row.b_title }</a></td>
																<td class="text-center">${row.m_id }</td>
																<td class="text-center">${row.b_regidate }</td>
																<td class="text-center">${row.b_flag }</td>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</table>
											<table width="100%" style="border: none;">
												<tr>
													<td align="center" width="100%" style="padding-left: 50%">
														<ul class="pagination pagination-sm"
															style="justify-content: center;">
															<li>${pagingImg }</li>
														</ul>
													</td>
												</tr>
											</table>
											<div class="row text-center" style="padding-left: 10%;">
												<a href="./ListWrite.do?boardname=${flag }"><button
														type="submit" class="btn btn-primary">글 쓰기</button></a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:when>

			<c:when test="${flag eq 'faq' }">
				<div id="page-wrapper">
					<div class="header">
						<h1 class="page-header">문의사항 게시판</h1>
						<ol class="breadcrumb">
							<li><a href="#">Home</a></li>
							<li><a href="#">문의사항 게시판</a></li>
							<li class="active">Data</li>
						</ol>
					</div>
					<div id="page-inner">
						<div class="row">
							<div class="col-md-12">
								<div class="card">
									<div class="card-action">문의사항 게시판</div>
									<div>
										<form:form class="form-inline" method="get"
											action="./BoardList.do">
											<input type="hidden" name="boardname" value="${flag }" />
											<br />
											<div class="form-group" style="width: 1000px;">
												<select name="searchColumn" class="form-control"
													style="width: 10%">
													<option value="b_title">제목</option>
													<option value="b_content">내용</option>
												</select>
												<div class="input-group" style="width: 70%">
													<input type="text" name="searchWord" class="form-control"
														style="width: 50%;" />
													<button type="submit" name="검색하기" class="btn btn-default">
														<i class='fas fa-search'></i>
													</button>
												</div>
											</div>
										</form:form>
									</div>
									<div class="card-content">
										<div class="table-responsive">
											<table class="table table-striped table-bordered table-hover"
												id="dataTables-example">
												<tr>
													<th width="10%"text-align:center;>번호</th>
													<th width="10%"text-align:center;>작성자</th>
													<th width="*%"text-align:center;>제목</th>
													<th width="15%"text-align:center;>등록일</th>
													<th width="15%"text-align:center;>처리여부</th>
												</tr>
												<c:choose>
													<c:when test="${empty lists }">
														<tr>
															<td colspan="7" class="text-center">등록된 게시물이 없습니다 ^^
															</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach items="${lists }" var="row" varStatus="loop">
															<tr>
																<td class="text-center">${row.b_idx }</td>
																<td class="text-left">${row.m_id }</td>
																<td class="text-left"><a
																	href="./View.do?boardname=${flag }&b_idx=${row.b_idx }&nowPage=${param.nowPage}">${row.b_title }</a></td>
																<td class="text-center">${row.b_regidate }</td>
																<c:choose>
																	<c:when test="${row.b_alert eq 0 }">
																		<td class="text-center" style="color: red;">확인전</td>
																	</c:when>
																	<c:otherwise>
																		<td class="text-center" style="color: blue;">확인완료</td>
																	</c:otherwise>
																</c:choose>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</table>
											<table width="100%" style="border: none;">
												<tr>
													<td align="center" width="100%" style="padding-left: 50%">
														<ul class="pagination pagination-sm"
															style="justify-content: center;">
															<li>${pagingImg }</li>
														</ul>
													</td>
												</tr>
											</table>
											<div class="row text-center" style="padding-left: 10%;">
												<a href="./ListWrite.do?boardname=${flag }"><button
														type="submit" class="btn btn-primary">글 쓰기</button></a>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:when>

			<c:when test="${flag eq 'member' }">
				<div id="page-wrapper">
					<div class="header">
						<h1 class="page-header">일반회원 게시판</h1>
						<ol class="breadcrumb">
							<li><a href="#">Home</a></li>
							<li><a href="#">일반회원 게시판</a></li>
							<li class="active">Data</li>
						</ol>
					</div>
					<div id="page-inner">

						<div class="row">
							<div class="col-md-12">

								<div class="card">
									<div class="card-action">일반회원리스트</div>
									<div>
										<form:form class="form-inline" method="get"
											action="./BoardList.do">
											<input type="hidden" name="boardname"
												value="${param.boardname }" />
											<br />
											<div class="form-group" style="width: 1000px;">
												<select name="searchColumn" class="form-control"
													style="width: 10%">
													<option value="m_id">아이디</option>
													<option value="m_name">이름</option>
												</select>
												<div class="input-group" style="width: 70%">
													<input type="text" name="searchWord" class="form-control"
														style="width: 50%;" />
													<button type="submit" name="검색하기" class="btn btn-default">
														<i class='fas fa-search'></i>
													</button>
												</div>
											</div>
										</form:form>
									</div>

									<form:form
										action="./deleteUser.do?boardname=${flag }&nowPage=${nowPage }"
										method="post" name="frm" onsubmit="return active();">
										<input type="hidden" value="${nowPage }">
										<input type="hidden" value="${flag }">
										<div class="card-content">
											<div class="table-responsive">
												<table
													class="table table-striped table-bordered table-hover"
													id="dataTables-example">
													<tr>
														<th width="3%"text-align:center;><input
															type="checkbox" id="checkall" name="chk"
															style="left: 33px; opacity: unset;"
															onclick="this.value=check(this.form.chk)" /></th>
														<th width="15%"text-align:center;>아이디</th>
														<th width="*%"text-align:center;>이름</th>
														<th width="15%"text-align:center;>모바일폰</th>
														<th width="20%"text-align:center;>이메일</th>
														<th width="10%"text-align:center;>멤버십적립금</th>
														<th width="10%"text-align:center;>회원등급</th>
														<th width="10%"text-align:center;>가입날짜</th>
													</tr>
													<c:choose>
														<c:when test="${empty lists3}">
															<tr>
																<td colspan="8" class="text-center">등록된 회원이 없어요 ㅠㅠ</td>
															</tr>
														</c:when>
														<c:otherwise>
															<c:forEach items="${lists3 }" var="row" varStatus="loop">

																<tr>
																	<td class="text-center"><input type="checkbox"
																		name="chk" value="${row.m_id }"
																		style="left: 33px; opacity: unset;" /></td>
																	<td class="text-center">${row.m_id }</td>
																	<td class="text-left"><a
																		href="ListEdit.do?id=${row.m_id}&boardname=${flag }&m_grade=member&nowPage=${nowPage }">${row.m_name }</a></td>

																	<td class="text-center">${row.m_mobile }</td>
																	<td class="text-center">${row.m_email }</td>
																	<td class="text-center">${row.m_membership }</td>
																	<td class="text-center">${row.authority }</td>
																	<td class="text-center">${row.m_regidate }</td>
																</tr>

															</c:forEach>
														</c:otherwise>
													</c:choose>
												</table>

												<table width="100%" style="border: none;">
													<tr>
														<td align="center" width="100%" style="padding-left: 50%">
															<ul class="pagination" style="justify-content: center;">
																<li>${pagingImg }</li>
															</ul>
														</td>
													</tr>
												</table>
											</div>
										</div>
										<div class="row text-right" style="padding-right: 50px;">


											<button type="button" onclick="MemberInvalid();"
												class="btn btn-default">회원 정보비활성화</button>
											<button type="button" onclick="checkBoxInvalid();"
												class="btn btn-default">전체비활성화</button>

										</div>
									</form:form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</c:when>

			<c:when test="${flag eq 'disabled' }">
				<div id="page-wrapper">
					<div class="header">
						<h1 class="page-header">비활성회원 게시판</h1>
						<ol class="breadcrumb">
							<li><a href="#">Home</a></li>
							<li><a href="#">비활성회원 게시판</a></li>
							<li class="active">Data</li>
						</ol>
					</div>
					<div id="page-inner">

						<div class="row">
							<div class="col-md-12">

								<div class="card">
									<div class="card-action">비활성회원 리스트</div>
									<div>
										<form:form class="form-inline" method="get"
											action="./BoardList.do">
											<input type="hidden" name="boardname"
												value="${param.boardname }" />
											<br />
											<div class="form-group" style="width: 1000px;">
												<select name="searchColumn" class="form-control"
													style="width: 10%">
													<option value="m_id">아이디</option>
													<option value="m_name">이름</option>
												</select>
												<div class="input-group" style="width: 70%">
													<input type="text" name="searchWord" class="form-control"
														style="width: 50%;" />
													<button type="submit" name="검색하기" class="btn btn-default">
														<i class='fas fa-search'></i>
													</button>
												</div>
											</div>
										</form:form>
									</div>

									<form:form
										action="./enabledUser.do?boardname=${flag }&nowPage=${nowPage }"
										method="post" name="frmi" onsubmit="return active();">
										<input type="hidden" value="${nowPage }">
										<input type="hidden" value="${flag }">
										<div class="card-content">
											<div class="table-responsive">
												<table
													class="table table-striped table-bordered table-hover"
													id="dataTables-example">
													<tr>
														<th width="3%"text-align:center;><input
															type="checkbox" id="checkall" name="chk"
															style="left: 33px; opacity: unset;"
															onclick="this.value=check(this.form.chk)" /></th>
														<th width="15%"text-align:center;>아이디</th>
														<th width="*%"text-align:center;>이름</th>
														<th width="15%"text-align:center;>모바일폰</th>
														<th width="20%"text-align:center;>이메일</th>
														<th width="10%"text-align:center;>멤버십적립금</th>
														<th width="10%"text-align:center;>회원등급</th>
														<th width="10%"text-align:center;>가입날짜</th>
													</tr>
													<c:choose>
														<c:when test="${empty lists3}">
															<tr>
																<td colspan="8" class="text-center">등록된 회원이 없어요 ㅠㅠ</td>
															</tr>
														</c:when>
														<c:otherwise>
															<c:forEach items="${lists3 }" var="row" varStatus="loop">

																<tr>
																	<td class="text-center"><input type="checkbox"
																		name="chk" value="${row.m_id }"
																		style="left: 33px; opacity: unset;" /></td>
																	<td class="text-center">${row.m_id }</td>
																	<td class="text-left"><a
																		href="ListEdit.do?id=${row.m_id}&boardname=${flag }&m_grade=member&nowPage=${nowPage }">${row.m_name }</a></td>

																	<td class="text-center">${row.m_mobile }</td>
																	<td class="text-center">${row.m_email }</td>
																	<td class="text-center">${row.m_membership }</td>
																	<td class="text-center">${row.authority }</td>
																	<td class="text-center">${row.m_regidate }</td>
																</tr>

															</c:forEach>
														</c:otherwise>
													</c:choose>
												</table>

												<table width="100%" style="border: none;">
													<tr>
														<td align="center" width="100%" style="padding-left: 50%">
															<ul class="pagination pagination-sm"
																style="justify-content: center;">
																<li>${pagingImg }</li>
															</ul>
														</td>
													</tr>
												</table>
											</div>
											<div class="row text-right" style="padding-right: 50px;">


												<button type="button" onclick="MemberInvalid3();"
													class="btn btn-default">회원정보활성화</button>
												<button type="button" onclick="checkBoxInvalid3();"
													class="btn btn-default">전체활성화</button>

											</div>
										</div>
								</div>
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</c:when>
			<c:when test="${flag eq 'company' }">
				<div id="page-wrapper">
					<div class="header">
						<h1 class="page-header">기업회원 게시판</h1>
						<ol class="breadcrumb">
							<li><a href="#">Home</a></li>
							<li><a href="#">기업회원 게시판</a></li>
							<li class="active">Data</li>
						</ol>
					</div>
					<div id="page-inner">

						<div class="row">
							<div class="col-md-12">

								<div class="card">
									<div class="card-action">기업회원리스트</div>
									<div>
										<form:form class="form-inline" method="get"
											action="./BoardList.do">
											<input type="hidden" name="boardname"
												value="${param.boardname }" />
											<br />
											<div class="form-group" style="width: 1000px;">
												<select name="searchColumn" class="form-control"
													style="width: 10%">
													<option value="m_id">아이디</option>
													<option value="m_name">이름</option>
												</select>
												<div class="input-group" style="width: 70%">
													<input type="text" name="searchWord" class="form-control"
														style="width: 50%;" />
													<button type="submit" name="검색하기" class="btn btn-default">
														<i class='fas fa-search'></i>
													</button>
												</div>
											</div>
										</form:form>
									</div>

									<form:form
										action="./deleteUser.do?boardname=${flag }&nowPage=${nowPage }"
										method="post" name="frmc">
										<input type="hidden" value="${nowPage }">
										<input type="hidden" value="${flag }">
										<div class="card-content">
											<div class="table-responsive">
												<table
													class="table table-striped table-bordered table-hover"
													id="dataTables-example">
													<tr>
														<th width="3%"text-align:center;><input
															type="checkbox" id="checkall" name="chk"
															style="left: 33px; opacity: unset;"
															onclick="this.value=check(this.form.chk)" /></th>
														<th width="15%"text-align:center;>아이디</th>
														<th width="*%"text-align:center;>이름</th>
														<th width="15%"text-align:center;>모바일폰</th>
														<th width="20%"text-align:center;>이메일</th>
														<th width="10%"text-align:center;>멤버십적립금</th>
														<th width="10%"text-align:center;>회원등급</th>
														<th width="10%"text-align:center;>가입날짜</th>
													</tr>
													<c:choose>
														<c:when test="${empty lists3}">
															<tr>
																<td colspan="8" class="text-center">등록된 회원이 없어요 ㅠㅠ</td>
															</tr>
														</c:when>
														<c:otherwise>
															<c:forEach items="${lists3 }" var="row" varStatus="loop">

																<tr>
																	<td class="text-center"><input type="checkbox"
																		name="chk" value="${row.m_id }"
																		style="left: 33px; opacity: unset;" /></td>
																	<td class="text-center">${row.m_id }</td>
																	<td class="text-left"><a
																		href="ListEdit.do?id=${row.m_id}&boardname=${flag }&m_grade=member&nowPage=${nowPage }">${row.m_name }</a></td>

																	<td class="text-center">${row.m_mobile }</td>
																	<td class="text-center">${row.m_email }</td>
																	<td class="text-center">${row.m_membership }</td>
																	<td class="text-center">${row.authority }</td>
																	<td class="text-center">${row.m_regidate }</td>
																</tr>

															</c:forEach>
														</c:otherwise>
													</c:choose>
												</table>

												<table width="100%" style="border: none;">
													<tr>
														<td align="center" width="100%" style="padding-left: 50%">
															<ul class="pagination pagination-sm"
																style="justify-content: center;">
																<li>${pagingImg }</li>
															</ul>
														</td>
													</tr>
												</table>
											</div>
											<div class="row text-right" style="padding-right: 50px;">
												<button type="button" onclick="MemberInvalid2();"
													class="btn btn-default">회원 정보비활성화</button>
												<button type="button" onclick="checkBoxInvalid2();"
													class="btn btn-default">전체비활성화</button>

											</div>
										</div>
								</div>
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</c:when>
			<c:when test="${flag eq 'admin' }">
				<div id="page-wrapper">
					<div class="header">
						<h1 class="page-header">관리자 게시판</h1>
						<ol class="breadcrumb">
							<li><a href="#">Home</a></li>
							<li><a href="#">관리자 게시판</a></li>
							<li class="active">Data</li>
						</ol>
					</div>
					<div id="page-inner">

						<div class="row">
							<div class="col-md-12">
								<div class="card">
									<div class="card-action">관리자리스트</div>
									<div>
										<form:form class="form-inline" method="get"
											action="./BoardList.do">
											<input type="hidden" name="boardname"
												value="${param.boardname }" />
											<br />
											<div class="form-group" style="width: 1000px;">
												<select name="searchColumn" class="form-control"
													style="width: 10%">
													<option value="m_id">아이디</option>
													<option value="m_name">이름</option>
												</select>
												<div class="input-group" style="width: 70%">
													<input type="text" name="searchWord" class="form-control"
														style="width: 50%;" />
													<button type="submit" name="검색하기" class="btn btn-default">
														<i class='fas fa-search'></i>
													</button>
												</div>
											</div>
										</form:form>
									</div>

									<form:form
										action="deleteUser.do?boardname=${flag }&nowPage=${nowPage }"
										method="post">
										<input type="hidden" value="${nowPage }">
										<input type="hidden" value="${flag }">
										<div class="card-content">
											<div class="table-responsive">
												<table
													class="table table-striped table-bordered table-hover"
													id="dataTables-example">
													<tr>
														<th width="3%"text-align:center;><input
															type="checkbox" id="checkall" name="chk"
															style="left: 33px; opacity: unset;"
															onclick="this.value=check(this.form.chk)" /></th>
														<th width="15%"text-align:center;>아이디</th>
														<th width="*%"text-align:center;>이름</th>
														<th width="15%"text-align:center;>모바일폰</th>
														<th width="20%"text-align:center;>이메일</th>
														<th width="10%"text-align:center;>멤버십적립금</th>
														<th width="10%"text-align:center;>회원등급</th>
														<th width="10%"text-align:center;>가입날짜</th>
													</tr>
													<c:choose>
														<c:when test="${empty lists3}">
															<tr>
																<td colspan="8" class="text-center">등록된 회원이 없어요 ㅠㅠ</td>
															</tr>
														</c:when>
														<c:otherwise>
															<c:forEach items="${lists3 }" var="row" varStatus="loop">

																<tr>
																	<td class="text-center"><input type="checkbox"
																		name="chk" value="${row.m_id }"
																		style="left: 33px; opacity: unset;" /></td>
																	<td class="text-center">${row.m_id }</td>
																	<td class="text-left"><a
																		href="./ListEdit.do?id=${row.m_id}&boardname=${flag }&nowPage=${nowPage }">${row.m_name }</a></td>

																	<td class="text-center">${row.m_mobile }</td>
																	<td class="text-center">${row.m_email }</td>
																	<td class="text-center">${row.m_membership }</td>
																	<td class="text-center">${row.authority }</td>
																	<td class="text-center">${row.m_regidate }</td>
																</tr>

															</c:forEach>
														</c:otherwise>
													</c:choose>
												</table>
												<table width="100%" style="border: none;">
													<tr>
														<td align="center" width="100%" style="padding-left: 50%">
															<ul class="pagination pagination-sm"
																style="justify-content: center;">
																<li>${pagingImg }</li>
															</ul>
														</td>
													</tr>
												</table>
											</div>
										</div>
								</div>
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</c:when>
			<c:when test="${flag eq 'tickets' }">
				<div id="page-wrapper">
					<div class="header">
						<h1 class="page-header">이용권 게시판</h1>
						<ol class="breadcrumb">
							<li><a href="#">Home</a></li>
							<li><a href="#">이용권 게시판</a></li>
							<li class="active">Data</li>
						</ol>
					</div>
					<div id="page-inner">

						<div class="row">
							<div class="col-md-12">
								<div class="card">
									<div class="card-action">이용권리스트</div>
									<div>
										<form:form class="form-inline" method="get"
											action="./BoardList.do">
											<input type="hidden" name="boardname"
												value="${param.boardname }" />
											<br />
											<div class="form-group" style="width: 1000px;">
												<select name="searchColumn" class="form-control"
													style="width: 20%">
													<option value="t_name">이용권이름</option>
													<option value="t_price">가격</option>
												</select>
												<div class="input-group" style="width: 70%">
													<input type="text" name="searchWord" class="form-control"
														style="width: 50%;" />
													<button type="submit" name="검색하기" class="btn btn-default">
														<i class='fas fa-search'></i>
													</button>
												</div>
											</div>
										</form:form>
									</div>

									<form:form
										action="deleteUser.do?boardname=${flag }&nowPage=${nowPage }"
										method="post">
										<input type="hidden" value="${nowPage }">
										<input type="hidden" value="${flag }">
										<div class="card-content">
											<div class="table-responsive">
												<table
													class="table table-striped table-bordered table-hover"
													id="dataTables-example">
													<tr>
														<th width="15%"text-align:center;>이용권일련번호</th>
														<th width="*%"text-align:center;>이용권이름</th>
														<th width="20%"text-align:center;>가격</th>
														<th width="15%"text-align:center;>테마파크일련번호</th>
													</tr>
													<c:choose>
														<c:when test="${empty ticketlists}">
															<tr>
																<td colspan="4" class="text-center">등록된 회원이 없어요 ㅠㅠ</td>
															</tr>
														</c:when>
														<c:otherwise>
															<c:forEach items="${ticketlists }" var="row"
																varStatus="loop">				

																<tr>
																	<td class="text-center">${row.t_idx }</td>
																	<td class="text-center"><a
																		href="./TicketViewEdit.do?boardname=tickets&t_idx=${row.t_idx}&nowPage=${param.nowPage}">${row.t_name }</a></td>
																	<td class="text-left">${row.t_price }원</td>
																	<td class="text-center">${row.tp_idx }</td>
																</tr>

															</c:forEach>
														</c:otherwise>
													</c:choose>
												</table>
												<table width="100%" style="border: none;">
													<tr>
														<td align="center" width="100%" style="padding-left: 50%">
															<ul class="pagination pagination-sm"
																style="justify-content: center;">
																<li>${pagingImg }</li>
															</ul>
														</td>
													</tr>
												</table>
											</div>
										</div>
								</div>
								</form:form>
							</div>
						</div>
					</div>
				</div>
			</c:when>

		</c:choose>
	</div>
	<!-- /. PAGE WRAPPER  -->
	<!-- /. WRAPPER  -->
	<!-- JS Scripts-->


	<!-- jQuery Js -->
	<script src="../assets/js/jquery-1.10.2.js"></script>

	<!-- Bootstrap Js -->
	<script src="../assets/js/bootstrap.min.js"></script>

	<script src="../assets/materialize/js/materialize.min.js"></script>

	<!-- Metis Menu Js -->
	<script src="../assets/js/jquery.metisMenu.js"></script>
	<!-- Morris Chart Js -->
	<script src="../assets/js/morris/raphael-2.1.0.min.js"></script>
	<script src="../assets/js/morris/morris.js"></script>


	<script src="../assets/js/easypiechart.js"></script>
	<script src="../assets/js/easypiechart-data.js"></script>

	<script src="../assets/js/Lightweight-Chart/jquery.chart.js"></script>
	<!-- DATA TABLE SCRIPTS -->
	<script src="../assets/js/dataTables/jquery.dataTables.js"></script>
	<script src="../assets/js/dataTables/dataTables.bootstrap.js"></script>
	<!-- Custom Js -->
	<script src="../assets/js/custom-scripts.js"></script>
</body>

</html>