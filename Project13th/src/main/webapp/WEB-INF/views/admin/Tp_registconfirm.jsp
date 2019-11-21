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
<style>
.file_input label {
	position: relative;
	cursor: pointer;
	display: inline-block;
	vertical-align: middle;
	overflow: hidden;
	width: 100px;
	height: 30px;
	background: #5fb6df;
	color: #fff;
	text-align: center;
	line-height: 30px;
	clip: rect(0, 0, 0, 0);
	border-radius: .25em;
	font-size: 0.9em;
	font-weight: bold;
}

.file_input label input {
	position: absolute;
	width: 0;
	height: 0;
	overflow: hidden;
}

.file_input input[type=text] {
	vertical-align: middle;
	display: inline-block;
	width: 400px;
	height: 28px;
	line-height: 28px;
	font-size: 11px;
	padding: 0;
	border: 0;
	border: 1px solid #777;
}

.file_input label:hover {
	background-color: #6ed36e;
}

.file_input label:active {
	background-color: #367c36;
}

select {
	margin-left: 0px;
	padding: .8em .5em;
	border: 1px solid #999;
	font-family: inherit;
	background: url('arrow.jpg') no-repeat 95% 50%;
	border-radius: .25em;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
}

select::-ms-expand {
	display: none;
}
</style>
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
				<a class="navbar-brand waves-effect waves-dark" href="AdminIndex.do"><i
					class='fab fa-kickstarter' style='font-size: 24px'></i> <strong>ParkMoa</strong></a>
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
						href="./AdminIndex.do"><i class="fa fa-dashboard"></i> ParkMoa</a></li>

					<li><a href="#" class="waves-effect waves-dark"><i
							class="fa fa-sitemap"></i> 게시판<span class="fa arrow"></span></a>
						<ul class="nav nav-second-level">
							<li><a href="./BoardList.do?boardname=event"
								class="waves-effect waves-dark"><i class="fa fa-table"></i>
									이벤트공지게시판</a></li>
							<li><a href="./BoardList.do?boardname=faq"
								class="waves-effect waves-dark"><i class="fa fa-table"></i>
									문의게시판</a></li>
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
		<!--/. NAV TOP  -->
		<!-- /. NAV SIDE  -->
		<div id="page-wrapper">
			<div class="header">
				<h1 class="page-header">테마파크승인</h1>

			</div>
			<div id="page-inner">

				<div class="row">

					<div class="col-md-12">
						<div class="card">
							<div class="card-action">테마파크승인</div>
							<div class="card-content">
								<div class="layer_fix layer_unfix pop_login pop_mem_reserve">
									<section>
										<form:form name="tp_registconfirFrm" id="tp_registconfirmFrm"
											action="./ConfirmList.do" autocomplete="off" method="post">
											<input type="hidden" name="tp_category"
												value="${dto.tp_category }" />
											<input type="hidden" name="tp_idx" value="${dto.tp_idx}" />
											<input type="hidden" name="nowPage" value="${param.nowPage}" />
											<input type="hidden" name="tp_attach"
												value="${dto.tp_attach }" />
											<div class="inp_type_1 ">
												<!-- focus / err -->
												<input type="text" name="m_id" readonly="readonly"
													value="${dto.m_id }" data-msg-required="아이디를 입력해 주세요." />
											</div>
											<div class="inp_type_1 ">
												<!-- focus / err -->
												<input type="text" name="tp_name" value="${dto.tp_name }"
													readonly="readonly" />
											</div>
											<div class="inp_type_1 ">
												<!-- focus / err -->
												<select class="form-control" style="width: 335px;"
													name="kinds" readonly="readonly">
													<option value="0">테마파크 종류를 선택하세요</option>
													<option value="park"
														<c:if test="${dto.tp_category eq 'park'}">selected</c:if>>
														놀이동산</option>
													<option value="water"
														<c:if test="${dto.tp_category eq 'water'}">selected</c:if>>
														워터파크</option>
													<option value="zoo"
														<c:if test="${dto.tp_category eq 'zoo'}">selected</c:if>>
														동물원/아쿠아리움</option>
													<option value="tree"
														<c:if test="${dto.tp_category eq 'forest'}">selected</c:if>>
														수목원</option>
												</select>
											</div>
											<div class="inp_type_1 ">
												<select class="form-control" style="width: 335px;"
													name="tp_parkregi" readonly="readonly">
													<option value="0">주차장 등록여부를 선택하세요</option>
													<option value="yes"
														<c:if test="${dto.tp_parkregi eq 'yes'}">selected</c:if>>
														등록</option>
													<option value="no"
														<c:if test="${dto.tp_parkregi eq 'no'}">selected</c:if>>
														미등록</option>
												</select>
											</div>

											<c:choose>
												<c:when test="${dto.p_idx eq '1' }">
													등록된 주차장이 없습니다.
												</c:when>

												<c:otherwise>
													<div class="inp_type_1" style="margin-top: 6px;">
														주차장: <input type="text" name="tp_phone"
															readonly="readonly" style="width: 80%;"
															value="${dto.p_idx}" />
													</div>
												</c:otherwise>
											</c:choose>

											<div class="inp_type_1" style="margin-top: 6px;">
												<input type="text" name="tp_phone" readonly="readonly"
													value="${dto.tp_phone}" />
											</div>
											<div class="inp_type_1 ">
												<input type="text" name="tp_addr1" readonly="readonly"
													value="${dto.tp_addr1}" />
											</div>
											<table style="margin: auto;">
												<tr>
													<td><textarea name="tp_content" rows="10"
															class="form-control" readonly="readonly">${dto.tp_content }</textarea>
													</td>
												</tr>
												<tr>
													<td style="width: 1000px;">
														<div class="file_input" style="margin-top: 3px;">
															<label>대표사진<input type="file"
																onchange="getCmaFileView(); javascript:document.getElementById('file_route').value=this.value"
																id="file_upload_field" name="file_upload_field"
																accept=".jpg, .gif, .jpeg, .png">
															</label> <input type="text" readonly="readonly"
																title="File Route" id="file_route"
																style="width: 200px; border: none;"
																name="tp_realfilename" value="${dto.tp_realfilename }">
														</div>
													</td>
												</tr>
											</table>
											<div class="inp_type_1 ">
												<table class="table table-bordered">
													<tr>
														<th class="text-left" style="vertical-align: middle;">이용권</th>
													</tr>
													<c:choose>
														<c:when test="${empty Tkdto }">
															<td>등록된 이용권이 없습니다.</td>
														</c:when>
														<c:otherwise>
															<c:forEach items="${Tkdto }" var="rows10"
																varStatus="loop">
																<td class="form-control">${rows10.t_name }:
																	&nbsp;${rows10.t_price }원</td>
															</c:forEach>
														</c:otherwise>
													</c:choose>
												</table>
											</div>
											<div class="file_input" style="width: 1000px; align: center;">
												<button class="btn btn-primary" type="submit" name="confirm"
													value="confirm" style="width: 168px; height: 60px;">
													<span style="font-weight: bold; font-size: 1.5em;">승인</span>
												</button>
												<button class="btn btn-danger" type="submit" name="confirm"
													value="reject" style="width: 168px; height: 60px;">
													<span style="font-weight: bold; font-size: 1.5em;">거절</span>
												</button>
											</div>
										</form:form>
									</section>
								</div>

								<div class="clearBoth">
									<br />
								</div>
							</div>
						</div>
						<!-- /. PAGE INNER  -->
					</div>
					<!-- /. PAGE WRAPPER  -->
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