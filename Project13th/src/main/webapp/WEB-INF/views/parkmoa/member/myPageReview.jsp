<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<link rel="stylesheet"
   href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
   integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ"
   crossorigin="anonymous">
</head>
<script>
function Aaaa() {

   window   
         .open(
               '../member/themeRegist.do?authority=company',
               'IDWin',
               'width=300',
               'height=100, toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=no, resizable=no');
}
</script>
<body>
   <!--================ Header Top Area Start =================-->
   <section class="header-top d-none d-sm-block"
      style="background-color: #5fb6df">
      <div class="container">
         <div class="d-sm-flex justify-content-between">
            <ul class="header-top__info mb-2 mb-sm-0">
               <!-- <li><span class="align-middle"><i class="ti-mobile"></i></span>010 0000 0000</li>
          <li><span class="align-middle"><i class="ti-email"></i></span>manamoa12.net</li> -->
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
                  <li><a href="javascript:Aaaa();">테마파크
                        등록</a></li>

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
   <script>
$(function(){
   $('#MoreBtn').click(function(){ 
      var m_id = $('#user_id').val();
      
      
      var postdata = {'user_id' : m_id};
      $.ajax({
         type : 'POST',
         url : "./myReviewAll.do",  
         dataType : "html", 
         data : postdata,
         contentType : "application/x-www-form-urlencoded; charset=UTF-8",
         beforeSend : function(xhr) {
            /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다.시큐리티 적용시 필수*/
            xhr.setRequestHeader("${_csrf.headerName}",
                  "${_csrf.token}");
         },
         success : function(data){
            $("#MoreReview").append(data);
            
            $("#MoreBtn").hide();
             
         },
         error : function(request, status, error) {
            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
         }
         
      });
      
   });
   
});
</script>
   <script>
function bEdit(b_idx) {    
   $('input[type=text][name=row_idx]').val(b_idx);
   var postData = {
      'b_idx' : b_idx    
   }; 
   
   $.ajax({ 
      url : './reviewEdit.do',
      type : 'POST',
      data : postData,
      contentType : "application/x-www-form-urlencoded; charset=UTF-8",
      dataType : "json",
        beforeSend : function(xhr){
              /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
               xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        },
        success : function(data){
        
               $('#myModal').modal('show');      
               $('#modalEditTxt').html(data.b_content);
               $('#modalEditId').val(data.m_id);
               $('#modalEditStar').val(data.b_rating);
               $('#modalMid').val(data.m_id);
               $('#modalbidx').val(data.b_idx);  
           
        }
   });
}
</script>
   <div class="container">
      <UL class="dex4">
         <FIELDSET>
            <SECTION class="sect1 step04">
               <DIV class="row" style="text-align: right;">
                  <div class="col-sm-3" style="background-color: #5fb6df;"
                     align="center">
                     <button type="button" class="btn"
                        onclick="location.href='./myPage.do?authority=${authority}';"
                        style="color: white;">회원정보수정</button>
                  </div>
                  <div class="col-sm-3" style="background-color: #5fb6df;"
                     align="center">
                     <button type="button" class="btn"
                        onclick="location.href='./myPageReview.do?authority=${authority}';"
                        style="color: white;">리뷰보기</button>
                  </div>
                  <div class="col-sm-3" style="background-color: #5fb6df;"
                     align="center">
                     <button type="button" class="btn"
                        onclick="location.href='../pay/cart.do?authority=${authority}';" style="color: white;">담은목록보기</button>
                  </div>
                  <div class="col-sm-3" style="background-color: #5fb6df;"
                     align="center">
                     <button type="button" class="btn"
                        onclick="location.href='../pay/paymentHistory.do?authority=${authority}';"
                        style="color: white;">구매내역확인</button>
                  </div>

               </DIV>
               <DIV class="table_area table_area2">
                  <form:form id="mypage" action="../index.do" autocomplete="off"
                     method="post">
                     <input id="user_id" type="hidden" name="m_id"
                        value="${sessionScope.m_id }" />
                     <input type="hidden" name="authority" value="${param.authority }" />
                     <table width="90%" class="table table-bordered"
                        id="reviewContents">
                        <tr>

                           <th width="15%"
                              style="background: #5fb6df; text-align: center; color: white;">아이디</th>
                           <th width="*%"
                              style="background: #5fb6df; text-align: center; color: white;">내용</th>
                           <th width="23%"
                              style="background: #5fb6df; text-align: center; color: white;">별점</th>
                           <th width="15%"
                              style="background: #5fb6df; text-align: center; color: white;">작성일</th>
                           <th width="18%"
                              style="background: #5fb6df; text-align: center; color: white;">처리</th>
                        </tr>

                        <c:choose>
                           <c:when test="${empty lists }">
                              <tr>
                                 <td colspan="5" class="text-center">등록된 리뷰가 없습니다</td>
                              </tr>
                           </c:when>
                           <c:otherwise>
                              <c:forEach items="${lists }" var="row" varStatus="loop">

                                 <tr> 
                                    <td class="text-center">${row.m_id }</td>
                                    <td class="text-left"><a href="../board/listView.do?tp_idx=${row.b_bgroup }&authority=${authority}">${row.b_content }</a></td>
                                    <td class="text-center"><c:if
                                          test="${empty row.b_rating or row.b_rating eq '0'}">
                                          <img style="width: 30px; height: 30px;" id="image1"
                                             src="../../resources/star/star0.png" />
                                          <img style="width: 30px; height: 30px;" id="image2"
                                             src="../../resources/star/star0.png" />
                                          <img style="width: 30px; height: 30px;" id="image3"
                                             src="../../resources/star/star0.png" />
                                          <img style="width: 30px; height: 30px;" id="image4"
                                             src="../../resources/star/star0.png" />
                                          <img style="width: 30px; height: 30px;" id="image5"
                                             src="../../resources/star/star0.png" />
                                       </c:if> <c:if test="${row.b_rating eq '1'}">
                                          <img style="width: 30px; height: 30px;" id="image1"
                                             src="../../resources/star/star1.png" />
                                          <img style="width: 30px; height: 30px;" id="image2"
                                             src="../../resources/star/star0.png" />
                                          <img style="width: 30px; height: 30px;" id="image3"
                                             src="../../resources/star/star0.png" />
                                          <img style="width: 30px; height: 30px;" id="image4"
                                             src="../../resources/star/star0.png" />
                                          <img style="width: 30px; height: 30px;" id="image5"
                                             src="../../resources/star/star0.png" />
                                       </c:if> <c:if test="${row.b_rating eq '2'}">
                                          <img style="width: 30px; height: 30px;" id="image1"
                                             src="../../resources/star/star1.png" />
                                          <img style="width: 30px; height: 30px;" id="image2"
                                             src="../../resources/star/star1.png" />
                                          <img style="width: 30px; height: 30px;" id="image3"
                                             src="../../resources/star/star0.png" />
                                          <img style="width: 30px; height: 30px;" id="image4"
                                             src="../../resources/star/star0.png" />
                                          <img style="width: 30px; height: 30px;" id="image5"
                                             src="../../resources/star/star0.png" />
                                       </c:if> <c:if test="${row.b_rating eq '3'}">
                                          <img style="width: 30px; height: 30px;" id="image1"
                                             src="../../resources/star/star1.png" />
                                          <img style="width: 30px; height: 30px;" id="image2"
                                             src="../../resources/star/star1.png" />
                                          <img style="width: 30px; height: 30px;" id="image3"
                                             src="../../resources/star/star1.png" />
                                          <img style="width: 30px; height: 30px;" id="image4"
                                             src="../../resources/star/star0.png" />
                                          <img style="width: 30px; height: 30px;" id="image5"
                                             src="../../resources/star/star0.png" />
                                       </c:if> <c:if test="${row.b_rating eq '4'}">
                                          <img style="width: 30px; height: 30px;" id="image1"
                                             src="../../resources/star/star1.png" />
                                          <img style="width: 30px; height: 30px;" id="image2"
                                             src="../../resources/star/star1.png" />
                                          <img style="width: 30px; height: 30px;" id="image3"
                                             src="../../resources/star/star1.png" />
                                          <img style="width: 30px; height: 30px;" id="image4"
                                             src="../../resources/star/star1.png" />
                                          <img style="width: 30px; height: 30px;" id="image5"
                                             src="../../resources/star/star0.png" />
                                       </c:if> <c:if test="${row.b_rating eq '5'}">
                                          <img style="width: 30px; height: 30px;" id="image1"
                                             src="../../resources/star/star1.png" />
                                          <img style="width: 30px; height: 30px;" id="image2"
                                             src="../../resources/star/star1.png" />
                                          <img style="width: 30px; height: 30px;" id="image3"
                                             src="../../resources/star/star1.png" />
                                          <img style="width: 30px; height: 30px;" id="image4"
                                             src="../../resources/star/star1.png" />
                                          <img style="width: 30px; height: 30px;" id="image5"
                                             src="../../resources/star/star1.png" />
                                       </c:if></td>
                                    <td class="text-center">${row.b_regidate }</td>
                                    <td class="text-center">
                                       <button type="button" class="btn btn-danger"
                                          data-toggle="modal" data-target="#myModal"
                                          onclick="bEdit(${row.b_idx });">수정</button>
                                       <button type="button" class="btn btn-danger"
                                          onclick="location.href = './reviewDelete.do?m_id=${sessionScope.m_id }&b_idx=${row.b_idx}&authority=${param.authority}' ">삭제</button>
                                    </td>
                                 </tr>
                              </c:forEach>
                           </c:otherwise>
                        </c:choose>
                        <input type="hidden" name="row_idx" />
                     </table>
                     <table width="100%" style="border: none;">
                        <tr>
                           <td align="center" width="100%">
                              <ul class="pagination" style="justify-content: center;">
                                 ${pagingImg }
                              </ul>
                           </td>
                        </tr>
                     </table>
                     <div align="center">
                        <td>
                           <button type="submit" class="btn btn-danger">메인으로 돌아가기</button>

                        </td>
                     </div>
            </SECTION>
         </FIELDSET>
      </UL>
      </form:form>
   </DIV>
   <!--리뷰수정 모달창-->
   <form:form name="editfrm" action="./reviewEditAction.do" method="post">
      <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
         <div class="modal-dialog modal-notify modal-info" role="document">
            <!--Content-->
            <div class="modal-content text-center"
               style="width: 555px; height: 555px;">
               <!--Header-->
               <div class="modal-header d-flex justify-content-center"
                  style="background: #5FB6DF;">
                  <p class="heading" style="font-size: 30px; color: white">리뷰수정하기</p>
               </div>
               <!--Body-->
               <input type="hidden" name="m_id" id="modalMid" /> <input
                  type="hidden" name="b_idx" id="modalbidx" />
               <div class="modal-body">
                  <table width="90%" class="table table-bordered">
                     <tr>
                        <th style="padding-top: 80px;">리뷰내용</th>
                        <td><textarea id="modalEditTxt" style="width: 100%"
                              rows="7" name="b_content"></textarea></td>
                     </tr>
                     <tr>
                        <th style="height: 40px;">별점선택</th>
                        <td>
                           <div>
                              <select name="b_rating" id="modalEditStar">
                                 <option value="0">0점</option>
                                 <option value="1">1점</option>
                                 <option value="2">2점</option>
                                 <option value="3">3점</option>
                                 <option value="4">4점</option>
                                 <option value="5">5점</option>
                              </select>
                           </div>
                        </td>
                     </tr>

                     <!--Footer-->
                  </table>
                  <div class="modal-footer flex-center"
                     style="text-align: center; margin-top: 30px;">
                     <button type="submit" class="btn-danger"
                        style="width: 130px; height: 50px; align: center;">
                        수정하기</a>
                        <button type="button" class="btn-danger"
                           style="width: 130px; height: 50px; align: center;"
                           data-dismiss="modal">
                           창닫기</a>
                  </div>
               </div>

            </div>
            <!--/.Content-->
         </div>
      </div>
   </form:form>
</body>
</html>