var markers = [];
var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
    center: new kakao.maps.LatLng(35.82406050330023, 127.14816812319762), //지도의 중심좌표.
    level: 4 //지도의 레벨(확대, 축소 정도)
}

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

var mapContainer = document.getElementById("map");
var coord = document.getElementById("clickLatlng");

// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();  

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});
searchPlaces();

// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;

    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        return false;
    }

    //전주지역 범위 설정
    var bounds = new kakao.maps.LatLngBounds(
        new kakao.maps.LatLng(35.7936, 127.0856), // 서쪽 위 좌표
        new kakao.maps.LatLng(35.8549, 127.1921)  // 동쪽 아래 좌표
    );

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch(keyword, function(data, status, pagination) {
        placesSearchCB(data, status, pagination, bounds);
    }); 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination, bounds) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data, bounds);

        // 페이지 번호를 표출합니다
        displayPagination(pagination);
        
        // 첫 번째 장소에 포커스를 맞추고 지도 레벨을 4로 설정합니다
        if (data.length > 0) {
            var placePosition = new kakao.maps.LatLng(data[0].y, data[0].x);
            map.setCenter(placePosition);
            map.setLevel(4);
        }

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}

function displayPlaces(places, bounds) {

    var listEl = document.getElementById('placesList'), 
    menuEl = document.getElementById('menu_wrap'),
    fragment = document.createDocumentFragment(), 

    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i), 
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);


        fragment.appendChild(itemEl);
        

    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}
// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}
// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.place_name + '</h5>';

    if (places.road_address_name) {
        itemStr += '    <span>' + places.road_address_name + '</span>' +
                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
    } else {
        itemStr += '    <span>' +  places.address_name  + '</span>'; 
    }
                    
        itemStr += '  <span class="tel">' + places.phone  + '</span>' +
                '</div>';           

    el.innerHTML = itemStr;
    el.className = 'item';

    // 검색 결과 항목 Element에 클릭 이벤트를 추가합니다
    el.addEventListener('click', function() {
        // 마커를 클릭한 경우, 해당 마커의 정보를 출력하거나 다른 이벤트를 처리할 수 있습니다.
        var clickedMarker = markers[index];
        var clickedPosition = clickedMarker.getPosition();
        // 원하는 이벤트 처리를 추가하세요.
        var placePosition = new kakao.maps.LatLng(clickedPosition.getLat(), clickedPosition.getLng());
            map.setCenter(placePosition);
            map.setLevel(4);
        onMarkerClick(clickedMarker,index);
    });
    
    return el;
}

//마커 이미지 설정
var markerImageUrl = 'https://cdn-icons-png.flaticon.com/512/5860/5860579.png', 
    markerImageSize = new kakao.maps.Size(40, 42), // 마커 이미지의 크기
    markerImageOptions = { 
        offset : new kakao.maps.Point(18, 40)// 마커 좌표에 일치시킬 이미지 안의 좌표
    };

// 마커 이미지를 생성한다
var markerImage = new kakao.maps.MarkerImage(markerImageUrl, markerImageSize, markerImageOptions);


// 지도에 마커를 생성하고 표시한다
var setmarker = new kakao.maps.Marker({
    position: new kakao.maps.LatLng(35.82406050330023, 127.14816812319762), // 마커의 좌표
    image : markerImage, // 마커의 이미지
    map: map // 마커를 표시할 지도 객체
});

// 마커 클릭 이벤트 핸들러
function onMarkerClick(marker, index) {
	setmarker.setMap(null);
    // 클릭한 마커의 정보를 출력하거나 원하는 작업을 수행합니다.
    var clickedPosition = marker.getPosition();
    
    var contentsLatitude = clickedPosition.getLat();
    var contentsLongitude = clickedPosition.getLng();

    setmarker.setMap(map);
    setmarker.setPosition(clickedPosition);
	
    $('#contentsLatitude').val(contentsLatitude);
    $('#contentsLongitude').val(contentsLongitude);
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    kakao.maps.event.addListener(marker, 'click', function() {
        onMarkerClick(marker, idx);
    });

    return marker;
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

    // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}


// 중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
kakao.maps.event.addListener(map, 'idle', function() {
    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
});

function searchAddrFromCoords(coords, callback) {
    // 좌표로 행정동 주소 정보를 요청합니다
    geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
}

function searchDetailAddrFromCoords(coords, callback) {
    // 좌표로 법정동 상세 주소 정보를 요청합니다
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}

// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
function displayCenterInfo(result, status) {
    if (status === kakao.maps.services.Status.OK) {
        var infoDiv = document.getElementById('centerAddr');

        for(var i = 0; i < result.length; i++) {
            // 행정동의 region_type 값은 'H' 이므로
            if (result[i].region_type === 'H') {
                infoDiv.innerHTML = result[i].address_name;
                break;
            }
        }
    }    
}

function passPlace(){
	var latitude = $('#contentsLatitude').val();
	var longitude = $('#contentsLongitude').val();
	var searchedPlaedName = $('input[name=searchedPlaedName]').val();
	if(searchedPlaedName ==""){
		alert("입력할 장소의 이름을 작성해주세요");
		return;
	}else if(longitude == ""){
		alert("장소를 선택해주세요");
		return;
	}
	window.opener.addToTable(searchedPlaedName, latitude, longitude);
}