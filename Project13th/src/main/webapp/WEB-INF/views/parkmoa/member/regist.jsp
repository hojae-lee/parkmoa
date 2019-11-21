<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Parkmoa - 회원가입</title>
   <link rel="icon" href="../../img/Fevicon.png" type="image/png">
<link rel="stylesheet" href="https://www.goodchoice.kr/css/common.css?rand=1566971320" />
<link rel="canonical" href="https://www.goodchoice.kr/user/login"> 

<script>(function(a,b,c){if(c in b&&b[c]){var d,e=a.location,f=/^(a|html)$/i;a.addEventListener("click",function(a){d=a.target;while(!f.test(d.nodeName))d    =d.parentNode;"href"in d&&(d.href.indexOf("http")||~d.href.indexOf(e.host))&&(a.preventDefault(),e.href=d.href)},!1)}})(document,window.navigator,"standalone")</script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
//아이디 폼값검증
function id_Validate() {
   f = document.getElementById("loginForm");
   var regId = /^[A-Za-z0-9]{6,13}$/;
   if(!regId.test(f.m_id.value)){
      alert('아이디는 영어, 숫자로 6~13자내로 입력해주세요.');
      return false;
   }else{
      return true;
   }
}
//패스워드 폼값검증
function pass_Validate() {
   f = document.getElementById("loginForm");
   //패스워드 숫자,영문,특수문자 혼용 8자 이상
   var regPwd = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9]).{8,13}$/;
   if(regPwd.test(f.m_pw.value)) {
       return true;
   }else{
      alert('패스워드는 영문, 숫자, 특수문자 혼용으로 8~13자 내로 입력해주세요.');
      f.m_pw.focus();
      f.m_pw.select();
      return false;
   }
}


function number_Validate(){    
   f = document.getElementById("loginForm");    
    if(isNaN(f.m_mobile.value)){
        alert("특수문자를 사용할수 없습니다.다시입력해주세요.");
        f.m_mobile.focus();
        return false;
    }else{
        return true;
    }
}

//패스워드 일치 체크
$(function () {
   $('input[name="m_pw2"]').keyup(function () {
      if($('input[name="m_pw"]').val()==$(this).val()){
         $('#passCheck').html('비밀번호가 일치합니다.').attr("style","color:blue");
         $('input[name="pwFlag"]').val(1);
      }else{
         $('#passCheck').html('비밀번호가 일치하지 않습니다.').attr("style","color:red");
         $('input[name="pwFlag"]').val(0);
      }
   });
   
   $('input[name="m_pw2"]').focusout(function () {
      if(!($('input[name="m_pw"]').val()==$(this).val())){
         $('input[name="m_pw"]').focus();
      }
   });
});


//아이디 중복체크
$(function () {
   $('#btn_id_Validate').click(function () {
      
      $.ajax({
         url : "./checkId.do",
         type : "post",
         dataType : "json",
         contentType : "application/x-www-form-urlencoded;charset=UTF-8",
         data : {
            id : $('input[name="m_id"]').val()
         },
         beforeSend : function(xhr){
            /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다.시큐리티 적용후엔 필히 적용할것.*/
             xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
         },
         success : function (resp) {
            if (resp.result!=1){           
               $('#idCheck').html(resp.msg).attr("style","color:blue");
               $('#registFlag').attr("value","1");
               
            }else{
               $('#idCheck').html(resp.msg).attr("style","color:red");   
            }
         },
         error : function (e) {
            
            alert('오류발생'+e.status+":"+e.statusText);
         }
      });
   });
});

//회원가입 전체 폼값검증
function registValidate() {
   //아이디 중복체크 여부
   f = document.getElementById("loginForm");
   if(f.registFlag.value!=1){
      alert('아이디 중복체크를 해주세요.')
      return false;
   }
   //비밀번호 확인 일치여부
   if(f.pwFlag.value!=1){
      alert('비밀번호가 일치하지 않습니다.')
      return false;
   }
   
   if(id_Validate()){// 아이디 유효성 체크
      if(pass_Validate()){//패스워드 유효성 체크
         if(number_Validate()){
            return true;//폼값전송            
         }
      }   
   }   
   return false;   
}
</script>

</head>
<body>
<div class="layer_fix layer_unfix pop_login pop_mem_reserve">
    <section>
        <form:form id="loginForm" action="./registAction.do" onsubmit="return registValidate();" autocomplete="off" method="post">
            <input type="hidden" name="registFlag" id="registFlag" value="0"/>
            <input type="hidden" name="authority"  value="${authority }"/>
            <input type="hidden" name="pwFlag" value="0"/> 
            <div class="fix_title">
                <a href="../index.do"><img src="../../img/parkmoaLogo.png" alt="안되나요" /></a>
            </div>  
            <div class="inp_type_1 " style="padding-right: 0px;"><!-- focus / err -->
                <input type="text" name="m_id" placeholder="아이디" required class="required" value="${m_id }"
                       data-msg-required="아이디를 입력해 주세요." style="width: 55%;"/>
                <button class="btn" id="btn_id_Validate"  type="button"
                   style="float: right; width:45%; height:100%; background-color: #5FB6DF; color: white;">아이디 중복체크</button>
            </div>
            <div style="padding-left: 10px;">
                <span id="idCheck"></span>
            </div>
            <div class="inp_type_1 "><!-- focus / err -->
                <input type="text" name="m_name" placeholder="이름" required class="required" value="${m_name }"
                       data-msg-required="이름을 입력해 주세요."/>
            </div>
            <div class="inp_type_1 ">
                <input type="password" name="m_pw" placeholder="비밀번호" required class="required" 
                       data-msg-required="비밀번호를 입력해 주세요."/>
            </div>
            <div class="inp_type_1 ">
                <input type="password" name="m_pw2" placeholder="비밀번호확인" required class="required" 
                       data-msg-required="비밀번호를 확인해주세요." />
            </div>
            <div style="padding-left: 10px;">
                <span id="passCheck"></span>
            </div>
<!--             <div class="inp_type_1 ">
                <input type="text" name="m_birth" maxlength="8" placeholder="예시)19940208" required class="required" 
                       data-msg-required="생년월일을 확인해주세요."/>
            </div> -->
            <div class="inp_type_1 ">
                <input type="text" name="m_mobile" maxlength="11" placeholder="예시)01012345678" required class="required" 
                       data-msg-required="전화번호 확인해주세요."/>
            </div>
            <div class="inp_type_1"> 
               <table>
                  <tr>
                     <td><input type="email" name="m_email" placeholder="email@example.com" class="form-control" required class="required"  value="${m_email }"/></td>
                  </tr>
               </table>
            </div>

            <button class="btn_link" type="submit" style="background-color:#5fb6df;"><span style="font-weight:bold;">회원가입</span></button>

        </form:form>
    </section>
</div>
</body>
</html>