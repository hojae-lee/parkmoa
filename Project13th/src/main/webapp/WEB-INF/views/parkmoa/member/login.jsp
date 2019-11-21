<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Parkmoa - 로그인</title>
<link rel="icon" href="../../img/Fevicon.png" type="image/png">
<link rel="stylesheet"
   href="https://www.goodchoice.kr/css/common.css?rand=1566971320" />
<link rel="canonical" href="https://www.goodchoice.kr/user/login">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
   var _BASE_URL = 'https://www.goodchoice.kr/';
   var _MOBILE = 'W';
   var _KAKAOTALK_APP_KEY = 'f6ffb505bb11d7cc3584d443ce35f704';
   var _FACEBOOK_APP_ID = '607467975974643';
</script>
<script>(function(a,b,c){if(c in b&&b[c]){var d,e=a.location,f=/^(a|html)$/i;a.addEventListener("click",function(a){d=a.target;while(!f.test(d.nodeName))d    =d.parentNode;"href"in d&&(d.href.indexOf("http")||~d.href.indexOf(e.host))&&(a.preventDefault(),e.href=d.href)},!1)}})(document,window.navigator,"standalone")</script>
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/<popper class=""></popper>min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type='text/javascript'>
//<![CDATA[
// 사용할 앱의 JavaScript 키를 설정해 주세요.
Kakao.init('e3a9917f7858f1fd1599b650b19c0699');
function loginWithKakao() {
  // 로그인 창을 띄웁니다.
  Kakao.Auth.login({
    success: function(authObj) {
      //alert(JSON.stringify(authObj));
      location.href = "https://kauth.kakao.com/oauth/authorize?client_id=6b102bba20b2cd09bbb91dbccd68daa8&redirect_uri=http://localhost:8080/project3rd/oauth&response_type=code";
    },
    fail: function(err) {
      alert(JSON.stringify(err));
    }
  });
};
//]]>
</script>
</head>
<body>
   <div class="layer_fix layer_unfix pop_login pop_mem_reserve">
      <section>
         <form:form id="loginForm" action="../member/LoginAction.do"
            autocomplete="off" method="post">
            <div class="fix_title">
               <a href="../index.do"><img src="../../img/parkmoaLogo.png"
                  alt="안되나요" /></a>
            </div> 
            <a href="${google_url}" id="google_id_login">    
                <img src="../../resources/GoogleBtn.png" style="width:336px;height:65px;margin-bottom:5px;" alt="" />
            </a>
            <br />    
            <a id="kakao-login-btn" data-device-type="W" href="javascript:loginWithKakao();"> 
               <img src="../../resources/kakaoBtn1.png" alt="" style="width:336px;height:60px;margin-bottom:5px;"/>
            </a>
            <a href="${url}" id="naver_id_login" >
               <img src="../../resources/naverlogin.png" alt="" style="width:336px;height:58px;" /> 
            </a>

            <p class="space_or">
               <span>또는</span>
            </p>
            <div class="inp_type_1 ico_email form-errors">
               <!-- focus / err -->
               <input type="text" name="id" placeholder="아이디" required
                  class="required" value="" data-msg-required="아이디를 입력해 주세요." />
            </div>
            <div class="inp_type_1 ico_pw form-errors">
               <input type="password" name="pw" placeholder="비밀번호" required
                  class="required" data-msg-required="비밀번호를 입력해 주세요." />
            </div>
            <button class="btn_link" type="submit"
               style="background-color: #5fb6df;">
               <span style="font-weight: bold;">로그인</span>
            </button>
            <div class="link_half">
               <div>
                  <a href="../member/findId.do"><span style="font-size: 0.9em;">아이디/비밀번호
                        찾기</span></a>
               </div>
               <div>
                  <a href="../member/policy.do"><span style="font-size: 0.9em;">회원가입</span></a>
               </div>
            </div>

         </form:form>
      </section>
   </div>
</body>
</html>