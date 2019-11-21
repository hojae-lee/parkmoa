<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Parkmoa - Water</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</head>
<body onload="window.resizeTo(1400,900)">
	<p style="margin-top: 12px">
		<em class="link"> <a href="javascript:void(0);" style="color:red;"
			onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
				혹시 주소결과가 잘못 나오는 경우 제보해주시기바랍니다. </a> 
		</em>
	</p>
	<h2 style="text-align: center; color: blue;">워터파크</h2>

	<div id="map" style="width: 100%; height: 700px;"></div>     

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e6c1306b0809eb4842dc037c77c84813&libraries=services,clusterer,drawing"></script>

	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.478710, 126.878648), // 지도의 중심좌표
			level : 12     
		// 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		var listData = [
			"경기도 시흥시 서해안로 900",
			"경기도 용인시 처인구 포곡읍 에버랜드로 199",
			"인천광역시 강화군 길상면 보리고개로 174",
			"경기도 고양시 덕양구 대자동 1150-5",
			"서울특별시 송파구 문정동 송파대로 111 송파파크하비오 202동 B1",
			"서울특별시 영등포구 문래동 문래로 164",
			"경기도 남양주시 이패동 강변북로 876",
			"하남 스타필드 3층 신장동 616 하남시 경기도",
			"경기도 가평군 청평면 고성리 103-1",
			"강원도 속초시 장사동 미시령로2983번길 88",
			"강원도 속초시 대포동 908-1",
			"강원도 양양군 손양면 오산리 23-4",
			"강원도 정선군 사북읍 하이원길 175",
			"전남 여수시 소호로 295",
			"충남 천안시 동남구 성남면 종합휴양지로 200",
			"경기 여주시 강변유원지길 45",
			"경기 고양시 일산서구 한류월드로 300",
			"강원 홍천군 서면 한치골길 262",
			"경북 경주시 보문로 544"
		];
		
		var listname = [
			"월곶 에코피아 워터파크",
			"캐리비안 베이",
			"강화로얄워터파크",
			"통일 워터파크",
			"워터킹덤 & 스파",
			"씨랄라",
			"아쿠와조이",
			"아쿠아필드 하남",
			"블루레이크",
			"설악워터피아",
			"롯데 리조트 속초 워터파크",
			"쏠비치아쿠아월드",
			"하이원 워터월드",
			"디오션 워터파크",
			"대명리조트 천안오션파크",
			"썬밸리호텔 워터파크",
			"원마운트 워터파크",
			"오션월드",
			"경주월드캘리포니아비치"
		];
		
		var tp_idx=[
			85,
			87,
			90,
			93,
			95,
			97,
			99,
			101,
			104,
			106,
			109,
			111,
			113,
			116,
			118,
			120,
			122,
			124,
			126
		];

		listData.forEach(function(addr, index) {
		    geocoder.addressSearch(addr, function(result, status) {
		        if (status === daum.maps.services.Status.OK) {
		            var coords = new daum.maps.LatLng(result[0].y, result[0].x);

		            var marker = new daum.maps.Marker({
		                map: map,
		                position: coords
		            });       
		            
		            var infowindow = new daum.maps.InfoWindow({  
		                content: "<div style='width:150px;text-align:center;'>"+
		                "<a style='color:black;' target='_blank' href='./board/listView.do?tp_category=water&tp_idx="+tp_idx[index]+"'>"+ listname[index] + "</a></div>",
		                disableAutoPan: true
		            });
		            infowindow.open(map, marker);
		        } 
		    });
		});
	</script>
</body>
</html>