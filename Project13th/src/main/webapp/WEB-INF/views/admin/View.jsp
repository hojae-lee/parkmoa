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
						테마파크승인<c:if test="${themeregistcount != 0 }">
							<i class='fas fa-exclamation-circle'
								style="font-size: 16pt; color: yellow;"></i>
						</c:if></a></li>
				<li><a href="./BoardList.do?boardname=tickets"
					class="waves-effect waves-dark"><i class="fa fa-fw fa-file"></i>
						이용권정보</a></li>
				</ul>
			</div>

		</nav>
		<!-- /. NAV SIDE  -->
		<div id="page-wrapper">
			<div class="header">
				<h1 class="page-header">상세보기</h1> 

			</div>
			<c:choose>
				<c:when test="${flag eq 'event' }">
					<div id="page-inner">

						<div class="row">

							<div class="col-md-12">
								<div class="card">
									<div class="card-action">게시판 상세보기</div>
									<div class="card-content">
										<form action="" name="InfoViewFrm" method="post"
											onsubmit="return checkWrite(this);">
											<table class="table table-bordered">
												<colgroup>
													<col width="15%" />
													<col width="60" />
												</colgroup>
												<input type="hidden" name="boardname" value="${dto.b_idx }" />
												<input type="hidden" name="nowPage"
													value="${param.nowPage }" />

												<tr>
													<th class="text-center" style="vertical-align: middle;">제목</th>
													<td class="form-control" name="title" style="width: 100%">${dto.b_title }</td>
												</tr>

												<tr>
													<th class="text-center" style="vertical-align: middle;">내용</th>
													<td name="content">${dto.b_content }</td>
												</tr>
											</table>

											<div class="row text-center" style="padding-left: 10%;">
												<a
													href="./BoardEdit.do?boardname=${dto.b_flag }&b_idx=${dto.b_idx}&nowPage=${param.nowPage}"><button
														type="button" class="btn btn-info">수정하기</button></a> <a
													href="./BoardDelete.do?b_idx=${dto.b_idx }&boardname=${dto.b_flag }&nowPage=${param.nowPage }">
													<button type="button" class="btn btn-light">삭제하기</button>
												</a> <a href="./BoardList.do?boardname=${dto.b_flag }"><button
														type="button" class="btn btn-warning" onclick="">리스트보기</button></a>
											</div>
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
									<div class="card-action">게시판 상세보기</div>
									<div class="card-content">
										<form action="" name="InfoViewFrm" method="post"
											onsubmit="return checkWrite(this);">
											<table class="table table-bordered">
												<colgroup>
													<col width="15%" />
													<col width="60" />
												</colgroup>
												<input type="hidden" name="b_idx" value="${dto.b_idx }" />
												<input type="hidden" name="nowPage"
													value="${param.nowPage }" />

												<tr>
													<th class="text-center" style="vertical-align: middle;">제목</th>
													<td class="form-control" name="title" style="width: 100%">${dto.b_title }</td>
												</tr>

												<tr>
													<th class="text-center" style="vertical-align: middle;">내용</th>
													<td name="content">${dto.b_content }</td>
												</tr>

												<tr>
													<th class="text-center" style="vertical-align: middle;">첨부파일</th>
													<td class="form-control" name="title" style="width: 100%"><a
														href="./fileDownload.do?fileName=${dto.b_attachedfile }&oriFileName=${dto.b_realfilename}">${dto.b_realfilename }</a></td>
												</tr>
											</table>

											<div class="row text-center" style="padding-left: 10%;">
												<a
													href="./BoardReply.do?b_idx=${dto.b_idx }&boardname=${dto.b_flag }&nowPage=${param.nowPage }"><button
														type="button" class="btn btn-primary">답변글 쓰기</button></a> <a
													href="./BoardEdit.do?boardname=${dto.b_flag }&b_idx=${dto.b_idx}&nowPage=${param.nowPage}"><button
														type="button" class="btn btn-info">수정하기</button></a> <a
													href="./BoardDelete.do?b_idx=${dto.b_idx }&boardname=${dto.b_flag }&nowPage=${param.nowPage }">
													<button type="button" class="btn btn-light">삭제하기</button>
												</a> <a href="./BoardList.do?boardname=${dto.b_flag }"><button
														type="button" class="btn btn-warning" onclick="">리스트보기</button></a>
											</div>
											<div class="clearBoth">
												<br />
											</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:when>
				<c:when test="${flag eq 'park' }">
					<div id="page-inner">

						<div class="row">

							<div class="col-md-12">
								<div class="card">
									<div class="card-action">게시판 상세보기</div>
									<div class="card-content">
										<form action="" name="InfoViewFrm" method="post"
											onsubmit="return checkWrite(this);">
											<table class="table table-bordered">
												<colgroup>
													<col width="15%" />
													<col width="60%" />
												</colgroup>
												<input type="hidden" name="b_idx" value="${dto.tp_idx }" />
												<input type="hidden" name="nowPage"
													value="${param.nowPage }" />

												<tr>
													<th class="text-center" style="vertical-align: middle;">제목</th>
													<td class="form-control" name="title" >${dto.tp_name }</td>
												</tr>

												<tr>
													<th class="text-center" style="vertical-align: middle;">내용</th>
													<td name="content">${dto.tp_content }</td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">주차여부</th>
													<td name="content">${dto.tp_parkregi }</td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">주차장등록여부</th>
													<td>
														<c:choose>
															<c:when test="${dto.p_idx eq '1' }">
															등록된 주차장이 없습니다.
															</c:when>
		
															<c:otherwise>			
																		${dto.p_idx}번
															</c:otherwise>
														</c:choose>
													</td>
												</tr>
												

												<tr>
													<th class="text-center" style="vertical-align: middle;">폰</th>
													<td name="content">${dto.tp_phone }</td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">주소</th>
													<td name="content">${dto.tp_addr1 }</td>
												</tr>
 
												<tr>
													<th class="text-center" style="vertical-align: middle;">첨부파일</th>
													<td class="form-control" name="title" ><a
														href="./fileDownload.do?fileName=${dto.tp_attach }&oriFileName=${dto.tp_realfilename}">${dto.tp_realfilename }</a></td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">귀여워</th>
													<td name="title" style="width: 100%"><img
														src="../resources/upload/${dto.tp_attach }" width="30%"
														height="" /></td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">이용권</th>
													<c:choose>
														<c:when test="${empty ticketlists }">
															<td>등록된 이용권이 없습니다.</td>
														</c:when>
														<c:otherwise>
															<c:forEach items="${ticketlists }" var="row"
																varStatus="loop">
																<td class="form-control">${row.t_name }&nbsp;${row.t_price }원</td>
															</c:forEach>
														</c:otherwise>
													</c:choose>
												</tr>
											</table>

											<div class="row text-center" style="padding-left: 10%;">
												<a
													href="./BoardDelete.do?tp_idx=${dto.tp_idx }&boardname=${dto.tp_category }&nowPage=${param.nowPage }">
													<button type="button" class="btn btn-light">삭제하기</button>
												</a> <a href="./BoardList.do?boardname=${dto.tp_category }"><button
														type="button" class="btn btn-warning" onclick="">리스트보기</button></a>
											</div>
											<div class="clearBoth">
												<br />
											</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:when>
				<c:when test="${flag eq 'water' }">
					<div id="page-inner">

						<div class="row">

							<div class="col-md-12">
								<div class="card">
									<div class="card-action">게시판 상세보기</div>
									<div class="card-content">
										<form action="" name="InfoViewFrm" method="post"
											onsubmit="return checkWrite(this);">
											<table class="table table-bordered">
												<colgroup>
													<col width="15%" />
													<col width="60%" />
												</colgroup>
												<input type="hidden" name="b_idx" value="${dto.tp_idx }" />
												<input type="hidden" name="nowPage"
													value="${param.nowPage }" />

												<tr>
													<th class="text-center" style="vertical-align: middle;">제목</th>
													<td class="form-control" name="title" style="width: 100%">${dto.tp_name }</td>
												</tr>

												<tr>
													<th class="text-center" style="vertical-align: middle;">내용</th>
													<td name="content">${dto.tp_content }</td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">주차여부</th>
													<td name="content">${dto.tp_parkregi }</td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">폰</th>
													<td name="content">${dto.tp_phone }</td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">주소</th>
													<td name="content">${dto.tp_addr1 }</td>
												</tr>

												<tr>
													<th class="text-center" style="vertical-align: middle;">첨부파일</th>
													<td class="form-control" name="title" style="width: 100%"><a
														href="./fileDownload.do?fileName=${dto.tp_attach }&oriFileName=${dto.tp_realfilename}">${dto.tp_realfilename }</a></td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">귀여워</th>
													<td name="title" style="width: 100%"><img
														src="../resources/upload/${dto.tp_attach }" width="30%"
														height="" /></td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">이용권</th>
													<c:choose>
														<c:when test="${empty ticketlists }">
															<td>등록된 이용권이 없습니다.</td>
														</c:when>
														<c:otherwise>
															<c:forEach items="${ticketlists }" var="row"
																varStatus="loop">
																<td class="form-control">${row.t_name }&nbsp;${row.t_price }원</td>
															</c:forEach>
														</c:otherwise>
													</c:choose>
												</tr>
											</table>

											<div class="row text-center" style="padding-left: 10%;">
												<a
													href="./BoardDelete.do?tp_idx=${dto.tp_idx }&boardname=${dto.tp_category }&nowPage=${param.nowPage }">
													<button type="button" class="btn btn-light">삭제하기</button>
												</a> <a href="./BoardList.do?boardname=${dto.tp_category }"><button
														type="button" class="btn btn-warning" onclick="">리스트보기</button></a>
											</div>
											<div class="clearBoth">
												<br />
											</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:when>
				<c:when test="${flag eq 'zoo' }">
					<div id="page-inner">

						<div class="row">

							<div class="col-md-12">
								<div class="card">
									<div class="card-action">게시판 상세보기</div>
									<div class="card-content">
										<form action="" name="InfoViewFrm" method="post"
											onsubmit="return checkWrite(this);">
											<table class="table table-bordered">
												<colgroup>
													<col width="15%" />
													<col width="60%" />
												</colgroup>
												<input type="hidden" name="b_idx" value="${dto.tp_idx }" />
												<input type="hidden" name="nowPage"
													value="${param.nowPage }" />

												<tr>
													<th class="text-center" style="vertical-align: middle;">제목</th>
													<td class="form-control" name="title" style="width: 100%">${dto.tp_name }</td>
												</tr>

												<tr>
													<th class="text-center" style="vertical-align: middle;">내용</th>
													<td name="content">${dto.tp_content }</td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">주차여부</th>
													<td name="content">${dto.tp_parkregi }</td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">폰</th>
													<td name="content">${dto.tp_phone }</td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">주소</th>
													<td name="content">${dto.tp_addr1 }</td>
												</tr>

												<tr>
													<th class="text-center" style="vertical-align: middle;">첨부파일</th>
													<td class="form-control" name="title" style="width: 100%"><a
														href="./fileDownload.do?fileName=${dto.tp_attach }&oriFileName=${dto.tp_realfilename}">${dto.tp_realfilename }</a></td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">귀여워</th>
													<td name="title" style="width: 100%"><img
														src="../resources/upload/${dto.tp_attach }" width="30%"
														height="" /></td>
												</tr>
												<tr>
													<th class="text-center" style="vertical-align: middle;">이용권</th>
													<c:choose>
														<c:when test="${empty ticketlists }">
															<td>등록된 이용권이 없습니다.</td>
														</c:when>
														<c:otherwise>
															<c:forEach items="${ticketlists }" var="row"
																varStatus="loop">
																<td class="form-control">${row.t_name }&nbsp;${row.t_price }원</td>
															</c:forEach>
														</c:otherwise>
													</c:choose>
												</tr>
											</table>

											<div class="row text-center" style="padding-left: 10%;">
												<a
													href="./BoardDelete.do?tp_idx=${dto.tp_idx }&boardname=${dto.tp_category }&nowPage=${param.nowPage }">
													<button type="button" class="btn btn-light">삭제하기</button>
												</a> <a href="./BoardList.do?boardname=${dto.tp_category }"><button
														type="button" class="btn btn-warning" onclick="">리스트보기</button></a>
											</div>
											<div class="clearBoth">
												<br />
											</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:when>
				<c:when test="${flag eq 'forest' }">
					<div id="page-inner">
						<div class="row">
							<div class="col-md-12">
								<div class="card">
									<div class="card-action">게시판 상세보기</div>
									<div class="card-content">
										<table class="table table-bordered">
											<colgroup>
												<col width="15%" />
												<col width="60%" />
											</colgroup>
											<input type="hidden" name="b_idx" value="${dto.tp_idx }" />
											<input type="hidden" name="nowPage"
												value="${param.nowPage }" />

											<tr>
												<th class="text-center" style="vertical-align: middle;">제목</th>
												<td class="form-control" name="title" style="width: 100%">${dto.tp_name }</td>
											</tr>

											<tr>
												<th class="text-center" style="vertical-align: middle;">내용</th>
												<td name="content">${dto.tp_content }</td>
											</tr>
											<tr>
												<th class="text-center" style="vertical-align: middle;">주차여부</th>
												<td name="content">${dto.tp_parkregi }</td>
											</tr>
											<tr>
												<th class="text-center" style="vertical-align: middle;">폰</th>
												<td name="content">${dto.tp_phone }</td>
											</tr>
											<tr>
												<th class="text-center" style="vertical-align: middle;">주소</th>
												<td name="content">${dto.tp_addr1 }</td>
											</tr>

											<tr>
												<th class="text-center" style="vertical-align: middle;">첨부파일</th>
												<td class="form-control" name="title" style="width: 100%"><a
													href="./fileDownload.do?fileName=${dto.tp_attach }&oriFileName=${dto.tp_realfilename}">${dto.tp_realfilename }</a></td>
											</tr>
											<tr>
												<th class="text-center" style="vertical-align: middle;">귀여워</th>
												<td name="title" style="width: 100%"><img
													src="../resources/upload/${dto.tp_attach }" width="30%"
													height="" /></td>
											</tr>
											<tr>
												<th class="text-center" style="vertical-align: middle;">이용권</th>
												<c:choose>
													<c:when test="${empty ticketlists }">
														<td>등록된 이용권이 없습니다.</td>
													</c:when>
													<c:otherwise>
														<c:forEach items="${ticketlists }" var="row"
															varStatus="loop">
															<td class="form-control">${row.t_name }&nbsp;${row.t_price }원</td>
														</c:forEach>
													</c:otherwise>
												</c:choose>
											</tr>
										</table>

										<div class="row text-center" style="padding-left: 10%;">
											<a
												href="./BoardDelete.do?tp_idx=${dto.tp_idx }&boardname=${dto.tp_category }&nowPage=${param.nowPage }">
												<button type="button" class="btn btn-light">삭제하기</button>
											</a> <a href="./BoardList.do?boardname=${dto.tp_category }"><button
													type="button" class="btn btn-warning" onclick="">리스트보기</button></a>
										</div>
										<div class="clearBoth">
											<br />
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:when>
				<c:when test="${flag eq 'payment' }">
					<div id="page-inner">

						<div class="row">

							<div class="col-md-12">
								<div class="card">
									<div class="card-action">결제내역상세보기</div>
									<div class="card-content">
										<table class="table table-striped table-bordered table-hover"
											id="dataTables-example">
											<tr>
												<th width="8%"text-align:center;>결제번호</th>
												<th width="10%"text-align:center;>아이디</th>
												<th width="13%"text-align:center;>테마파크이름</th>
												<th width="*%"text-align:center;>이용권내역</th>
												<th width="12%"text-align:center;>가격</th>
												<th width="8%"text-align:center;>결제일자</th>
												<th width="8%"text-align:center;>이용날자</th>
												<th width="6%"text-align:center;>주차장번호</th>
											</tr>
											<c:choose>              
												<c:when test="${empty list }">
												</c:when>    
												<c:otherwise>
													<c:forEach items="${list }" var="row" varStatus="loop">
														<tr>
															<td class="text-center">${row.pay_idx}</td>
															<td class="text-center">${row.m_id}</td>  
															<td class="text-center">${row.tp_name}</td>
															<td class="text-center">${row.t_name}</td>
															<td class="text-center">${row.pay_price}</td>
															<td class="text-center">${row.pay_regidate}</td>
															<td class="text-center">${row.r_useregi}</td>
															<td class="text-center">${row.p_num}</td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</table>
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