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
        th.textContent = 'Day ' + i + ': '  +(startDate.getMonth()+1)+'월'+ startDate.getDate()+'일';

        // 헤더 셀에 스타일 추가
        th.style.height = '50px';
        th.style.width = '300px';
        th.style.maxHeight = '50px';
        th.style.whiteSpace = 'nowrap';

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
            td.style.height = '50px';
            td.style.width = '300px';
            td.style.maxHeight = '50px';
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


	var markers = []
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
	
	        $(".highlight").removeClass("highlight");
	        var columnIndex = $(this).index();
	
	        // 모든 행에 대해 현재 열에 해당하는 td에 highlight 클래스 추가
	        $('#dragDropTable tr:not(:eq(1))').find('td:eq(' + columnIndex + ')').addClass('highlight');
	
	        // 새로운 marker 생성
	        $("tr").each(function(index) {
	            var $highlightedCell = $(this).find('.highlight');
	           
	                var cellText = $highlightedCell.text();
	
	                var inputs = $highlightedCell.find('input');
	                var placeName = inputs.eq(0).val();
	                var tourCourseLatitude = inputs.eq(1).val();
	                var tourCourseLongitude = inputs.eq(2).val();
	
	                if (cellText !== "") {
	                   
	
	                    var markerPosition = new kakao.maps.LatLng(tourCourseLatitude, tourCourseLongitude);
	                    var marker = new kakao.maps.Marker({
	                        position: markerPosition,
	                        title: placeName
	                    });
	
	                    marker.setMap(map);
	                    markers.push(marker);
	                }
	            
	        });
    }

    return false;
}

	function markerList(){
	
		 
		 	console.log("마커");
		
	
	}
	
	//X눌렀을 때 사라지게하기
	function Xclose(cell, placeName) {
	    // 부모 노드인 <td>를 찾아서 삭제
	    cell.parentNode.innerHTML = '';
	    var xx;
	
	    for (var i = 0; i < markers.length; i++) {
	        if (placeName === markers[i].getTitle()) {
	            xx = i;
	
	            markers[i].setMap(null);
	            infowindows[i].setMap(null);
	
	            // markers 배열에서 해당하는 i번째 값을 제거
	            markers.splice(i, 1);
	            // infowindows 배열에서 해당하는 i번째 값을 제거
	
	            break;
	        }
	    }
	    addRankToTable('dragDropTable');
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

        schedulePeriod.innerHTML = startDatePeriod + " ~ " + endDatePeriod;

        // 추가: 동적으로 테이블 생성
        if(endDatePeriod == startDatePeriod){
            createTable('table-container', 1);
        }
        else{
        createTable('table-container', dayDifference+1);
        }
    }
