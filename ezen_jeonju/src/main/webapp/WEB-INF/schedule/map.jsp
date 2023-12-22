<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Jeonju Restaurants</title>
</head>
<body>
	
<h1>전주</h1>

<br>
<h2>지도</h2>
<div id="map" style="width:500px;height:400px;"></div>
<hr>
<button onclick="getJeonju()">전주 음식점 30개 가져오기</button>
<button onclick="setCenter()">전주 시정</button>
<br>


<div id="jj"></div>



<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24905b65af4a0e247d268677c3972e9d"></script>
<script>
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
    center: new kakao.maps.LatLng(35.824171, 127.14805), //지도의 중심좌표.
    level: 3 //지도의 레벨(확대, 축소 정도)
	
	
};
	var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
    var markerPosition  = new kakao.maps.LatLng(35.824171, 127.14805); 
    var marker = new kakao.maps.Marker({
	    position: markerPosition
	});    
	 //marker.setMap(null);
     marker.setMap(map);    


</script>
<script>
	function setCenter() {            
    // 이동할 위도 경도 위치를 생성합니다 
    var moveLatLon = new kakao.maps.LatLng(35.824171, 127.14805);
    
    // 지도 중심을 이동 시킵니다
    map.setCenter(moveLatLon);
    var markerPosition  = new kakao.maps.LatLng(35.824171, 127.14805); 
    var marker = new kakao.maps.Marker({
	    position: markerPosition
	});    
	 //marker.setMap(null);
     marker.setMap(map);    
}

function panTo(latitude,longitude) {
    // 이동할 위도 경도 위치를 생성합니다 
    var moveLatLon = new kakao.maps.LatLng(latitude,longitude);
    
    // 지도 중심을 부드럽게 이동시킵니다
    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
    map.panTo(moveLatLon);   
	var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 
	
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});    
	 //marker.setMap(null);
     marker.setMap(map);    
}        
</script>
<script>

    function getJeonju(){
        fetch("https://api.odcloud.kr/api/15076735/v1/uddi:73ae39f6-7aa9-49ee-915e-9018d738f882?page=1&perPage=30&serviceKey=%2BUFeyGq0yCyRGAnfn2BZHmpxwulEWArLYaKEKRMZZSGW85K8Gxlkum5LSZjUcypheIifRSpj1kFDOTS3yFa5wQ%3D%3D")
            .then((response) => response.json())
            .then((data) => {
                let restaurantList = "<ul>";

                data.data.forEach((restaurant, index) => {
                 
                    restaurantList += `<li>식당명: ${restaurant["식당명"]} <a href="https://map.kakao.com/link/map/${restaurant['식당명']},${restaurant['식당위도']},${restaurant['식당경도']}">지도 자세히보기</a>`;
                	restaurantList += `<button onclick="panTo(${restaurant['식당위도']},${restaurant['식당경도']})">좌표이동</button>`;
                
                });

                restaurantList += "</ul>";

                document.getElementById("jj").innerHTML = restaurantList;
            })
            .catch((error) => {
                console.error('There was a problem with the fetch operation:', error);
                document.getElementById("jj").innerHTML = "Failed to fetch restaurant data.";
            });
    }


</script>

</body>
</html>