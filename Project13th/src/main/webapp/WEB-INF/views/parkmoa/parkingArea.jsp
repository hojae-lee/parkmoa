<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:forEach begin="1" end="100" var="i">
	 <button style="width: 65px; height:30px;">${i }</button>
	 <c:if test="${(i mod 10) eq 0 }">
	 <br /><br /> 
	 </c:if>
</c:forEach>
