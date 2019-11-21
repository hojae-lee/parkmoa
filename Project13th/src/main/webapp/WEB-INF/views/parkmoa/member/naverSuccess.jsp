<%@page import="parkmoa.model.ParkmoaMemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!doctype html>
<html lang="ko">
<head>
<script type="text/javascript"
   src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.2.js"
   charset="utf-8"></script>
<script type="text/javascript"
   src="http://code.jquery.com/jquery-1.11.3.min.js"></script>
<style type="text/css">
html, div, body, h3 {
   margin: 0;
   padding: 0;
}

h3 {
   display: inline-block;
   padding: 0.6em;
}
</style>
<script type="text/javascript">
   $(document).ready(function() {
      
      var name = ${result}.response.name;
      var email = ${result}.response.email;
      $("#name").html("환영합니다. "+name+"님");
      $("#email").html(email);

      document.registfrm.m_name.value=name;
      document.registfrm.m_email.value=email;
      $("#m_name").val()=name;
      $("#m_email").val()=email;
     });
</script>

</head>  
<body>

   <div
      style="background-color: #15a181; width: 100%; height: 50px; text-align: center; color: white;">
      <h3>SIST Naver_Login Success</h3>
   </div>
   <br>
   
   <form:form action="./naver.do" method="post" name="registfrm">  
      <h2 style="text-align: center" id="name"></h2>
      <h4 style="text-align: center" id="email"></h4> 
         <input type="hidden" name="m_name" id="m_name" value=""/>
         <input type="hidden" name="m_email" id="m_email" value="" /> 
      <button type="submit">
         <strong>등록</strong></button>
         <a href="./logout.do">로그아웃하기</a>  
   </form:form>

</body>
</html>