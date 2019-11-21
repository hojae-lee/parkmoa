<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Parkmoa - Zoo&Aqua</title>
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
	<h2 style="text-align: center; color: orange;">동물원/아쿠아리움</h2>

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
			"서울특별시 강남구 삼성1동 영동대로513",
			"대전광역시 중구 대사동 보문산공원로469",
			"부산광역시 해운구 중동 해운대해변로 266",
			"서울특별시 송파구 잠실6동 올림픽로 300",
			"대구광역시 동구 신천4동 동부로 149",
			"경상북도 울진군 근남면 수산리 346",
			"충청북도 단양군 단양읍 별곡리 568",
			"강원도 강릉시 경포동 난설헌로 131",
			"경상남도 거제시 일운면 지세포해안로15",
			"부산광역시 영도구 동삼1동 해양로301번길 45",
			"강원도 고성군 현내면 화진포길 412",
			"인천광역시 남동구 장수동 595-4",
			"경기도 가평군 상면 임초밤안골로 301",
			"경기도 고양시 덕양구 관산동 290",
			"부산광역시 부산진구 초읍동 새싹로 295-1",
			"경상남도 진주시 판문동 남강로1번길 130",
			"경상남도 김해시 장유면 유하로226번길 70",
			"대전광역시 중구 사정동 사정공원로 70",
			"광주광역시 북구 생용동 산138",
			"전라북도 전주시 덕진구 덕진동1가 소리로68",
			"강원도 홍천군 화촌면 풍천리 310"
		];
		
		var listname = [
			"코엑스아쿠아리움",
			"부산아쿠아리움",
			"대전아쿠아리움",
			"롯데월드아쿠아리움",
			"대구아쿠아리움",
			"울진아쿠아리움",
			"단양다누리아쿠아리움",
			"강릉경포아쿠아리움",
			"거제씨월드",
			"국립해양박물관",
			"화진포해양박물관",
			"인천대공원 어린이동물원",
			"아침고요가족동물원",
			"쥬라리움 일산점",
			"삼정더파크",
			"진양호동물원",
			"부경동물원",
			"대전 오월드",
			"우치공원 동물원",
			"전주동물원",
			"알파카월드"
		];
		
		var tp_idx=[
			128,
			131,
			133,
			135,
			138,
			140,
			142,
			145,
			147,
			149,
			151,
			153,
			155,
			157,
			159,
			161,
			163,
			165,
			167,
			169,
			171
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
		                "<a style='color:black;' target='_blank' href='./board/listView.do?tp_category=zoo&tp_idx="+tp_idx[index]+"'>"+ listname[index] + "</a></div>",
		                disableAutoPan: true
		            });
		            infowindow.open(map, marker);
		        } 
		    });
		});
	</script>
</body>
</html>