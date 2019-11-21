<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Parkmoa - Parking</title>
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</head>
<script>
function confrim(idx){
   opener.document.getElementById("layout").value = '2';
   opener.document.getElementById("parkingarea").innerHTML = '주차장등록완료되었습니다.';
   opener.document.getElementById("p_num").value = idx;
   alert("주차장등록");
   self.close();
}

</script>
<style>
td{
border : 1px inset black;
}
</style>
<body onload="window.resizeTo(1400,900)">
   <table>
      <div class="container" style="text-align: center;">
         <h2>주차장을 선택해주세요</h2>
         <p>현재 가상의 주차장을 통해 등록중입니다.</p>
         <table style="width: 100%; height: 100%; border: 1px inset black; background-color: #585858;">
               <tr> 
                  <td style="width:33%; height: 50%; text-align: center;">
                     <a href="javascript:confrim(2);" id="layout1">
                        <img src="../../resources/layout1.jpg" alt="" style="width:70%; height: 70%;"/>                     
                     </a>
                  </td>
                  <td style="width:33%; height: 50%; text-align: center;" >
                     <a href="javascript:confrim(3);" id="layout2">
                        <img src="../../resources/layout2.jpg" alt="" style="width:70%; height: 70%;"/>
                     </a>
                  </td>
                  <td style="width:33%; height: 50%; text-align: center;">
                     <a href="javascript:confrim(4);" id="layout3">
                        <img src="../../resources/layout3.jpg" alt="" style="width:315px; height: 312px;"/>               
                     </a>
                  </td>
               </tr>
               <tr>
                  <td style="width:33%; height: 50%; text-align: center;">
                     <a href="javascript:confrim(5);" id="layout4">
                        <img src="../../resources/layout4.jpg" alt="" style="width:70%; height: 70%;"/>                     
                     </a>
                  </td>
                  <td style="width:33%; height: 50%; text-align: center;">
                     <a href="javascript:confrim(6);" id="layout5">
                        <img src="../../resources/layout5.jpg" alt="" style="width:70%; height: 70%;"/>
                  
                     </a>
                  </td>
                  <td style="width:33%; height: 50%; text-align: center;">
                     <a href="javascript:confrim(7);" id="layout6">
                        <img src="../../resources/layout6.jpg" alt="" style="width:70%; height: 70%;"/>
                     </a>
                  </td>
               </tr>

         </table>
      </div>

   </table>
</body>
</html>