<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Parkmoa - 테마파크등록</title>
<link rel="icon" href="../../img/Fevicon.png" type="image/png">
<link rel="stylesheet"
	href="https://www.goodchoice.kr/css/common.css?rand=1566971320" />
<link rel="canonical" href="https://www.goodchoice.kr/user/login">

<script>(function(a,b,c){if(c in b&&b[c]){var d,e=a.location,f=/^(a|html)$/i;a.addEventListener("click",function(a){d=a.target;while(!f.test(d.nodeName))d    =d.parentNode;"href"in d&&(d.href.indexOf("http")||~d.href.indexOf(e.host))&&(a.preventDefault(),e.href=d.href)},!1)}})(document,window.navigator,"standalone")</script>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<link rel='stylesheet'
	href='https://use.fontawesome.com/releases/v5.7.0/css/all.css'
	integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ'
	crossorigin='anonymous'>
<script>

var themeObj = {
         searchBgColor: "#0B65C8", //검색창 배경색
         pageBgColor: "#A2CEFE", //페이지 배경색
         queryTextColor: "#FFFFFF" //검색창 글자색
      };
 
   function zipFind()
   {
       new daum.Postcode({
           oncomplete: function(data) {    
            
              var fullRoadAddr = data.roadAddress;
              
               var extraRoadAddr = ''; 
               
                   if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                       extraRoadAddr += data.bname;
                   }
                   if(data.buildingName !== '' && data.apartment === 'Y'){
                      extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                   }
                   if(extraRoadAddr !== ''){
                       extraRoadAddr = ' (' + extraRoadAddr + ')';
                   }
                   if(fullRoadAddr !== ''){
                       fullRoadAddr += extraRoadAddr;
                   }
              
               $("[name=tp_addr1]").val(fullRoadAddr);
           },
           theme: themeObj

       }).open(); 
   }
</script>
<style>
.inp_type_1 {
	padding: 0 0 0 16px;
}
</style>
<script>

$(function(){
	   $('#tp_parkregi').change(function(){
		   
	      if(this.value=='yes'){  
	    	  window
				.open(  
						'layout.do',
						'newlayout',
						'_blank',    
						'width=500',
						'height=40','left=100','top=50','resizable=0');
	          
	      }
	      else{       
	         $('#parkingarea').html("");  
	         $('#p_num').val(1);
	      }
	   });
	  
});




function input_tk(){
	 
	var frm = document.getElementById('frm');

	var f = document.getElementById('TicketapplyBtn');
    var zipFindck = document.getElementById('zipFindck');
    var tp_category = document.getElementById('tp_category');
    var tp_parkregi = document.getElementById('tp_parkregi');
    
    if(frm.tp_name.value==""){
    	alert("테마파크 이름을 입력해주세요");
    	return false;
    }

    if(tp_category.value==0){
       alert("테마파크종류를 선택하세요");
       return false;
    }
   
    if(tp_parkregi.value==0){
       alert("주차장등록여부를 선택하세요");
       return false;
    }
    
    if(frm.tp_phone.value==""){
    	alert("연락처를 입력해주세요");
    	return false;
    	
    }
    
    if(frm.tp_addr1.value==""){
    	alert("주소를 검색해주세요");
    	return false;
    }
    
    if(frm.tp_content.value==""){
    	alert("테마파크소개를 적어주세요");
    	return false;
    }

    if(zipFindck.value==0){  
       alert("테마파크주소를 등록 해주세요");
       return false;
    }
   
   
    if(f.value==0){
       alert("이용권 등록을 해주세요");
       return false;
    }
    
    frm.submit();
    alert("테마파크등록신청이 완료되었습니다.");
    window.close();
   
}


function ticketvalidate(){
   var f = document.getElementsByName("t_names");
   var fs = document.getElementsByName("t_prices");
   
   var authority = document.getElementById("modalauthority").value;  
   
 
   for(var i=0; i<f.length; i++){
      if(f[i].value==""){
         alert("이용권 이름을 입력해주세요");
         return false;
      }
   }
   for(var j=0; j<fs.length; j++){
      if(fs[j].value==""){
         alert("이용권 가격을 입력해주세요");
         return false;
      }
   }
    
   $.ajax({
      url : "../member/tkaction.do", 
      type : 'get', 
      contentType : "application/x-www-form-urlencoded;charset=UTF-8",
      data : $('#ticketModal').serialize(),
      dataType : 'json',
      traditional : true,
      beforeSend : function(xhr) {
         /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
         xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
      success : function(d){
         console.log(d);
         var html= "";
         var html1="";
         
         
         for(var i=0;i<d.t_name.length;i++){
            html += "<input type='hidden' name='t_name' value='"+d.t_name[i]+"'/>";
         }
         $('#hiddenForms').html(html);
         
         for(var i=0;i<d.t_price.length;i++){ 
            html1 += "<input type='hidden' name='t_price' value='"+d.t_price[i]+"'/>"; 
         }
         $('#hiddenForms1').html(html1);
         


         
         var msg = '이용권등록완료';
         alert(msg); 
         $('#myModal').modal('hide');
         $('#ticketsRs').text(msg);
         $('#TicketapplyBtn').val('1');
         
      },
      error : function(request, status, error) {
         alert("code:" + request.status
               + "\n" + "message:"
               + request.responseText
               + "\n" + "error:" + error);
      }
   });

}

//모달창 띄우기
function applyTk(){ 
   $('#myModal').on('show.bs.modal', function () {
       $('.modal-body').css('overflow-y', 'auto');   
       $('.modal-body').css('max-height', $(window).height() * 0.7);
   });   
}

</script>
</head>

<body onload="window.resizeTo(500,900)">
	<div class="layer_fix layer_unfix pop_login pop_mem_reserve">
		<section>
			<form:form autocomplete="off" method="post" id="frm"
				action="./tp_apply.do" enctype="multipart/form-data">
				<input type="hidden" id="layout" value="1" />
				<div id="hiddenForms"></div>
				<div id="hiddenForms1"></div>
				<input type="hidden" name="authority" value="${authority }" />
				<div class="fix_title">
					<a href="../index.do"><img src="../../img/parkmoaLogo.png"
						alt="안되나요" /></a>
				</div>
				<div align="center">
					<h2>테마파크등록</h2>
				</div>
				<div class="inp_type_1 ">
					<!-- focus / err -->
					<input type="text" name="m_id" placeholder="아이디"
						readonly="readonly" value="${m_id }"
						data-msg-required="아이디를 입력해 주세요." />
				</div>
				<div class="inp_type_1 ">
					<!-- focus / err -->
					<input type="text" name="tp_name" placeholder="테마파크이름" required
						class="required" value="" data-msg-required="테마파크이름을 입력해 주세요." />
				</div>

				<select id="tp_category" class="form-control" name="tp_category">
					<option value="0">테마파크 종류를 선택하세요</option>
					<option value="park">놀이동산</option>
					<option value="water">워터파크</option>
					<option value="zoo">동물원/아쿠아리움</option>
					<option value="forest">수목원</option>
				</select>


				<select id="tp_parkregi" class="form-control" name="tp_parkregi">
					<option value="0">주차장 등록여부를 선택하세요</option>
					<option value="yes">등록</option>
					<option value="no">미등록</option>
				</select>
				<input type="hidden" id="p_num" name="p_num" value="" />
				<span id="parkingarea" style="color: red;"></span>

				<div class="inp_type_1 " style="margin-bottom: 0px;">
					<input type="text" name="tp_phone" placeholder="연락처" required
						class="required" data-msg-required="연락처를 입력해 주세요." />
				</div>
				<div>
					<button type="button" class="btn btn-danger" onclick="zipFind();"
						style="padding: 0; width: 100px; height: 35px;">
						<span value="0" id="zipFindck">주소검색</span><i class="fa fa-search"></i>
					</button>
				</div>
				<div class="inp_type_1 ">
					<input type="text" name="tp_addr1" placeholder="테마파크주소" required
						readonly="readonly" class="required"
						data-msg-required="테마파크주소를 확인해주세요." />
				</div>

				<table style="margin: auto;">
					<tr>
						<td><textarea name="tp_content" rows="10"
								class="form-control" placeholder="테마파크소개를 적어주세요."></textarea></td>
					</tr>
					<tr>
						<td><input type="file" name="fileNm" required
							class="required" /></td>
					</tr>
				</table>
				<!-- test -->
				<button id="TicketapplyBtn" class="btn_link" type="button" value="0"
					onclick="applyTk();" data-toggle="modal" data-target="#myModal"
					style="background-color: #74db90;">
					<span style="font-weight: bold;" id="ticketsRs">이용권등록</span>
				</button>
				<button class="btn_link" type="button" id="ThemeRegistBtn"
					onclick="input_tk();" ;
					 style="background-color: #5fb6df;">
					<span style="font-weight: bold;">테마파크등록</span>
				</button>


			</form:form>
		</section>
	</div>
	<!-- 모달창 -->
	<form:form name="ticketModal" id="ticketModal" method="post">

		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-notify modal-info" role="document">
				<!--Content-->
				<div class="modal-content text-center">
					<!--Header-->
					<div class="modal-header d-flex justify-content-center"
						style="background: #5FB6DF;">
						<p class="heading" style="font-size: 30px; color: white">이용권등록</p>
					</div>
					<!--Body-->
					<div>
						<div class="modal-body">
							<input type="hidden" value="${authority }" id="modalauthority"
								name="modalauthority" />
							<table class="table table-bordered" id="ticketList">
								<tbody>
									<tr>
										<th>이용권 이름</th>
										<td><input type="text" name="t_names" /></td>
									</tr>
									<tr>
										<th>이용권 가격</th>
										<td><input type="text" name="t_prices" /></td>
									</tr>
									<!--Footer-->
								</tbody>
							</table>
							<div class="modal-footer flex-center"
								style="text-align: center; margin-top: 30px;">
								<button type="button" class="btn-danger" id="MoreTicket"
									style="width: 130px; height: 50px; align: center;">
									이용권추가</a>
								</button>
								<button type="button" class="btn-danger"
									onclick="ticketvalidate()"
									style="width: 130px; height: 50px; align: center;">
									이용권등록</a>
								</button>
								<button type="button" class="btn-danger"
									style="width: 130px; height: 50px; align: center;"
									data-dismiss="modal">
									창닫기</a>
								</button>
							</div>
						</div>
					</div>
				</div>
				<!--/.Content-->
			</div>
		</div>
	</form:form>
	<script>
$(function(){
   $('#MoreTicket').click(function(){ 
      var html ="";
       
      html += "<tr><th>이용권 이름</th>";
      html += "<td><input type='text' name='t_names'/></td></tr>";
      html += "<tr><th>이용권 가격</th>";
      html += "<td><input type='text' name='t_prices'/></td></tr>";
      
      $('#ticketList').append(html);
      
   });
});
</script>
</body>
</html>