<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/searchMapPopup.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

</head>
<body>
<div class="editer_wrap">
	<div class="topTitle">
		<h3>장소 등록하기</h3>
		<span>키워드 검색 후 목록에서 원하는 장소를 클릭해주세요.</span>
		<hr>
	</div>
	<div style="margin-top:10px;margin-left: 50px;">
	<strong>입력될 장소</strong>: 
	<div id="searchedPlace" class="searchedPlace">
		<input type="hidden" id="contentsLatitude" value="">
		<input type="hidden" id="contentsLongitude">
		<input type="text" class="searchedPlaedName" name="searchedPlaedName" placeholder="장소이름">
		<button type="botton" class="passPlaceBtn" onclick="passPlace()">등록</button>
	</div>
	</div>
	<div class="map_wrap">
		<div id="map">
		</div>
			<div id="menu_wrap" class="bg_white">
				<div class="option">
					<div>
						<form name="map_frm" onsubmit="searchPlaces(); return false;">
						키워드 : <input type="text" value="" id="keyword" size="15"> 
						<button type="submit">검색하기</button> 
						</form>
					</div>
				</div>
				<hr>
				<ul class="placesList" id="placesList"></ul>
				<div id="pagination"></div>
		</div>
		<div class="hAddr">
			<span class="title">지도중심기준 행정동 주소정보</span>
			<span id="centerAddr"></span>
		</div>
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dbee45d6252968c16f0f651bb901ef42&libraries=services"></script>
	<script src="../js/searchMapPopup.js"></script>
</div>
<div>
</div>
</body>
</html>