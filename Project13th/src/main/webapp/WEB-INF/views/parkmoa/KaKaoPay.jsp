<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js" ></script>

<script type="text/javascript">
window.onload = function(){
	var IMP = window.IMP; // 생략가능
	IMP.init('imp15153124'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	IMP.request_pay({
	    pg : 'kakaopay', // version 1.1.0부터 지원.
	    pay_method : 'card', 
	    merchant_uid : $('input[name=t_name]').val() + new Date().getTime(),
	    name : $('input[name=t_name]').val(),
	    amount : $('input[name=TotalPrice]').val(),
	    buyer_email : $('input[name=m_email]').val(),
	    buyer_name : $('input[name=m_id]').val(),
	    buyer_tel : $('input[name=m_mobile]').val(),
	    buyer_addr : '서울특별시 코스모다',
	    buyer_postcode : '123-456',
	    app_scheme : 'iamportkakao',
	    //m_redirect_url : './AndroidpayResult.do'
	}, function(rsp) {
		 if ( rsp.success ) {
		       //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
		       jQuery.ajax({
		          url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
		          type: 'POST',
		          dataType: 'json',
		          data: {
		             imp_uid : rsp.imp_uid
		             //기타 필요한 데이터가 있으면 추가 전달
		          }
		       }).done(function(data) {
		          //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
		          if ( everythings_fine ) {
		             var msg = '결제가 완료되었습니다.';
		             msg += '\n고유ID : ' + rsp.imp_uid;
		             msg += '\n상점 거래ID : ' + rsp.merchant_uid;
		             msg += '\결제 금액 : ' + rsp.paid_amount;
		             msg += '카드 승인번호 : ' + rsp.apply_num;
		             
		             alert(msg);
		          } else {
		             //[3] 아직 제대로 결제가 되지 않았습니다.
		             //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
		          }
		       });
		       paymentAction();
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		        
		        alert(msg);
		    }
	});
	
}
/* 중략 */
	//onclick, onload 등 원하는 이벤트에 호출합니다
	function paymentAction() {
		
		var f = document.getElementById("frm");
		
		f.action="./AndroidpayResult.do"; 
		f.method="post"; 
		f.submit(); 
	
	}

</script>
 
<body>
	<form action="" id="frm">
		<input type="hidden"  name="tp_idx" value="${tp_idx }"/>  
		<input type="hidden"  name="t_name" value="${t_name }"/>
		<input type="hidden"  name="TotalPrice" value="${TotalPrice }"/>
		<input type="hidden"  name="m_email" value="${m_email }"/>
		<input type="hidden"  name="m_id" value="${m_id }"/>
		<input type="hidden"  name="m_mobile" value="${m_mobile }"/>
		<input type="hidden"  name="r_useregi" value="${r_useregi }"/>
		<input type="hidden"  name="tp_name" value="${tp_name }"/> 
		<input type="hidden"  name="p_num" value="${p_num }"/>  
		<input type="hidden"  name="m_membership" value="${m_membership }"/>     
	</form>
</body>
