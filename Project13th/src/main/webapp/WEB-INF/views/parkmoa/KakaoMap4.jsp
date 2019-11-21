<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Parkmoa - Forest</title>
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
		<em class="link"> <a href="javascript:void(0);"
			style="color: red;"
			onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
				혹시 주소결과가 잘못 나오는 경우 제보해주시기바랍니다. </a>
		</em>
	</p>
	<h2 style="text-align: center; color: green;">수목원</h2>
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
			"경기 양평군 양서면 양수로 93",
			"강원 춘천시 남산면 햇골길 80 제이드가든수목원",
			"충남 태안군 소원면 천리포1길 187 천리포수목원",
			"경기 포천시 소흘읍 광릉수목원로 415",
			"대전 서구 둔산대로 169",
			"경기 오산시 청학로 211",
			"제주 제주시 수목원길 72",
			"경기 파주시 광탄면 부흥로 242",
			"대구 달서구 화암로 342 대구수목원관리사무소",
			"경기 양평군 양평읍 수목원길 16",
			"서울 동대문구 회기로 57",
			"경남 진주시 이반성면 수목원로 386 경상남도수목원",
			"충남 태안군 남면 연꽃길 70",
			"서울 구로구 연동로 240",
			"경기 남양주시 불암산로59번길 48-31 산들소리수목원",
			"경기 이천시 마장면 작촌로 282",
			"강원 강릉시 구정면 수목원길 156",
			"세종 금남면 산림박물관길 110 산림박물관",
			"전북 전주시 덕진구 번영로 462-45 전주수목원",
			"충북 청주시 상당구 미원면 수목원길 51 충북 산림환경연구원"
			];

		var listname = [ 
			"세미원",
			"제이드가든",
			"천리포수목원",
			"국립수목원",
			"한밭수목원",
			"물향기수목원",
			"한라수목원",
			"벽초지 수목원",
			"대구수목원",
			"양평들꽃수목원",
			"홍릉숲",
			"경상남도수목원",
			"청산수목원",
			"푸른수목원",
			"산들소리수목원",
			"덕평공룡수목원",
			"강릉솔향수목원",
			"금강수목원",
			"한국도로공사 전주수목원",
			"미동산수목원"
			];

		var tp_idx = [
			173,
			175,
			177,
			179,
			181,
			183,
			185,
			187,
			189,
			191,
			193,
			195,
			197,
			199,
			201,
			203,
			205,
			207,
			209
			];

		listData
				.forEach(function(addr, index) {
					geocoder
							.addressSearch(
									addr,
									function(result, status) {
										if (status === daum.maps.services.Status.OK) {
											var coords = new daum.maps.LatLng(
													result[0].y, result[0].x);

											var marker = new daum.maps.Marker({
												map : map,
												position : coords
											});

											var infowindow = new daum.maps.InfoWindow(
													{
														content : "<div style='width:150px;text-align:center;'>"
																+ "<a style='color:black;' target='_blank' href='./board/listView.do?tp_category=forest&tp_idx="
																+ tp_idx[index]
																+ "'>"
																+ listname[index]
																+ "</a></div>",
														disableAutoPan : true
													});
											infowindow.open(map, marker);
										}
									});
				});
	</script>
</body>
</html>