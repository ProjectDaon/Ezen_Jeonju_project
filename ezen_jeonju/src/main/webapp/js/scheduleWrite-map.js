
    var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
    var options = { //지도를 생성할 때 필요한 기본 옵션
    center: new kakao.maps.LatLng(35.8240808, 127.1481404), //지도의 중심좌표.
    level: 7 //지도의 레벨(확대, 축소 정도)
	
	};
	var map = new kakao.maps.Map(container, options); // 지도를 생성합니다
	
	var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png", // 마커이미지의 주소입니다    
	    imageSize = new kakao.maps.Size(40, 46), // 마커이미지의 크기입니다
	    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
	      
	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
	    markerPosition = new kakao.maps.LatLng(35.8240808, 127.1481404); // 마커가 표시될 위치입니다
	
	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition, 
	    image: markerImage // 마커이미지 설정 
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);  



function setCenter() {            
    // 이동할 위도 경도 위치를 생성합니다 
    var moveLatLon = new kakao.maps.LatLng(35.8240808, 127.1481404);
    
    // 지도 중심을 이동 시킵니다
    map.setCenter(moveLatLon);
    var markerPosition  = new kakao.maps.LatLng(35.8240808, 127.1481404); 
    var marker = new kakao.maps.Marker({
	    position: markerPosition
	});    
	 //marker.setMap(null);
     marker.setMap(map);    
}

//var infowindows = [];

function panTo(placeName, latitude, longitude) {
    // 이동할 위도 경도 위치를 생성합니다 
    var moveLatLon = new kakao.maps.LatLng(latitude, longitude);

    // 마커를 생성합니다
    var markerPosition = new kakao.maps.LatLng(latitude, longitude);
    var marker = new kakao.maps.Marker({
        position: markerPosition,
        title : placeName
    });

    // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
   var iwContent =  '<div style="width:150px;text-align:center;font-weight:bold">'
    + '<a href=\'https://map.kakao.com/link/map/' + placeName + ',' + latitude + ',' + longitude + '\' target="_blank" style="color:black">'
    + placeName + '</a>'
    + '</div>';
    var iwPosition = new kakao.maps.LatLng(latitude, longitude); // 인포윈도우 표시 위치입니다

    // 지도 중심을 부드럽게 이동시킵니다
    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
    map.panTo(moveLatLon);

	 // 인포윈도우를 생성하고 표시합니다
     var infowindow = new kakao.maps.InfoWindow({
     map: map, // 인포윈도우가 표시될 지도
     position: iwPosition,
     content: iwContent
   });
    // 마커를 지도에 표시합니다
    marker.setMap(map);
    
    markers.push(marker);
	infowindows.push(infowindow);
    infowindow.open(map, marker);

}
     
