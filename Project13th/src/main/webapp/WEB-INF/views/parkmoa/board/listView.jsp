<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>테마파크 상세보기</title>
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
   background: url('../../img/star_empty.png') no-repeat;
   float: left;
   height: 28px;
   padding: 2px;
   width: 32px;
}

.ratings_vote {
   background: url('../../img/star_full.png') no-repeat;
}

.ratings_over {
   background: url('../../img/star_full.png') no-repeat;
}

.total_votes {
   background: #eaeaea;
   top: 58px;
   left: 0;
   padding: 5px;
   position: absolute;
}

.movie_choice {
   font: 10px verdana, sans-serif;
   margin: 0 auto 40px auto;
   width: 180px;
}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
   function Aaaa() {
      window.open('../member/themeRegist.do?authority=company','IDWin','width=300','height=100, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
   }
   
   //세자리마다 콤마찍기
   function numberWithCommas(n) {
       var parts=n.toString().split(".");
       return parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",") + (parts[1] ? "." + parts[1] : "");
   }
   
   var locked = 0;
   var starpoint = document.getElementById("starpoint");

   function show(b_rating) {
      if (locked)
         return;
      var i;
      var image;
      var el;
      var e = document.getElementById('startext');
      var stateMsg;

      for (i = 1; i <= b_rating; i++) {
         image = 'image' + i;
         el = document.getElementById(image);
         el.src = "../../resources/star/star1.png";
      }

      switch (b_rating) {
      case 1:
         stateMsg = "최악이요";
         break;
      case 2:
         stateMsg = "별로예요";
         break;
      case 3:
         stateMsg = "만족해요";
         break;
      case 4:
         stateMsg = "추천해요";
         break;
      case 5:
         stateMsg = "최고예요";
         break;
      default:
         stateMsg = "";
      }
      e.innerHTML = stateMsg;
   }

   function noshow(b_rating) {

      if (locked)
         return;
      var i;
      var image;
      var el;

      for (i = 1; i <= b_rating; i++) {
         image = 'image' + i;
         el = document.getElementById(image);
         el.src = '../../resources/star/star0.png';
      }
   }
   function lock(b_rating) {
      show(b_rating);
      locked = 1;
   }
   function mark(b_rating) {
      locked = 0;
      alert("별점" + b_rating + "점을 선택하셨습니다.!");

      for (var i = 1; i <= b_rating; i++) {
         image = 'image' + i;
         el = document.getElementById(image);
         el.src = "../../resources/star/star1.png";
      }

      lock(b_rating);
      document.cmtform.b_rating.value = b_rating;

      document.cmtform.count.value = 1;

   }

   window.onload = function() {

      getCommentList();

      $('#MoreBtn').click(function() {
         var tp_idx = $('#tp_idx').val();
         var postdata = {
            'tp_idx' : tp_idx
         };
         $.ajax({
            type : 'POST',
            url : "./ReviewAll.do",
            dataType : "html",
            data : postdata,
            contentType : "application/x-www-form-urlencoded; charset=UTF-8",
            beforeSend : function(xhr) {
               /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다.시큐리티 적용시 필수*/
               xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
            },
            success : function(data) {
               $("#commentmore-list").append(data);
               $("#MoreBtn").hide();
            },
            error : function(request, status, error) {
               alert("code:" + request.status+ "\n" + "message:"+ request.responseText+ "\n" + "error:" + error);
            }
         });
      });
   }

   function fn_comment(code) {
      var f = document.getElementById('commentForm');
      var e = document.getElementById('startext');
      var rating = document.getElementById('rating');
      var count = document.getElementById('count');

      if (!f.b_content.value.replace(/(^\s*)|(\s*$)/gi, "")) {
         alert("리뷰를 입력해주세요");
         f.b_content.focus();
         return;
      }
      if (count.value == 0) {
         alert("별점을 선택해주세요");
         return;
      }

      $.ajax({
         type : 'POST',
         url : "<c:url value='/parkmoa/board/writeReply.do'/>",
         data : $("#commentForm").serialize(),
         beforeSend : function(xhr) {
            /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다.시큐리티 적용시 필수*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         },
         success : function(data) {
            if (data == "success") {
               getCommentList();
               $("#comment").val("");
               e.innerHTML = "";
               $("#starpoint").val('0');
               $("#count").val('0');
               var i;
               var image;
               var el;
               for (i = 1; i <= 5; i++) {
                  image = 'image' + i;
                  el = document.getElementById(image);
                  el.src = '../../resources/star/star0.png';
               }
            }
         },
         error : function(request, status, error) {
            //alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
         }

      });
   }

   function getCommentList() {

      $.ajax({
         type : 'GET',
         url : "<c:url value='/parkmoa/board/commentList.do'/>",
         dataType : "json",
         data : $("#commentForm").serialize(),
         contentType : "application/x-www-form-urlencoded; charset=UTF-8",
         beforeSend : function(xhr) {
            /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다.시큐리티 적용시 필수*/
            xhr.setRequestHeader("${_csrf.headerName}","${_csrf.token}");
         },
         success : function(data) {

            var html = "";
            var cCnt = data.length;
            var pageSize = 7;

            if (data.length > 0) {
               for (i = 0; i < cCnt; i++) {
                  if (i == 7) {
                     break;
                  }
                  if (data[i].b_rating == 5) {
                     data[i].b_rating = "★★★★★";
                  }
                  if (data[i].b_rating == 4) {
                     data[i].b_rating = "★★★★";
                  }
                  if (data[i].b_rating == 3) {
                     data[i].b_rating = "★★★";
                  }
                  if (data[i].b_rating == 2) {
                     data[i].b_rating = "★★";
                  }
                  if (data[i].b_rating == 1) {
                     data[i].b_rating = "★";
                  }

                  html += "<div>";
                  html += "<div>";
                  html += "<table class='table'>";
                  html += "<h6><strong>" + data[i].m_id + "("
                        + data[i].b_regidate + ")("
                        + data[i].b_rating + ")</strong></h6>";

                  html += data[i].b_content
                        + "<tr><td></td></tr>";
                  html += "</table></div>";
                  html += "</div>";

               }

            } else {
               html += "<div>";
               html += "<div><table class='table'><h6><strong style='color:red;'>등록된 리뷰가 없습니다.</strong></h6>";
               html += "</table></div>";
               html += "</div>";
            }

            $("#cCnt1").html(cCnt);
            $("#cCnt2").html(cCnt);
            $("#commentList").html(html);

         },
         error : function(request, status, error) {

         }
      });
   }

   var cnt = 0;
   var ticketValidate = new Array();

   $(function() {
      $(window).scroll(function() {
         $('#scroll').animate({
            top : $(window).scrollTop() + "px"
         }, {
            queue : false,
            duration : 0
         });
      });

      $('#ticket').change(function() {

         if ($(this).val() == 0) {
            return;
         }
         //이벤트 발생시 배열과 value값 같은요소 있는지 검사
         for (var i = 0; i < ticketValidate.length; i++) {
            if ($(this).val() == ticketValidate[i]) {
               return;
            }
         }

         ticketValidate[cnt] = $(this).val();

         var ticket = "<tr id="+cnt+" style='text-align: center;'><td>"
               + $('#ticket option:selected').text();
         ticket += "</td><td style='text-align: center;'><input type='number' style='width: 50px;' class='ticket_cnt' min='1' name='price"
               + $(this).val() + "' value='1'/>";
         ticket += "&nbsp;&nbsp;<img src='../../resources/delete.png' style='width: 20px;' class='delete_btn' name='"+cnt+"'/>";
         ticket += "<input type='hidden' style='width: 50px;' id='fixed_price"
               + $(this).val()
               + "' value='0' /></td></tr>"

         $('#ticket_append').append(ticket);

         cnt++;

         getTotalPrice(1, "price" + $(this).val());

      });

      //날짜 변경시 이벤트
      $(document).on("change", "#date", function() {
         var date = document.getElementById("date");

         var d = new Date(date.value);
         var today = new Date();

         if (d.getFullYear() < today.getFullYear()) {
            alert("이용날짜는 오늘부터 선택가능");
            date.value = "";
            return false;
         }

         if (d.getMonth() < today.getMonth()) {
            alert("이용날짜는 오늘부터 선택가능");
            date.value = "";
            return false;
         }

         if (d.getDate() != today.getDate()) {

            if (d < today) {
               alert("이용날짜는 오늘부터 선택가능");
               date.value = "";
               return false;
            } else {
               return true;
            }
         } else {
            return true;
         }

      });

      //선택한 이용권 삭제
      $(document).on("click", ".delete_btn", function() {
         var deletenum = $(this).attr('name');
         $('#' + deletenum).remove();
         ticketValidate[deletenum] = -1;

         getTotalPrice(0, deletenum);

      });

      //선택한 이용권 수량변경
      $(document).on("change", ".ticket_cnt", function() {
         var ticket_cnt = $(this).val();
         if (ticket_cnt < 0) {
            $('#totalPrice').text("매수는 0이상 지정하셈.");
            return;
         }
         var price_id = $(this).attr('name');

         getTotalPrice(ticket_cnt, price_id);

      });
   });

   function getTotalPrice(x, y) {

      var ticket_cnt = x;
      var price_id = y;

      var fixed_price = $('#' + price_id).val() * ticket_cnt;

      $('#fixed_' + price_id).val(fixed_price);

      var priceArray = new Array();
      var arrayIndex = 0;

      for (var i = 0; i < ticketValidate.length; i++) {
         if (ticketValidate[i] != -1) {
            priceArray[arrayIndex] = $('#fixed_price' + ticketValidate[i])
                  .val();
            arrayIndex++;
         }
      }

      if (priceArray.length == 0) {
         $('#totalPrice').text("");
         return;
      }
      $.ajax({
         url : "../pay/total_price.do",
         type : "post",
         contentType : "application/x-www-form-urlencoded;charset=UTF-8",
         data : {
            'array' : priceArray
         },
         traditional : true,
         dataType : "JSON",
         beforeSend : function(xhr) {
            /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         },
         success : function(r) {
            $('#membership').text(" : " + numberWithCommas(r.total_price/100) + "원")
            $('#totalPrice').text("총 결제금액 : " + numberWithCommas(r.total_price) + "원");
            $('#total_Price').val(r.total_price);
         },
         error : function(e) {
            alert('오류발생' + e.status + ":" + e.statusText);
         }
      });
   }

   //장바구니 담기
   function cartAction() {

      var f = document.ticket_submit;
      var input_date = document.getElementById("date");
      var select_ticket = document.getElementById("ticket");
      var sessionid = document.getElementById("sessionid");

      if (sessionid.value == "") {
         alert("로그인 후 이용해주세요");
         f.action = "../member/login.do";
         f.submit();
         return false;
      }
      if (select_ticket.options[select_ticket.selectedIndex].value == 0) {
         alert("이용권을 선택해주세요");
         return false;
      }

      if (input_date.value == "") {
         alert("이용날짜를 선택해주세요.");
         return false;
      } else {
         f.action = "../pay/cartAction.do";
         f.method = "post";

         f.submit();
      }
   }

   //바로 결제하기
   function paymentDirect() {

      var f = document.ticket_submit;
      var input_date = document.getElementById("date");
      var select_ticket = document.getElementById("ticket");
      var sessionid = document.getElementById("sessionid");

      if (sessionid.value == "") {
         alert("로그인 후 이용해주세요");
         f.action = "../member/login.do";
         f.submit();
         return false;
      }
      if (select_ticket.options[select_ticket.selectedIndex].value == 0) {
         alert("이용권을 선택해주세요");
         return false;
      }
      if (input_date.value == "") {
         alert("이용날짜를 선택해주세요.");
         return false;
      }else {
         f.action = "../pay/paymentDirect.do";
         f.method = "post";

         f.submit();
      }
   }
</script>
</head>
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
                  <!-- <li><span class="align-middle"><i class="ti-mobile"></i></span>010 0000 0000</li>
          <li><span class="align-middle"><i class="ti-email"></i></span>manamoa12.net</li> -->
               </ul>
               <ul class="header-top__social">

                  <li><a href="../member/login.do">로그인</a></li>
                  <li><a href="../member/policy.do">회원가입</a></li>
               </ul>
            </div>
         </div>
      </section>
   </c:if>
   <header class="header_area">
      <div class="main_menu">
         <nav class="navbar navbar-expand-lg navbar-light "
            style="background-color: #5fb6df">

            <div class="container box_1620">
               <a class="navbar-brand logo_h"
                  href="../index.do?authority=${authority }"> <img
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

   <!--================ Hero sm Banner start =================-->

   <!--================ Hero sm Banner end =================-->


   <!--================Blog Area =================-->
   <section class="blog_area single-post-area section-margin">
      <div class="container">
         <div class="row">
            <div class="col-lg-8 posts-list">
               <div class="single-post row">
                  <div class="col-lg-12">
                     <div class="feature-img">
                        <img class="img-fluid" src="../../resources/upload/${dto.tp_attach }" style="width: 100%; height: 400px;" alt="">
                     </div>
                  </div>
                  <div class="col-lg-9 col-md-9 blog_details">
                     <h2 style="font-size: 32px;">${dto.tp_name }</h2>
                     <span style="color: #a38a00; font-size: 18px;">리뷰&nbsp;</span><span
                        style="color: #a38a00; font-size: 18px;" id="cCnt1"></span><span
                        style="color: #a38a00; font-size: 18px;">개</span> <br /> <span
                        style="color: rgba(0, 0, 0, 0.56)">${dto.tp_addr1 }</span>

                  </div>
                  <div class="col-lg-12">
                     <div class="quotes" style="border: 1px inset black;">
                        <h3 style="text-align: left;">테마파크 소개</h3>
                        <span style="font-size: 16px; color: black;">※
                           ${dto.tp_content }</span>
                     </div>
                     <div class="row"></div>
                  </div>
               </div>
               <div class="navigation-area">
                  <div class="row">
                     <div
                        class="col-lg-6 col-md-6 col-12 nav-left flex-row d-flex justify-content-start align-items-center">
                     </div>
                  </div>
               </div>

               <!--별점리뷰게시판영역 s  -->

               <form:form name="cmtform" method="post" id="commentForm">
                  <div class="comments-area">
                     <h3>별점&리뷰</h3>
                     <div id="rating" align="center">
                        <span> <img style="width: 30px; height: 30px;"
                           id="image1" onmouseover=show(1) onclick=mark(1)
                           onmouseout=noshow(1) src="../../resources/star/star0.png" /> <img
                           style="width: 30px; height: 30px;" id="image2"
                           onmouseover=show(2) onclick=mark(2) onmouseout=noshow(2)
                           src="../../resources/star/star0.png" /> <img
                           style="width: 30px; height: 30px;" id="image3"
                           onmouseover=show(3) onclick=mark(3) onmouseout=noshow(3)
                           src="../../resources/star/star0.png" /> <img
                           style="width: 30px; height: 30px;" id="image4"
                           onmouseover=show(4) onclick=mark(4) onmouseout=noshow(4)
                           src="../../resources/star/star0.png" /> <img
                           style="width: 30px; height: 30px;" id="image5"
                           onmouseover=show(5) onclick=mark(5) onmouseout=noshow(5)
                           src="../../resources/star/star0.png" />
                        </span> <br /> <strong><span id="startext" name="startext"
                           style="color: blue;"></span></strong> <input type="hidden"
                           name="b_rating" id="starpoint" value="0" /> <input
                           type="hidden" name="count" value="0" id="count" />
                     </div>

                     <input type="hidden" name="b_title" value="replystar" /> <input
                        type="hidden" name="tp_category" value="${param.tp_category}" />
                     <input type="hidden" name="tp_idx" value="${param.tp_idx }"
                        id="tp_idx" />
                     <div class="comment-list left-padding" style="">
                        <div class="single-comment justify-content-between d-flex">
                           <div class="user justify-content-between d-flex">
                              <div class="thumb">
                                 <h4 style="text-align: center;">${sessionScope.m_id }</h4>
                                 <input type="hidden" name="m_id"
                                    value="${sessionScope.m_id }" />
                              </div>

                              <c:if test="${empty m_id }">
                                 <div class="desc">
                                    <div class="form-group" style="width: 400px;">
                                       <textarea class="form-control" rows="5" id="comment"
                                          name="b_content" style="width: 550px;" disabled="disabled"
                                          placeholder="로그인 후 이용해주세요."></textarea>
                                    </div>
                                 </div>
                              </c:if>

                              <c:if test="${not empty m_id }">
                                 <div class="desc">
                                    <div class="form-group" style="width: 400px;">
                                       <textarea class="form-control" rows="5" id="comment"
                                          name="b_content" style="width: 125%;"
                                          placeholder="리뷰와 별점을 입력해주세요."></textarea>
                                    </div>
                                    <div class="reply-btn"
                                       style="text-align: right; width: 500px;">

                                       <button type="button"
                                          onClick="fn_comment('${result.code }')"
                                          class="btn btn-success" id="reviewBtn">등록</button>
                                    </div>
                                 </div>
                              </c:if>
                           </div>
                        </div>
                     </div>
               </form:form>
               <c:if test="${empty sessionScope.m_id }">
                  <span><strong style="color: red;">리뷰는 로그인 후 작성하실 수
                        있습니다.</strong></span>
               </c:if>
               <div>
                  <span><strong style="color: blue;">Review</strong>(<span
                     id="cCnt2"></span>)</span>
               </div>
               <br /> <br />
               <form:form id="commentListForm" name="commentListForm"
                  method="post">
                  <div class="comment-list left-padding" id="commentmore-list">
                     <div id="commentList"></div>
                     <div class="single-comment justify-content-between d-flex"></div>
                  </div>
                  <div style="width: 99%;">
                     <button type="button" id="MoreBtn" style="width: 100%"
                        class="btn btn-primary btn-block">리뷰 펼쳐보기</button>
                  </div>
               </form:form>
               <!-- 댓글달리는곳 e -->
            </div>
            <!--별점리뷰게시판영역 e -->
         </div>
         <div class="col-lg-4">
            <div class="blog_right_sidebar" id="scroll" style="position: relative;">
               <form:form name="ticket_submit">
                  <aside class="single_sidebar_widget author_widget">
                     <table class="table table-borderd" style="text-align: center; vertical-align: middle;">
                        <tr>
                           <td style="width: 35%;"><strong>테마파크</strong> 
                              <input type="hidden" name="tp_name" value="${dto.tp_name }" />
                              <input type="hidden" name="tp_idx" value="${dto.tp_idx }" />
                              <input type="hidden" name="m_id" value="${m_id }" />
                              <input type="hidden" name="tp_idxconfirm" value="${dto.tp_idx }" />
                           </td>
                           <td>${dto.tp_name }</td>
                        </tr>
                        <tr>
                           
                           <td>
                              <strong>주차예매</strong>
                              <input type="hidden" name="authority" value="${authority }" />
                              <input type="hidden" name="tp_parkregi" value="${dto.tp_parkregi }" />
                           </td>
                           <td>
                              <c:if test="${dto.tp_parkregi eq 'yes'}">
                                 <span>가능</span>
                              </c:if> <c:if test="${dto.tp_parkregi eq 'no'}">
                                 <span>불가능</span>
                              </c:if>
                           </td>
                        </tr>
                        <tr>
                           <td>
                           <strong>이용날짜</strong>
                           </td>
                           <td>
                              <input type="date" name="confirmday" id="date" class="form-control" style="display: inline; width: 170px;"/>
                           </td>
                        </tr>
                        <tr>
                           <td colspan="2">
                              <select   class="form-control" style="width: 100%;" id="ticket">
                                 <option value="0">-이용권을 선택하세요-</option>
                                 <!-- 티켓리스트반복 -->
                                 <c:forEach items="${lists }" var="row"> 
                                    <option value="${row.t_idx }">${row.t_name } (<fmt:formatNumber value="${row.t_price }" pattern="#,###"/>원)</option>
                                 </c:forEach>
                              </select>
                           </td>
                        </tr>
                     </table>
                  </aside>
                  <table class="table" id="ticket_append">
                     <c:forEach items="${lists }" var="row">
                        <input type="hidden" value="${row.t_price }"
                           id="price${row.t_idx }" />
                     </c:forEach>
                     <input type="hidden" id="total_Price" name="totalPrice" />
                     <tr>
                        <td style="width: 75%; border-top: 1px solid white; text-align: center;"><strong>이용권</strong></td>
                        <td style="width: 25%; border-top: 1px solid white; text-align: center;"><strong>매수</strong></td>

                     </tr>
                  </table>
                  <aside class="single_sidebar_widget author_widget">
                     
                     <p>
                     <strong>마일리지</strong>(구매금액1%적립)
                     <span id="membership" style="text-align: right;"></span>                     
                     </p>
                     <!-- 합계총액 표시 -->
                     
                     <p>
                        <span id="totalPrice" style="font-size: 1.5em; color: red; text-align: right;" /></span>
                     </p>

                     <div align="center">
                        <input type="hidden" id="sessionid" value="${m_id }" />
                        <button class="btn btn-light"
                           style="width: 140px; height: 50px; border: 1px solid;"
                           type="button" onclick="cartAction();">담아두기</button>
                        <button class="btn btn-primary"
                           style="width: 140px; height: 50px;" type="button"
                           onclick="paymentDirect();">결제하기</button>
                     </div>
                     <div class="br"></div>
                  </aside>
               </form:form>
               </aside>
            </div>
         </div>
      </div>
      </div>
   </section>
   <!--================Blog Area =================-->



   <!-- ================ start footer Area ================= -->

   <!-- ================ End footer Area ================= -->

   <script src="../../vendors/jquery/jquery-3.2.1.min.js"></script>
   <script src="../../vendors/bootstrap/bootstrap.bundle.min.js"></script>
   <script src="../../vendors/owl-carousel/owl.carousel.min.js"></script>
   <script src="../../vendors/Magnific-Popup/jquery.magnific-popup.min.js"></script>
   <script src="../../js/jquery.ajaxchimp.min.js"></script>
   <script src="../../js/mail-script.js"></script>
   <script src="../../js/main.js"></script>
</body>
</html>