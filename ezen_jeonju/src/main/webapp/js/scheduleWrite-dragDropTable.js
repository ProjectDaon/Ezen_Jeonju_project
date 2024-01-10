﻿function addDays(dateString, days) {
	    var currentDate = new Date(dateString);
	    currentDate.setDate(currentDate.getDate() + days);
	
	    var year = currentDate.getFullYear();
	    
	    // 월이 한 자리 수인 경우 앞에 0을 추가
	    var month = (currentDate.getMonth() + 1).toString().padStart(2, '0');
	    
	    // 일이 한 자리 수인 경우 앞에 0을 추가
	    var day = currentDate.getDate().toString().padStart(2, '0');
	    
	    return year + '-' + month + '-' + day;
	}
		<!--일정 테이블 생성함수-->
	var markers = []	
	var positions = []
    function createTable(parentElementId, columnCount) {
    // 테이블이 있으면 삭제하고 생성
    var existingTable = document.getElementById(parentElementId).querySelector('table');
    if (existingTable) {
        existingTable.remove();
    }

    // 부모 요소 가져오기
    var parentElement = document.getElementById(parentElementId);
    let startDate = new Date(document.getElementById("startDate").value);
    let endDatePeriod = document.getElementById("endDate").value;

    // 테이블 요소 생성
    var table = document.createElement('table');
    table.id = 'dragDropTable';

    var thead = document.createElement('thead');
    var trHeader = document.createElement('tr');
    for (var i = 1; i <= columnCount; i++) {
        var th = document.createElement('th');
        th.textContent = 'Day ' + i + ' : '  +(startDate.getMonth()+1)+'월'+ startDate.getDate()+'일';

        // 헤더 셀에 스타일 추가
        th.style.height = '57px';
        th.style.width = '600px';
        th.style.maxHeight = '57px';
        th.style.minWidth = '200px';
        th.style.whiteSpace = 'nowrap';
        th.classList.add("fixed");

        startDate.setDate(startDate.getDate()+1);
        trHeader.appendChild(th);
    }
    thead.appendChild(trHeader);
    table.appendChild(thead);

    // 테이블 바디 생성 (임시 데이터로 5개의 행 추가)
    var tbody = document.createElement('tbody');
    for (var j = 1; j <= 16; j++) {
        var trBody = document.createElement('tr');
        for (var k = 1; k <= columnCount; k++) {
            if((j==1) && (k>1)){
                
                continue;  
            }

            var td = document.createElement('td');
            td.textContent = "";
            
            // 바디 셀에 스타일 추가
            td.style.height = '57px';
            td.style.width = '300px';
            td.style.maxHeight = '57px';
            td.style.whiteSpace = 'nowrap';
           
            //행 열 아이디 부여
            td.id = j+'_'+k;
            
            //날짜 시간 장소
            var hour = j+6;
            
            $(td).attr("name", addDays($('#startDate').val(), k-1) + "_" + hour + "_" + k);
            trBody.appendChild(td);

        }

       	tbody.appendChild(trBody);
    }

    // 첫 번째 행의 colspan 설정
    var firstRow = tbody.querySelector('tr');
    var firstCell = firstRow.querySelector('td');
    firstCell.colSpan = columnCount;
    firstCell.textContent = "장소를 누르시고 원하는 시간대에 드래그하세요";
    firstCell.id = 'addSchedule';
    firstRow.classList.add("fixed_1");
    table.appendChild(tbody);

    // 부모 요소에 테이블 추가
    parentElement.appendChild(table);
   
    // 드래그 시작한 요소의 참조를 저장하는 변수
    let dragSrcElement = null;

    // 드래그 시작 이벤트 핸들러
    function handleDragStart(e) {
	    if (this.innerText === "장소를 누르시고 원하는 시간대에 드래그하세요" || this.innerText ==="") {
	        e.preventDefault();
	        return;
	    }
    
        // 드래그 시작한 요소의 참조 저장
        dragSrcElement = this;
        // 드래그 효과 설정
        e.dataTransfer.effectAllowed = 'move';
        // 드래그 데이터 설정 (텍스트/HTML 형식)
        e.dataTransfer.setData('text/html', this.innerHTML);
        // 드래그 중인 행에 클래스 추가하여 투명도 적용
        this.classList.add('dragged');
    }

    // 드래그 중인 상태에서 다른 요소 위로 이동할 때 발생하는 이벤트 핸들러
    function handleDragOver(e) {
        // 기본 동작 방지
        if (e.preventDefault) {
            e.preventDefault();
        }
        // 드래그 가능한 효과 설정
        e.dataTransfer.dropEffect = 'move';
        return false;
    }

    // 드래그 중인 상태에서 요소에 진입했을 때 발생하는 이벤트 핸들러
    function handleDragEnter() {
        // 드래그 중인 행에 클래스 추가하여 시각적 효과 적용
        this.classList.add('over');
    }

    // 드래그 중인 상태에서 요소에서 빠져나갈 때 발생하는 이벤트 핸들러
    function handleDragLeave() {
        // 드래그 중인 행에서 클래스 제거하여 시각적 효과 제거
        this.classList.remove('over');
    }

	
    // 드롭이 일어났을 때 발생하는 이벤트 핸들러
    
	function handleDrop(e) {
	    // 이벤트 전파 방지
	    if (e.stopPropagation) {
	        e.stopPropagation();
	    }
	
	    // 드래그 소스와 드롭 대상이 다를 경우만 처리
	    if (dragSrcElement !== this) {
	        // 드래그 소스의 내용을 드롭 대상으로 이동
	        dragSrcElement.innerHTML = this.innerHTML;
	        // 드롭 대상의 내용을 드래그 소스로 이동
	        this.innerHTML = e.dataTransfer.getData('text/html');
	
	        // 기존 맵에 있는 marker 모두 지우기
	for (var i = 0; i < markers.length; i++) {
	        markers[i].setMap(null);
	    }
	    // markers 초기화
	    markers = [];
		positions =[];
	    $(".highlight").removeClass("highlight");
	    $(".highlight2").removeClass("highlight2");
	    var columnIndex = $(this).index();
	
	    // 모든 행에 대해 현재 열에 해당하는 td에 highlight 클래스 추가
	    $('#dragDropTable tr:not(:eq(1))').find('td:eq(' + columnIndex + ')').addClass('highlight');
		$('#dragDropTable th:eq(' + columnIndex + ')').addClass('highlight2');
		$('#nDate').val((columnIndex+1)+" 일차");
	    // 새로운 marker 생성
	    $("tr").each(function (index) {
	        var $highlightedCell = $(this).find('.highlight');
	
	        var cellText = $highlightedCell.text();
	
	        var inputs = $highlightedCell.find('input');
	        var placeName = inputs.eq(0).val();
	        var tourCourseLatitude = inputs.eq(1).val();
	        var tourCourseLongitude = inputs.eq(2).val();
			
	        if (cellText !== "") {
	            // 마커 이미지 생성
	            var markerImage = new kakao.maps.MarkerImage(
	                'https://placehold.jp/23/3d4070/ffffff/25x25.png?text=' + (markers.length + 1),
	                new kakao.maps.Size(25, 25),
	                { offset: new kakao.maps.Point(13, 25) }
	            );
	
	            var markerPosition = new kakao.maps.LatLng(tourCourseLatitude, tourCourseLongitude);
	            var marker = new kakao.maps.Marker({
	                position: markerPosition,
	                title: placeName,
	                image: markerImage  // 마커에 이미지 설정
	            });
	
	            marker.setMap(map);
	            positions.push(markerPosition);
	            panTo(tourCourseLatitude, tourCourseLongitude);
	            markers.push(marker);
	            drawLine(positions);
	        }
	    });
    }

    return false;
}

    // 드래그 종료 시 발생하는 이벤트 핸들러
    function handleDragEnd() {
        // 드래그 중인 행의 투명도 클래스 제거
        this.classList.remove('dragged');
        // 드롭 대상의 시각적 효과 클래스 제거
        items.forEach(function (item) {
            item.classList.remove('over');
        });
        
    }
	
	//클릭 했을 시 발생하는 이벤트 핸들러
	function handleClick() {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }
    // markers 초기화
    markers = [];
	positions = [];
    $(".highlight").removeClass("highlight");
    $(".highlight2").removeClass("highlight2");
    var columnIndex = $(this).index();
	$('#nDate').val((columnIndex+1)+" 일차");
    // 모든 행에 대해 현재 열에 해당하는 td에 highlight 클래스 추가
    $('#dragDropTable tr:not(:eq(1))').find('td:eq(' + columnIndex + ')').addClass('highlight');
    $('#dragDropTable th:eq(' + columnIndex + ')').addClass('highlight2');
    // 새로운 marker 생성
    $("tr").each(function (index) {
        var $highlightedCell = $(this).find('.highlight');

        var cellText = $highlightedCell.text();

        var inputs = $highlightedCell.find('input');
        var placeName = inputs.eq(0).val();
        var tourCourseLatitude = inputs.eq(1).val();
        var tourCourseLongitude = inputs.eq(2).val();

        if (cellText !== "") {
            // 마커 이미지 생성
            var markerImage = new kakao.maps.MarkerImage(
                'https://placehold.jp/23/3d4070/ffffff/25x25.png?text=' + (markers.length + 1),
                new kakao.maps.Size(25, 25),
                { offset: new kakao.maps.Point(13, 25) }
            );

            var markerPosition = new kakao.maps.LatLng(tourCourseLatitude, tourCourseLongitude);
            var marker = new kakao.maps.Marker({
                position: markerPosition,
                title: placeName,
                image: markerImage  // 마커에 이미지 설정
            });

            marker.setMap(map);
            panTo(tourCourseLatitude, tourCourseLongitude);
            markers.push(marker);
            positions.push(markerPosition);
            drawLine(positions);
        }
        else{
       		content = '<div class="dotOverlay distanceInfo">total : <span class="number">0</span>m</div>';
        	panTo(35.8240808, 127.1481404);
            positions.push(new kakao.maps.LatLng(35.8240808, 127.1481404));
            drawLine(positions);
        }
    });
}

    // 테이블의 모든 행을 선택하여 드래그 이벤트 리스너 등록
    const items = document.querySelectorAll('#dragDropTable tbody td');
    items.forEach(function(item) {
        item.draggable = true;
        item.addEventListener('dragstart', handleDragStart, false);
        item.addEventListener('dragover', handleDragOver, false);
        item.addEventListener('dragenter', handleDragEnter, false);
        item.addEventListener('dragleave', handleDragLeave, false);
        item.addEventListener('drop', handleDrop, false);
        item.addEventListener('dragend', handleDragEnd, false);
        item.addEventListener('click', handleClick, false);
    });

}


    function createPeriod() {
        let schedulePeriod = document.getElementById("schedulePeriod");
        let startDatePeriod = document.getElementById("startDate").value;
        let endDatePeriod = document.getElementById("endDate").value;

        let startDate = new Date(document.getElementById("startDate").value);
        let endDate = new Date(document.getElementById("endDate").value);

        if (startDate > endDate || endDatePeriod == "" || startDatePeriod == "") {
            alert("날짜 설정을 제대로 해주세요");
            return;
        }

        var timeDifference = endDate.getTime() - startDate.getTime(); // 밀리초 단위의 차이
        var dayDifference = timeDifference / (1000 * 60 * 60 * 24);

        if (dayDifference > 7) {
            alert("기간은 최대 일주일까지 가능합니다");
            return;
        }

        // 추가: 동적으로 테이블 생성
        if(endDatePeriod == startDatePeriod){
            createTable('table-container', 1);
        }
        else{
        createTable('table-container', dayDifference+1);
        }
    }
	function panTo(latitude, longitude) {
	    // 이동할 위도 경도 위치를 생성합니다 
	    var moveLatLon = new kakao.maps.LatLng(latitude, longitude);
	
	    // 지도 중심을 부드럽게 이동시킵니다
	    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
	    map.panTo(moveLatLon);
	   
	}
	var polyline = null;
	var distanceOverlay = null;

	function drawLine(positions) {
		
	    if (polyline) {
        	polyline.setMap(null);
    	}
		
	    // Polyline을 그리기 위한 좌표 배열 생성
	    var polylinePath = [];
	    for (var i = 0; i < positions.length; i++) {
	        polylinePath.push(positions[i]);
	    }
	
	    // 새로운 Polyline 생성
	    polyline = new kakao.maps.Polyline({
	        map: map,
	        path: polylinePath,
	        strokeWeight: 3,
	        strokeColor: '#db4040',
	        strokeOpacity: 1,
	        strokeStyle: 'solid'
	    });
	
	    // Polyline에 대한 거리 정보 계산 및 표시
	    showDistanceInfo(polyline);
	
	    // 결과로 얻은 content를 어딘가에 사용할 수 있음
	}
	
	function showDistanceInfo(polyline) {
	    // 선의 총 거리를 계산
	    var distance = Math.round(polyline.getLength());
	
	    // content 생성
	    var content = '<div class="dotOverlay distanceInfo">total : <span class="number">' + distance + '</span>m</div>';
	
	    // CustomOverlay 표시
	    showDistance(content, polyline.getPath()[0]); // 여기서 getPath()[0]은 Polyline의 첫 번째 좌표를 사용합니다.
	}
	
	function showDistance(content, position) {
	    // 기존 CustomOverlay가 있으면 지우기
	    if (distanceOverlay) {
	        distanceOverlay.setMap(null);
	    }
	
	    // CustomOverlay 생성 및 지도에 표시
	    distanceOverlay = new kakao.maps.CustomOverlay({
	        map: map,
	        content: content,
	        position: position,
	        xAnchor: 0,
	        yAnchor: 0,
	        zIndex: 3
	    });
	}

