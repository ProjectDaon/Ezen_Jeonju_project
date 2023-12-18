<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Article</title>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<link rel="stylesheet" href="../css/navbar.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<style>
ul.listul {
  list-style-type: none;
  padding: 0;
  margin: 0;
  display: flex;
}

li.listli {
  margin-right: 10px; /* 각 항목 사이의 간격 조절 */
  padding: 5px;
  border: 1px solid #ddd; /* 테두리 추가 */
  border-radius: 5px; /* 테두리의 모서리를 둥글게 만듦 */
}
</style>
</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");

});
</script>
<div id="headers"></div>

<br><br><br>
<br><br><br>
<br><br><br>

cidx: ${cv.cidx} <br>
제목: ${cv.contentsSubject} <br>
작성일: ${cv.contentsWriteday} <br>
조회수: ${cv.contentsViewCount} <br>
내용: ${cv.contentsArticle} <br>
해시태그
<ul class="listul">
    <c:forEach var="item" items="${hashtag}">
        <li class="listli">${item.value}</li>
    </c:forEach>
</ul>

<div id="map" style="width:500px;height:400px;"></div>
<input type="hidden" id="latitude" value="${cv.contentsLatitude}">
<input type="hidden" id="longitude" value="${cv.contentsLongitude}">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dbee45d6252968c16f0f651bb901ef42&libraries=services"></script>
<script>
	
	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var latitude = document.getElementById('latitude').value;
    var longitude = document.getElementById('longitude').value;
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
		};
	var map = new kakao.maps.Map(container, options);

	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
</script>
<a href="${pageContext.request.contextPath}/contents/contentsModify.do?cidx=${cv.cidx}">수정하기</a>
</body>
</html>