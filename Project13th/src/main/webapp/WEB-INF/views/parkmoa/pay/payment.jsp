<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Parkmoa - 결제</title>
<link rel="icon" href="../../img/Fevicon.png" type="image/png">

<link rel="stylesheet" href="../../vendors/bootstrap/bootstrap.min.css">
<link rel="stylesheet" href="../../vendors/fontawesome/css/all.min.css">
<link rel="stylesheet" href="../../vendors/themify-icons/themify-icons.css">
<link rel="stylesheet" href="../../vendors/linericon/style.css">
<link rel="stylesheet"
   href="../../vendors/owl-carousel/owl.theme.default.min.css">
<link rel="stylesheet" href="../../vendors/owl-carousel/owl.carousel.min.css">
<link rel="stylesheet" href="../../vendors/Magnific-Popup/magnific-popup.css">

<link rel="stylesheet" href="../../css/style.css">
<link rel="stylesheet" href="../../css/swiper.css">
<link rel="stylesheet" href="../../css/main.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
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
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}
</style>
</head>
<script type="text/javascript">
function Aaaa() {

	window.open('../member/themeRegist.do?authority=company','IDWin','width=300','height=100, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
}

//뒤로가기
function goBack() {
	window.history.back(-1);
}

//세자리마다 콤마찍기
function numberWithCommas(n) {
    var parts=n.toString().split(".");
    return parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",") + (parts[1] ? "." + parts[1] : "");
}


//이메일 셀렉트 선택하면 도메인부분에 입력하기
function choiceInput(frm, elem) { 
   for(var i=0; i<elem.length;i++) { 
      if (elem.options[i].selected) {
         if(elem.options[elem.selectedIndex].value!="direct_input"){
            frm.email_domain.value = elem.options[elem.selectedIndex].value;
         }
         else{
            frm.email_domain.value = "";
            frm.email_domain.focus();
         }
      } 
   }
}

$(function () {
   //로딩시 area숨김
   $('.area').hide();
   
   //radio선택시 사용여부에따라 area노출
   $('.parkUse').change(function () {
      var idx = $(this).attr('name');
      if($(this).val() == 'y'){
         $('#area'+idx).show();
         $('#p_num'+idx).text("");
      }else{
         $('#area'+idx).hide();
         $('#p_num'+idx).text("예약안함");
         $('#'+idx).val("");
      }
   });
   
   $('#baseInfo').click(function () {
      
   });
   
   //멤버쉽 계산
	$('#use_Membership').keyup(function () {
		
		var inputNum = $(this).val()
		var max_Membership = $('#max_Membership').val();
		var comma_max_Membership = numberWithCommas(max_Membership);
		
		//음수입력방지
		if($(this).val()<0){
			alert('음수는 입력할 수 없습니다.');
			$(this).val(0);
			$('#discount').text($('#max_Membership').val());
		}
		var change = max_Membership - inputNum;
		$('#after_Membership').val(change);
		
		if($('#after_Membership').val()<0){
			alert('최대 '+comma_max_Membership+"원 사용가능합니다.");
			$('#after_Membership').val(0);
			$(this).val(max_Membership);
			change = 0;
			inputNum = max_Membership;
		}
		var commachange = numberWithCommas(change);
		var commainputNum = numberWithCommas(inputNum);
		$('#change').text(commachange);
		$('#discount').text(commainputNum);
		var total_Price = $('#totalPrice').val() - inputNum;
		var commatotal_Price = numberWithCommas(total_Price);
		$('#total_Price').val(total_Price);
		$('#total_Price1').text(commatotal_Price);
	});
   
   $('#useAllMembership').click(function () {
	    var max_Membership = $('#max_Membership').val();
	    var total_Price = $('#totalPrice2').val()-max_Membership;
	    
	    $('#change').text(0);
	    $('#use_Membership').val(max_Membership);
	   	$('#total_Price').val(total_Price);
	   	$('#discount').text(numberWithCommas(max_Membership));
	   	$('#after_Membership').val(0);
		$('#total_Price1').text(numberWithCommas(total_Price));
   });
   
   //주차장 버튼 클릭시 클래스변경
   $(document).on('click',".btn-outline-primary", function () {
      var name = $(this).attr('name');
      $('button[name='+name+']').attr('class', 'btn btn-secondary').attr('disabled', true);
      $(this).attr('class', 'btn btn-primary').attr('disabled', false);
      
      //input태그에 값 삽입
      $('#'+name).val($(this).text());
      $('#p_num'+name).html($(this).text()+"번 선택됨");
   });
   
   $(document).on('click',".btn-primary", function () {
      var name = $(this).attr('name');
      $(this).attr('class', 'btn btn-outline-primary');
      $('button[name='+name+']').attr('class', 'btn btn-outline-primary').attr('disabled', false);
      $('#'+name).val(""); 
      $('#p_num'+name).html("");
   });
   
   //결제창 api
   $('#payAction').click(function () {
      var IMP = window.IMP; // 생략가능
        IMP.init('imp90689490'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;
        
        IMP.request_pay({
            pg : 'kakaopay',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : 'ParkMoa 이용권 결제',
            amount : $('input[name=total_Price]').val(),
            buyer_email : $('input[name=m_email]').val(),
            buyer_name : $('input[name=m_id]').val(),
            buyer_tel : $('input[name=m_mobile]').val()
            //m_redirect_url : 'http://www.naver.com'
        }, function(rsp) {
            if ( rsp.success ) {
                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                jQuery.ajax({
                    url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                }).done(function(data) {
                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                    if ( everythings_fine ) {
                        msg = '결제가 완료되었습니다.';
                        msg += '\n고유ID : ' + rsp.imp_uid;
                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                        msg += '\결제 금액 : ' + rsp.paid_amount;
                        msg += '카드 승인번호 : ' + rsp.apply_num;
                        
                        alert(msg);
                    } else {
                        //[3] 아직 제대로 결제가 되지 않았습니다.
                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                    }
                });
                //성공시 submit;
                paymentAction();
            } else {
                msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                //실패시 alert
                alert(msg);
            }
        });
   });

});

function paymentAction() {
   f = document.payFrm;
   f.action = "./paymentAction.do";
   f.method = "post";
   f.submit();
}


</script>
<body>
<!--================ Header Top Area Start =================-->
   <section class="header-top d-none d-sm-block" style="background-color: #5fb6df">
      <div class="container">
         <div class="d-sm-flex justify-content-between">
            <ul class="header-top__info mb-2 mb-sm-0">
               <!-- <li><span class="align-middle"><i class="ti-mobile"></i></span>010 0000 0000</li>
          <li><span class="align-middle"><i class="ti-email"></i></span>manamoa12.net</li> -->
            </ul>
            <ul class="header-top__social">

					<c:if
						test="${not empty sessionScope.m_id and param.authority eq 'member' }">
						<li>${sessionScope.m_id }님</li>
						<li><a href="../member/logout.do">로그아웃</a></li>
						<li><a href="../member/myPage.do?authority=member">마이페이지</a></li>
					</c:if>
					<c:if
						test="${not empty sessionScope.m_id and param.authority eq 'company' }">
						<li>${sessionScope.m_id }님</li>
						<li><a href="../member/logout.do">로그아웃</a></li>
						<li><a href="../member/myPage.do?authority=company">마이페이지</a></li>
						<li><a href="javascript:Aaaa();">테마파크
								등록</a></li>

					</c:if>
				</ul>
         </div>
      </div>
   </section>
   <!--================ Header Top Area end =================-->

   <!--================ Header Menu Area start =================-->
   <header class="header_area">
   <div class="main_menu">
      <nav class="navbar navbar-expand-lg navbar-light "
         style="background-color: #5fb6df">

         <div class="container box_1620">
            <a class="navbar-brand logo_h" href="../index.do"><img
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
   <!--================Header Menu Area =================-->

   <!--================ Hero Banner start =================-->
   <section class="hero-banner hero-banner--sm">
      <div class="hero-banner__content text-center">
         <h4 style="color: white;">대한민국 1등 종합테마파크앱</h4>
         <h1 style="font-family: Youthanasia">Parkmoa</h1>
      </div>
   </section>
   <!--================ Hero Banner end =================-->
<form:form name="payFrm">
<div class="container" style="padding-top: 20px;">
<input type="hidden" name="authority" value="${authority }" />
   
   <table class="table table-border">
   <h4>구매자 정보</h4>
   <tr>
      <th>주문자</th>
      <td><input type="text" class="form-control" style="width: 200px;" name="m_id"
         value="${dto.m_id }"/></td>
   </tr>   
   <tr>
      <th>휴대폰</th>
      <td>  
      	<input type="text" class="form-control" style="width: 200px; display: inline;" name="m_mobile"
        	 value="${dto.m_mobile }" placeholder="01012341234" class="form-control"/>
     </td>
   </tr>   
   <tr>
      <th>이메일</th>
      <td>
         <input type="text" name="m_email" style="width: 200px; display: inline;" 
            value="${dto.m_email }" placeholder="Example@exam.com" class="form-control" />   
      </td>
   </tr>   
   </table>

   <c:forEach items="${map }" var="row" varStatus="loop">
   <h4>결제정보</h4>
   <table class="table table-bordered" border="1" style="width: 100%; text-align: center; vertical-align: middle;">
      <tr>
         <th style="width: 15%;">테마파크 명</th>
         <th>이용권 이름</th>
         <th style="width: 10%;">수량</th>
         <th style="width: 15%;">가격</th>
         <th style="width: 10%;">이용날짜</th>
      </tr>
         <tr>
            <td style="vertical-align: middle;">${row.value[0].tp_name }
            <input type="hidden" name="listSize" value="${loop.index }" /></td>
            <input type="hidden" name="tp_idx${loop.index }" value="${row.value[0].tp_idx }" /></td>
            <input type="hidden" name="tp_name${loop.index }" value="${row.value[0].tp_name }" /></td>
            <td style="vertical-align: middle;"><c:forEach items="${row.value }" var="list">
               ${list.t_name }<input type="hidden" name="t_name${loop.index }" value="${list.t_name }"/><br />
            </c:forEach>
            </td>
            <td style="vertical-align: middle;"><c:forEach items="${row.value }" var="list">
               ${list.r_cnt }<input type="hidden" name="r_cnt${loop.index }" value="${list.r_cnt }"/><br />
            </c:forEach>
            </td>
            <td style="vertical-align: middle;"><c:forEach items="${row.value }" var="list">
               <fmt:formatNumber value="${list.t_price }" pattern="#,###" />
                원
               <input type="hidden" name="t_price${loop.index }" value="${list.t_price }"/><br />
            </c:forEach>
            </td>
            <td style="vertical-align: middle;">${fn:substring(row.value[0].r_useregi,0,10) }
            <input type="hidden" value="${fn:substring(row.value[0].r_useregi,0,10) }" name="r_useregi${loop.index }" />
            </td>
         </tr>
   </table> 
   <br />

	<c:forEach items="${tp_parkregis[loop.index].tp_parkregi }" var="j">
		<h4>주차장 이용여부</h4> 
	<c:if test="${j eq 'no' }">
	<p>등록된 주차장이 없습니다.</p>
	<table class="table">
      <tr>
      <td colspan="2" >
         <input type="hidden" id="${loop.index }" name="p_num${loop.index }" />
      </td> 
      </tr> 
   </table>
	</c:if>
	<c:if test="${j eq 'yes' }">
	<table class="table">
      <tr>
      <td colspan="2" >
         <label><input type="radio" class="parkUse" name="${row.key }" value="y"/>&nbsp;이용</label>&nbsp;&nbsp;&nbsp;
         <label><input type="radio" class="parkUse" name="${row.key }" value="n"/>&nbsp;이용안함</label>&nbsp;&nbsp;&nbsp;&nbsp;
         <span id="p_num${loop.index }" style="font-size: 1.5em; color: blue;"></span>
         <input type="hidden" id="${loop.index }" name="p_num${loop.index }" />
      </td>
      </tr> 
      <tr id="area${row.key }" class="area" > 
         <td colspan="2">
         <!-- 테마파크별 주차장 레이아웃 -->
         <button type="button" class="btn btn-outline-primary" 
                        style="width: 45px; margin-top: 5px; padding: 0px;">&nbsp;</button>
          : 예약가능&nbsp;&nbsp;
         <button type="button" class="btn btn-danger" disabled="disabled" style="width: 45px; margin-top: 5px; padding: 0px;">&nbsp;</button>
           : 예약완료&nbsp;&nbsp;      
         <button type="button" class="btn btn-dark" 
                  style="width: 45px; margin-top: 5px; padding: 0px;" disabled="disabled" >X</button>
          : 통로
          <br /><br />            
         <c:set var="p_num" value="1" />
         <c:forEach items="${p_infoList[loop.index].p_content }" var="i" varStatus="cnt" >
            <c:set var="flag" value="0" />
            <c:forEach items="${paymentList }" var="paymentList">
               <!-- 예약된 자리 판별을 위한 flag 처리 -->
               <c:set var="selectDate" value="${fn:substring(row.value[0].r_useregi,0,10) }"/>               
               <c:set var="payDate" value="${fn:substring(paymentList.r_useregi,0,10) }"/>               
               <c:if test="${(row.value[0].tp_idx eq paymentList.tp_idx) 
                  and(paymentList.p_num eq p_num )  
                  and (selectDate eq payDate) }">
               <c:set var="flag" value="1" />
               </c:if>
            </c:forEach>
            <c:choose>
            <c:when test="${i eq 1 }">
               <c:choose>
                  <c:when test="${flag eq 1 }">
                     <button type="button" class="btn btn-danger" disabled="disabled" style="width: 45px; margin-top: 5px; padding: 0px;">${p_num }</button>
                  </c:when>
                  <c:otherwise>
                     <button type="button" class="btn btn-outline-primary" name="${loop.index }"
                        style="width: 45px; margin-top: 5px; padding: 0px;">${p_num }</button>
                  </c:otherwise>
               </c:choose>
               <c:set var="p_num" value="${p_num + 1 }" />
            </c:when>
            <c:otherwise>
               <button type="button" class="btn btn-dark" 
                  style="width: 45px; margin-top: 5px; padding: 0px;" disabled="disabled" >X</button>
            </c:otherwise>
            </c:choose>
           
            <c:if test="${(cnt.count mod p_infoList[loop.index].p_repeatNum) eq 0 }"><br /></c:if>
         </c:forEach>
         </td>
      </tr>
      
   </table>
	</c:if>
	</c:forEach>
   </c:forEach> 
   <h4>할인 및 적립</h4>
   	<fmt:parseNumber var="mileage" value="${totalPrice/100 }" integerOnly="true"/>
   <table class="table table-bordered" style="text-align: center;">
   <tr>
   <td style="width: 20%;">상품가격</td>
    <td style="width: 30%; text-align: right;" >
		<fmt:formatNumber pattern="#,###">
		${totalPrice }
		</fmt:formatNumber> 원
		<input type="hidden" id="totalPrice2" value="${totalPrice }"/>
   </td>
   	<td>보유 적립금</td>
   	<td style="text-align: right;">
   		<input type="hidden" id="max_Membership" class="form-control" style="text-align: right;" value="${dto.m_membership }" readonly="readonly"/>
   		<fmt:formatNumber pattern="#,###">
		${dto.m_membership }
		</fmt:formatNumber> 원
  	</td>
   </tr>
   <tr>
   	<td style="width: 20%;">적립예정금액</td>
   	<td style="text-align: right; width: 30%">
   		<input type="hidden" class="form-control" style="text-align: right;" name="mileage" value="${mileage }" readonly="readonly"/>
   		<fmt:formatNumber pattern="#,###">
		${totalPrice/100 }
		</fmt:formatNumber> 원
   	</td>
   	<td>사용 적립금</td>
   	<td>
   		<input type="number" id="use_Membership" class="form-control" style="text-align: right; width:64%; display: inline;" value="0"/>
	   	<button type="button" class="btn" id="useAllMembership" 
	   		style="float: right; color: white; background-color: #60B6DF;">
	   		모두사용
	   	</button>
   	</td>
   </tr>
   <tr>
   <td>사용후 잔액</td>     
   	<td style="text-align: right;">
   		<input type="hidden" id="after_Membership" class="form-control" name="after_Membership" value="${dto.m_membership }" readonly="readonly"/>
   		<span id="change">0</span>원
   	</td>
   	<td>
	   	할인가격
   	</td>
   <td style="text-align: right; color: green;">
   		- <span id="discount">0</span> 원
   </td>
   </tr>
   <tr>
      	<td colspan="4" style="text-align: right;">
   		결제예정금액  
   		<strong class="text__value" >
   		<span id="total_Price1">
   		<fmt:formatNumber pattern="#,###">
		${totalPrice }
   		</fmt:formatNumber>
  		</span> 원
   		<input type="hidden" name="total_Price" id="total_Price" value="${totalPrice }" />
   		</strong>
      	</td>
   </tr>
   
   </table>
   
   <h4>결제방법</h4>
   <table class="table table-border">
      <tr>
         <td><label><input type="radio" name="pay" value="카카오페이" />카카오페이</label> &nbsp; <label><input type="radio" name="pay" value="네이버페이"/>네이버페이</label> &nbsp; <label><input type="radio" name="pay" value="계좌이체"/>계좌이체</label></td>
      </tr>
   </table>
</div>
 <div class="order_summary" align="center">
    <input type="hidden" id="totalPrice" value="${totalPrice }" />    
   
</div>
</div>
<DIV align="center"><a onClick="goBack();">
   <button type="button" class="btn btn-success btn-lg" >돌아가기</button></a>&nbsp;&nbsp;&nbsp;
   <button type="button" class="btn btn-danger btn-lg" id="payAction" >결제하기</button>
   </DIV><IFRAME width="0" height="0" class="ab_test" 
      id="ab_iframe" src="about:blank" frameborder="0" vspace="0"></IFRAME>     
</DIV>
</form:form>

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
      .scrolltop:hover,
      .scrolltop:focus {
        color: #dc3545;
        transition: all 0.5s ease-in-out;
      }
    </STYLE>
   <a id="backToTop" class="scrolltop" href="#">
      <i class="fas fa-chevron-circle-up"></i>
    </a>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script>
      jQuery(document).ready(function () {
        $(window).scroll(function () {
          if ($(this).scrollTop() > 100) {
            $('#backToTop').fadeIn(500);
          } else {
            $('#backToTop').fadeOut('slow');
          }
        });
        $('#backToTop').click(function (e) {
          e.preventDefault();
          $('html, body').animate({scrollTop: 0}, 200);
        });
      });
    </script>
   

   <script src="../../vendors/jquery/jquery-3.2.1.min.js"></script>
   <script src="../../vendors/bootstrap/bootstrap.bundle.min.js"></script>
   <script src="../../vendors/owl-carousel/owl.carousel.min.js"></script>
   <script src="../../vendors/Magnific-Popup/jquery.magnific-popup.min.js"></script>
   <script src="../../js/jquery.ajaxchimp.min.js"></script>
   <script src="../../js/mail-script.js"></script>
   <script src="../../js/main.js"></script> 
</body>
</html>

