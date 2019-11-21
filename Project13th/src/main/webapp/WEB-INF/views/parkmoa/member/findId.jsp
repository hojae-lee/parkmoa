<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE HTML>
<!-- saved from url=(0047)https://www.goodchoice.kr/user/passwdResetStart -->
<HTML lang="ko">
<HEAD>
<META content="IE=11.0000" http-equiv="X-UA-Compatible">

<META charset="UTF-8">
<META name="viewport"
   content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">

<link rel="stylesheet" href="../../css/login_style.css">
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script> -->

<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<style>

/* white 버튼 */
.white {
   color: #606060;
   border: solid 1px #b7b7b7;
   background: #fff;
   background: -webkit-gradient(linear, left top, left bottom, from(#fff),
      to(#ededed));
   background: -moz-linear-gradient(top, #fff, #ededed);
   filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff',
      endColorstr='#ededed');
}

.white:hover {
   background: #ededed;
   background: -webkit-gradient(linear, left top, left bottom, from(#fff),
      to(#dcdcdc));
   background: -moz-linear-gradient(top, #fff, #dcdcdc);
   filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff',
      endColorstr='#dcdcdc');
}

.white:active {
   color: #999;
   background: -webkit-gradient(linear, left top, left bottom, from(#ededed),
      to(#fff));
   background: -moz-linear-gradient(top, #ededed, #fff);
   filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed',
      endColorstr='#ffffff');
}

.button {
   display: inline-block;
   zoom: 1; /* zoom and *display = ie7 hack for display:inline-block */
   *display: inline;
   vertical-align: baseline;
   margin: 0 2px;
   outline: none;
   cursor: pointer;
   text-align: center;
   text-decoration: none;
   font: 14px/100% Arial, Helvetica, sans-serif;
   padding: .5em 2em .55em;
   text-shadow: 0 1px 1px rgba(0, 0, 0, .3);
   -webkit-border-radius: .5em;
   -moz-border-radius: .5em;
   border-radius: .5em;
   -webkit-box-shadow: 0 1px 2px rgba(0, 0, 0, .2);
   -moz-box-shadow: 0 1px 2px rgba(0, 0, 0, .2);
   box-shadow: 0 1px 2px rgba(0, 0, 0, .2);
}

.button:hover {
   text-decoration: none;
}

.button:active {
   position: relative;
   top: 1px;
}

.bigrounded {
   -webkit-border-radius: 2em;
   -moz-border-radius: 2em;
   border-radius: 2em;
}

.medium {
   font-size: 12px;
   padding: .4em 1.5em .42em;
}

.small {
   font-size: 11px;
   padding: .2em 1em .275em;
}

.btn-danger{
   height: 40px;
   width : 60px;
}
</style>

<!-- 로그인 pop_layer_w('pop_login') -->
<script>
   function search_check(num) {
      if (num == '1') {
         document.getElementById("searchP").style.display = "none";
         document.getElementById("searchI").style.display = "";
      } else {
         document.getElementById("searchI").style.display = "none";
         document.getElementById("searchP").style.display = "";
      }
   }
</script>
<!-- 아이디 찾기 유효성 체크 -->
<script>
   function MemberIdFind() {

      var fn = document.findId;

      if (fn.m_name.value.length < 1) {
         alert("이름을 입력해주세요");
         fn.m_name.focus();
         return false;
      }
      if (fn.m_mobile.value.length < 1) {
         alert("전화번호 입력해주세요");
         fn.m_mobile.focus();
         return false;
      }

   }
</script>
<!-- 비번찾기 유효성 체크 -->
<script>
   function MemberPassFind() {
      var fn = document.pwFind;

      if (fn.m_id.value.length < 1) {
         alert("아이디를 입력해주세요");
         fn.m_id.focus();
         return false;
      }
      if (fn.m_email.value.length < 1) {
         alert("이메일을 입력해주세요");
         fn.m_email.focus();
         return false;
      }

   }
</script>

<script>
   $(function() {
      $('#findId')
            .click(
                  function() {

                     if (MemberIdFind() == false) {
                        return false;
                     }

                     var m_name = $('#m_name').val();
                     var m_mobile = $('#m_mobile').val();
                     var postData = {
                        'm_name' : m_name,
                        'm_mobile' : m_mobile
                     };

                     $.ajax({
                              url : './findIdAction.do',
                              type : 'POST',
                              data : postData,
                              contentType : "application/x-www-form-urlencoded; charset=UTF-8",
                              dataType : "json",
                              beforeSend : function(xhr){
                                    /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다.시큐리티 적용시 필수*/
                                     xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                                 },
                              success : function(data) {

                                 console.log(data);
                                 $('#myModal').modal('show');
                                 if (data.result == '1') {
                                    $('#modalcontent').html(
                                          data.m_id);
                                 }
                                 else if (data.result == '0') {
                                    $('#modalcontent').html(
                                          data.m_id);
                                 }
                              }

                           });
                  });
   });
</script>

<script>
   $(function() {
      $('#pwFind')
            .click(
                  function() {

                     if (MemberPassFind() == false) {
                        return false;
                     }
                     var m_id = $('#m_id').val();
                     var m_email = $('#m_email').val();
                     var postData = {
                        'm_id' : m_id,
                        'm_email' : m_email
                     };

                     $.ajax({
                              url : './findPwAction.do',
                              type : 'POST',
                              data : postData,
                              contentType : "application/x-www-form-urlencoded; charset=UTF-8",
                              dataType : "json",
                              beforeSend : function(xhr){
                                    /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                                     xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                                 },

                              success : function(data) {

                                 console.log(data);

                                 $('#myModalPw').modal('show');
                                 if (data.result == '1') {
                                    $('#modalcontent1').html(
                                          data.msg);
                                 }
                                 if (data.result == '0') {
                                    $('#modalcontent1').html(
                                          data.msg);
                                 }
                              }

                           });
                  });
   });
</script>
<body>

      <DIV class="layer_fix layer_unfix pop_login pop_mem_reserve">
         <SECTION>
            <DIV class="fix_title">
               <div class="fix_title">
                  <a href="../index.do"><img src="../../img/parkmoaLogo.png"
                     alt="안되나요" /></a>
               </div>
               <!-- <H1 class="page_head">
            <h1 class="page_head">
               <img src="./images/parkmoa.png" alt="" />
            </H1> -->
            </DIV>
            <STRONG class="sub_title">아이디 찾기</STRONG>
            <P class="txt_top">
               성함과 핸드폰번호를 입력해주세요<BR>
               <!-- 비밀번호 재설정 할 수 있는 인증번호를 전송해드립니다. -->
            </P>
            <div>
               <div>
                  <input class="button white bigrounded" type="button"
                     value="아이디 찾기" onclick="search_check(1)" checked="checked"
                     style="width: 45%" />&nbsp;&nbsp; <input
                     class="button white bigrounded" type="button" value="비밀번호 찾기"
                     style="width: 45%" onclick="search_check(2)" />
               </div>
            </div>
            <DIV id="searchI" class="pop_login_errors">
               <UL></UL>
            </DIV>
            <form:form name="findId" onsubmit="return MemberIdFind()">
               <DIV class="inp_type_1 form-errors">

                  <INPUT name="m_name" placeholder="이름" id="m_name" />
               </DIV>
               <DIV class="inp_type_1 form-errors">

                  <INPUT name="m_mobile" placeholder="휴대폰번호" id="m_mobile" />
               </DIV>
               <BUTTON type="button" class="btn_link gra_left_right_red"
                  id="findId" data-toggle="modal" data-target="#myModal">
                  <SPAN>아이디 찾기</SPAN>
               </BUTTON>
            </form:form>
            <BUTTON class="btn_link" style="background: #F7323F"
               onclick="location.href='./login.do'">
               <SPAN>취소</SPAN>
            </BUTTON>
         </SECTION>
         <div id="searchP" style="display: none;">
            <DIV class="layer_fix layer_unfix pop_login pop_mem_reserve">
               <SECTION>
                  <DIV class="fix_title">
                     <div class="fix_title">
                        <a href="index.do"><img src="../../img/parkmoaLogo.png"
                           alt="안되나요" /></a>
                     </div>
                     <!-- <H1 class="page_head">
                     <img src="./images/parkmoaLogo.png" alt="" />
                  </H1> -->
                  </DIV>
                  <STRONG class="sub_title">비밀번호 찾기</STRONG>
                  <P class="txt_top">
                     등록된 아이디 및 이메일을 입력해주세요<BR> 등록된 이메일로 임시 비밀번호를 전송해드립니다.
                  </P>
                  <div>
                     <div>
                        <input class="button white bigrounded" type="button"
                           value="아이디 찾기" onclick="search_check(1)" checked="checked"
                           style="width: 45%" />&nbsp;&nbsp; <input
                           class="button white bigrounded" type="button" value="비밀번호 찾기"
                           style="width: 45%" onclick="search_check(2)" />
                     </div>
                  </div>

                  <DIV class="pop_login_errors">
                     <UL></UL>
                  </DIV>
                  <form name="pwFind" onsubmit="return MemberPassFind()">
                     <DIV class="inp_type_1 form-errors">
                        <!-- focus / err -->
                        <INPUT name="m_id" placeholder="아이디" value="" id="m_id" />
                     </DIV>
                     <DIV class="inp_type_1 form-errors">
                        <!-- focus / err -->
                        <INPUT name="m_email" placeholder="이메일" value="" id="m_email" />
                     </DIV>
                     <BUTTON type="button" class="btn_link gra_left_right_red"
                        id="pwFind" data-toggle="modal" data-target="#myModalPw">
                        <SPAN>비밀번호 찾기</SPAN>
                     </BUTTON>
                  </form>
                  <BUTTON class="btn_link" style="background: #F7323F"
                     onclick="location.href='./login.do'">
                     <SPAN>취소</SPAN>
                  </BUTTON>

               </SECTION>
            </DIV>
         </div>
      </DIV>

 
    <!--아이디 찾기 모달창-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
  aria-hidden="true" >
  <div class="modal-dialog modal-notify modal-info" role="document">
    <!--Content-->
    <div class="modal-content text-center">
      <!--Header-->
      <div class="modal-header d-flex justify-content-center" style="background:#5FB6DF;">
        <p class="heading" style="font-size: 30px; color: white">아이디찾기</p>
      </div>

      <!--Body-->
      <div class="modal-body">

        <i class="fas fa-bell fa-4x animated rotateIn mb-4" id="modalcontent" style="color: blue; font-size: 20px" ></i>

        <p></p>

      </div>

      <!--Footer-->
      <div class="modal-footer flex-center">
        <button type="button" class="btn-danger" data-dismiss="modal">창닫기</a>
      </div>
    </div>
    <!--/.Content-->
  </div>
</div>

      
         <!--비밀번호 찾기 모달창-->
<div class="modal fade" id="myModalPw" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
  aria-hidden="true" >
  <div class="modal-dialog modal-notify modal-info" role="document">
    <!--Content-->
    <div class="modal-content text-center">
      <!--Header-->
      <div class="modal-header d-flex justify-content-center" style="background:#5FB6DF;">
        <p class="heading" style="font-size: 30px; color: white">임시 비밀번호 발송</p>
      </div>

      <!--Body-->
      <div class="modal-body">

        <i class="fas fa-bell fa-4x animated rotateIn mb-4" id="modalcontent1" style="color: blue; font-size: 20px" ></i>

        <p></p>

      </div>

      <!--Footer-->
      <div class="modal-footer flex-center">
        <button type="button" class="btn-danger" data-dismiss="modal">창닫기</a>
      </div>
    </div>
    <!--/.Content-->
  </div>
</div>
      
      
      
      
      
      

   <STYLE>
/* layer_unfix 존재시 footer 숨김 */
.mobile_appdown, header, footer {
   display: none !important
}
</STYLE>
</BODY>
</HTML>