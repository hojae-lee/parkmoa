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
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
<script>
	function checkWrite(f) {
		if (f.title.value == "") {
			alert("제목을 입력해주세요.");
			f.title.focus();
			return false;
		}
		if (f.content.value == "") {
			alert("내용을 입력해주세요.");
			f.content.focus();
			return false;
		}
	}
</script>
</head>
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
				<h1 class="page-header">글쓰기</h1>

			</div>

			<c:choose>
				<c:when test="${flag eq 'event' }">
					<div id="page-inner">

						<div class="row">

							<div class="col-md-12">
								<div class="card">
									<div class="card-action">이벤트공지글쓰기</div>
									<div class="card-content">
										<form:form action="./ListWriteAction.do" name="writeFrm"
											method="post" enctype="multipart/form-data"
											onsubmit="return checkWrite(this);">
											<table class="table table-bordered">
												<colgroup>
													<col width="15%" />
													<col width="60" />
												</colgroup>
												<input type="hidden" name="b_flag"
													value="${param.boardname }" />
												<input type="hidden" name="m_id" value="${m_id }" />
												<tr>
													<th class="text-center" style="vertical-align: middle;">이벤트제목</th>
													<td><input type="text" class="form-control"
														name="b_title" style="width: 80%" value="" /></td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">이벤트내용</th>
													<td><textarea name="b_content" rows="10"
															class="form-control"></textarea></td>
												</tr>
											</table>

											<div class="row text-center" style="padding-left: 10%;">
												<button type="submit" class="btn btn-info">작성완료</button>
												<button type="reset" class="btn btn-light">Reset</button>
												<a href="./BoardList.do?boardname=${param.boardname }"><button
														type="button" class="btn btn-warning" onclick="">리스트보기</button></a>
											</div>
										</form:form>
										<div class="clearBoth">
											<br />
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</c:when>
				<c:when test="${flag eq 'faq' }">
					<div id="page-inner">

						<div class="row">

							<div class="col-md-12">
								<div class="card">
									<div class="card-action">문의게시판글쓰기</div>
									<div class="card-content">
										<form:form action="./ListWriteAction.do" name="writeFrm"
											method="post" enctype="multipart/form-data"
											onsubmit="return checkWrite(this);">
											<table class="table table-bordered">
												<colgroup>
													<col width="15%" />
													<col width="60" />
												</colgroup>
												<input type="hidden" name="b_flag"
													value="${param.boardname }" />
												<input type="hidden" name="m_id" value="${m_id }" />
												<tr>
													<th class="text-center" style="vertical-align: middle;">문의게시판제목</th>
													<td><input type="text" class="form-control"
														name="b_title" style="width: 80%" value="" /></td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">문의게시판내용</th>
													<td><textarea name="b_content" rows="10"
															class="form-control"></textarea></td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">문의게시판첨부파일</th>
													<td><input type="file" name="fileNm" id="fileNm"
														class="form-control" /></td>
												</tr>
											</table>

											<div class="row text-center" style="padding-left: 10%;">
												<button type="submit" class="btn btn-info">작성완료</button>
												<button type="reset" class="btn btn-light">Reset</button>
												<a href="./BoardList.do?boardname=${param.boardname }"><button
														type="button" class="btn btn-warning" onclick="">리스트보기</button></a>
											</div>
										</form:form>
										<div class="clearBoth">
											<br />
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</c:when>
				<c:when test="${flag eq 'themeconfirm' }">
					<div id="page-inner">

						<div class="row">

							<div class="col-md-12">
								<div class="card">
									<div class="card-action">테마파크등록</div>
									<div class="card-content">
										<form:form action="./ListWriteAction.do" name="writeFrm"
											method="post" enctype="multipart/form-data"
											onsubmit="return checkWrite(this);">
											<table class="table table-bordered">
												<colgroup>
													<col width="15%" />
													<col width="60" />
												</colgroup>
												<input type="hidden" name="b_flag"
													value="${param.boardname }" />
												<input type="hidden" name="m_id" value="1q2w3e4r" />
												<tr>
													<th class="text-center" style="vertical-align: middle;">테마파크등록제목/th>




													
													<td><input type="text" class="form-control"
														name="tp_name" style="width: 80%" value="" /></td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">테마파크등록내용</th>
													<td><textarea name="tp_content" rows="10"
															class="form-control"></textarea></td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">테마파크등록첨부파일</th>
													<td><input type="file" name="fileNm" id="fileNm"
														class="form-control" /></td>
												</tr>
											</table>

											<div class="row text-center" style="padding-left: 10%;">
												<button type="submit" class="btn btn-info">작성완료</button>
												<button type="reset" class="btn btn-light">Reset</button>
												<a href="./BoardList.do?boardname=${param.boardname }"><button
														type="button" class="btn btn-warning" onclick="">리스트보기</button></a>
											</div>
										</form:form>
										<div class="clearBoth">
											<br />
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>

				</c:when>
			</c:choose>

		</div>
	</div>
	<!-- /. WRAPPER  -->
	<!-- JS Scripts-->
	<!-- jQuery Js -->
	<script src="../assets/js/jquery-1.10.2.js"></script>

	<!-- Bootstrap Js -->
	<script src="../assets/js/bootstrap.min.js"></script>

	<script src="../assets/materialize/js/materialize.min.js"></script>

	<!-- Metis Menu Js -->
	<script src="../assets/js/jquery.metisMenu.js"></script>
	<!-- Custom Js -->
	<script src="../assets/js/custom-scripts.js"></script>
</body>