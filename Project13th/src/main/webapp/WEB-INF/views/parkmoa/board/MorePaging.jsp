<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
request.setCharacterEncoding("UTF-8");



%>
   
<!-- 리스트반복 -->
	<tr>
		<div style="width:158px;">
			<li> 
				<dl style="text-align:center;">   
					<dt><a href="./listView.do?b_flag=${b_flag }&idx=${b_idx}&nowPage=${nowPage}"><img src="../../resources/upload/${b_attachedfile }" width="400px" height="200px;" /></a></dt>
					<dd><a href="./listView.do?b_flag=${b_flag }&idx=${b_idx}&nowPage=${nowPage}">${b_title }</a></dd> 
				</dl> 
			</li>
		</div>
	</tr>
