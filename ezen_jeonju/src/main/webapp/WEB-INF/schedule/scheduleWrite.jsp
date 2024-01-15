<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/scheduleWrite.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 만들기</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

	$(document).ready( function() {
		$('#headers').load("../nav/nav.jsp");
		$('#footers').load("../nav/footer.jsp");
	
	});

	//랭크 추가 함수
	function addRankToTable(tableId) {
	var table = document.getElementById(tableId);
	var rows = table.getElementsByTagName('tr');
	
	for (var j = 0; j < rows[0].cells.length; j++) {
	    var rank = 1;
	    
	    for (var i = 2; i < rows.length; i++) {
	        var cell = rows[i].cells[j];
	        
	        // td에 값이 있을 경우에만 랭크 추가
	        if (cell.innerHTML.trim() !== "") {
	            
                var existingRank = cell.querySelector('#sequence');
                if (existingRank) {
                    existingRank.parentNode.removeChild(existingRank);
                }
	        	
	        	cell.innerHTML = "<Strong id='sequence'>" + "<span id='rank'>" + rank + "</span>" + " : </Strong>" + cell.innerHTML;
	            rank++;
	       		}
	   		 }
		}
	}
	
	//드래그시 랭크부여
	document.addEventListener("dragend", function (event) {
	    addRankToTable('dragDropTable');
	});
		
	<!--전주 음식점 api 불러오는 함수-->
    let currentPageFood = 1;
    let currentPagePlace = 1;
    let currentPageTour = 1;
    let currentPageRest = 1;
    const itemsPerPage = 10;
    let perPage = 850;
    let filteredDataCnt = 0;
    //맛집추천
    function getFood() {
    	event.preventDefault();
        let obj = document.getElementById("jj");
        let existingPs = obj.querySelectorAll('p');
        existingPs.forEach((p) => {
            p.remove();
        });
		
        
	    let startIdx = (currentPageFood - 1) * itemsPerPage;
        let endIdx = startIdx + itemsPerPage; 

        fetch("https://api.odcloud.kr/api/15076735/v1/uddi:98edad48-0892-4621-8741-cdff64f99c79?page=" + currentPageFood + "&perPage=" + perPage + "&serviceKey=%2BUFeyGq0yCyRGAnfn2BZHmpxwulEWArLYaKEKRMZZSGW85K8Gxlkum5LSZjUcypheIifRSpj1kFDOTS3yFa5wQ%3D%3D")
        .then((response) => response.json())
        .then((data) => {
            let List = "<ul>";

            let filteredData = data.data.filter((place) => place['네이버 인기도'] > 4.0);
            
            // 필터된 데이터의 갯수를 가져오기
            filteredDataCnt = filteredData.length;

            filteredData.slice(startIdx, endIdx).forEach((place) => {
                let newP = document.createElement("p");
                let placeName = place['식당명'];
                let placelatitude = place['식당위도'];
                let placelongitude = place['식당경도'];
                let placeScore = Math.floor(place['네이버 인기도']); // 정수로 내림

                // 별 특수문자로 갯수 표현
                let stars = "★".repeat(placeScore);
                let emptyStars = "☆".repeat(5 - placeScore); // 비어있는 별
                
                
                newP.innerHTML = "<a href='javascript:addToTable(\"" + placeName + "," + placelatitude + "," + placelongitude + "\")'>" + placeName + "</a>";
                newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
                newP.innerHTML += "별점 : <span id='stars'>" + stars + emptyStars + "</span>(" +place['네이버 인기도']+")" ;
                newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
                newP.innerHTML += '<a href=\'https://map.kakao.com/link/map/' + placeName + ',' + placelatitude + ',' + placelongitude + '\'>지도</a>';

                obj.appendChild(newP);
            });
        })
        .then(() => { // fetch가 완료된 후에 실행되도록 이동
            $('#pageIndex').text(currentPageFood + " / " + 2);
            $('#placeBtn').removeClass('active');
            $('#foodBtn').addClass('active');
            $('#tourBtn').removeClass('active');
            $('#restBtn').removeClass('active');
        })
    }
    //음식점
    function getRest() {
    	event.preventDefault();
        let obj = document.getElementById("jj");
        let existingPs = obj.querySelectorAll('p');
        existingPs.forEach((p) => {
            p.remove();
        });
		
        
	    let startIdx = (currentPageRest - 1) * itemsPerPage;
        let endIdx = startIdx + itemsPerPage; 

        fetch("http://apis.data.go.kr/B551011/KorService1/areaBasedList1?numOfRows=122&pageNo=1&MobileOS=ETC&MobileApp=AppTest&ServiceKey=%2BUFeyGq0yCyRGAnfn2BZHmpxwulEWArLYaKEKRMZZSGW85K8Gxlkum5LSZjUcypheIifRSpj1kFDOTS3yFa5wQ%3D%3D&listYN=Y&arrange=A&contentTypeId=39&areaCode=37&sigunguCode=12&cat1=&cat2=&cat3=&_type=json")
        .then((response) => response.json())
        .then((data) => {
            // items -> item 배열을 가져와서 forEach
            data.response.body.items.item.slice(startIdx, endIdx).forEach((place) => {
                let newP = document.createElement("p");
                let newImage = document.createElement("img");
                newImage.classList.add("placeimg");
                let placeName = place['title'];
                let placelatitude = place['mapy'];
                let placelongitude = place['mapx'];
                let placeImage = place['firstimage'];
				
                if (placeImage) {
                    newImage.src = placeImage;
                } else {
                	 // 사진없을 때
                    newImage.src = 'https://via.placeholder.com/100x100/CCCCCC/FFFFFF?text=No+Image';
                }
              
                newP.appendChild(newImage);   
                newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
                newP.innerHTML += "<a href='javascript:addToTable(\"" + placeName + "," + placelatitude + "," + placelongitude + "\")'>" + placeName + "</a>";
                newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
                newP.innerHTML += '<a href=\'https://map.kakao.com/link/map/' + placeName + ',' + placelatitude + ',' + placelongitude + '\'>지도</a>';
                
                obj.appendChild(newP);
            });
        })
        .then(() => {
            $('#pageIndexRest').text(currentPageRest + " / " + 13);
            $('#placeBtn').removeClass('active');
            $('#foodBtn').removeClass('active');
            $('#tourBtn').removeClass('active');
            $('#restBtn').addClass('active');
        });
    }
    //관광지
    function getTour() {
    	event.preventDefault();
        let obj = document.getElementById("jj");
        let existingPs = obj.querySelectorAll('p');
        existingPs.forEach((p) => {
            p.remove();
        });

	    let startIdx = (currentPageTour - 1) * itemsPerPage;
        let endIdx = startIdx + itemsPerPage; 	
        
        fetch("https://apis.data.go.kr/B551011/KorService1/areaBasedList1?numOfRows=82&pageNo=1&MobileOS=ETC&MobileApp=AppTest&ServiceKey=%2BUFeyGq0yCyRGAnfn2BZHmpxwulEWArLYaKEKRMZZSGW85K8Gxlkum5LSZjUcypheIifRSpj1kFDOTS3yFa5wQ%3D%3D&listYN=Y&arrange=A&contentTypeId=12&areaCode=37&sigunguCode=12&cat1=&cat2=&cat3=&_type=json")
            .then((response) => response.json())
            .then((data) => {
                // items -> item 배열을 가져와서 forEach
                data.response.body.items.item.slice(startIdx, endIdx).forEach((place) => {
                    let newP = document.createElement("p");
                    let newImage = document.createElement("img");
                    newImage.classList.add("placeimg");
                    let placeName = place['title'];
                    let placelatitude = place['mapy'];
                    let placelongitude = place['mapx'];
                    let placeImage = place['firstimage'];
                    if (placeImage) {
                        newImage.src = placeImage;
                    } else {
                        // 사진없을 때
                        newImage.src = 'https://via.placeholder.com/100x100/CCCCCC/FFFFFF?text=No+Image';
                    }

                    newP.appendChild(newImage);  
                    newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
                    newP.innerHTML += "<a href='javascript:addToTable(\"" + placeName + "," + placelatitude + "," + placelongitude + "\")'>" + placeName + "</a>";
                    newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
                    newP.innerHTML += '<a href=\'https://map.kakao.com/link/map/' + placeName + ',' + placelatitude + ',' + placelongitude + '\'>지도</a>';
					
                 
                    obj.appendChild(newP);
                });
            })
            .then(() => {
                $('#pageIndexTour').text(currentPageTour + " / " + 9);
                $('#placeBtn').removeClass('active');
                $('#foodBtn').removeClass('active');
                $('#tourBtn').addClass('active');
                $('#restBtn').removeClass('active');
            });
    }
    //명소
    function getPlace() {
    	event.preventDefault();
        let obj = document.getElementById("jj");
        let existingPs = obj.querySelectorAll('p');
        let top = 0;
        existingPs.forEach((p) => {
            p.remove();
        });

        let startIdx = (currentPagePlace - 1) * itemsPerPage;
        let endIdx = startIdx + itemsPerPage;

        fetch("https://api.odcloud.kr/api/15125431/v1/uddi:3f24f89a-940d-4512-88d7-80b993cd28b8?page=" + currentPagePlace + "&perPage=10&serviceKey=%2BUFeyGq0yCyRGAnfn2BZHmpxwulEWArLYaKEKRMZZSGW85K8Gxlkum5LSZjUcypheIifRSpj1kFDOTS3yFa5wQ%3D%3D")
            .then((response) => response.json())
            .then((data) => {
                data.data.slice(startIdx, endIdx).forEach((place) => {
                	top++;
                    let newP = document.createElement("p");
                    let placeName = place['관광명소명'];
                    let placelatitude = place['위도'];
                    let placelongitude = place['경도'];
                    newP.innerHTML = "<span id='top'>Top" + top +" : &nbsp;</span>";
                    newP.innerHTML +=  "<a href='javascript:addToTable(\"" + placeName +","+placelatitude +","+ placelongitude +"\")'>" + placeName + "</a>";
                    newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
                    newP.innerHTML += '<a href=\'https://map.kakao.com/link/map/' + placeName + ',' + placelatitude + ',' + placelongitude + '\'>지도</a>';

                    obj.appendChild(newP);
                });
            })
	        	.then(() => { // fetch가 완료된 후에 실행되도록 이동
	        	
        		$('#pageIndexPlace').text(currentPagePlace+" / 1");
	        	$('#placeBtn').addClass('active');
	            $('#foodBtn').removeClass('active');
	            $('#tourBtn').removeClass('active');
	            $('#restBtn').removeClass('active');
        	})
       
    }

    function nextPage() {
        if (currentPageFood > 1) {
            alert('마지막 페이지입니다.');
        } else {
            currentPageFood++;
            getFood();
        }
        
    }

    function prevPage() {
        if (currentPageFood > 1) {
            currentPageFood--;
            getFood();
        }
       
    }
    
    function nextPageTour() {
        if (currentPageTour > 8) {
            alert('마지막 페이지입니다.');
        } else {
            currentPageTour++;
            getTour();
        }
        
    }

    function prevPageTour() {
        if (currentPageTour > 1) {
            currentPageTour--;
            getTour();
        }
       
    }
    
    function nextPagePlace() {
        if (currentPagePlace > 0) {
            alert('마지막 페이지입니다.');
        } else {
            currentPagePlace++;
            getPlace();
        }
        
    }
    function prevPageRest() {
        if (currentPageRest > 1) {
            currentPageRest--;
            getRest();
        }
       
    }
    
    function nextPageRest() {
        if (currentPageRest > 12) {
            alert('마지막 페이지입니다.');
        } else {
            currentPageRest++;
            getRest();
        }
        
    }

    // 음식점 이름을 클릭하면 테이블 셀에 정보를 추가
    function addToTable(placeName, placeLatitude, placeLongitude) {
    		if(placeLatitude){
    			placeName = placeName+","+placeLatitude+","+placeLongitude;
    		}
    		$("#scheduletbl").scrollTop(0);
    		$("#scheduletbl").scrollLeft(0);
    	    let tableCell = document.getElementById("addSchedule");
    	    let placeArray = placeName.split(',');
    	    // 이름 추가
    	    if(tableCell == null){
				alert('기간을 먼저 등록해주세요');
				return
    	    }else{
    	    	if (childWindow && !childWindow.closed) {
    	            childWindow.close();
    	        }
    	    }
    	    
    	    tableCell.innerHTML = placeArray[0];
    	    
    	    // X 버튼 및 추가 정보를 담은 input 태그 추가
    	    tableCell.innerHTML += "<input type='hidden' value='" + placeArray[0] + "'>";
    	    tableCell.innerHTML += "<input type='hidden' value='" + placeArray[1] + "'>";
    	    tableCell.innerHTML += "<input type='hidden' value='" + placeArray[2] + "'>";
    	    tableCell.innerHTML += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' style='text-decoration:none'; onclick='Xclose(this, \"" + placeArray[0] + "\");'>X</a>";


    }
    
	//X눌렀을 때 사라지게하기
	function Xclose(cell, placeName) {
	    // 부모 노드인 <td>를 찾아서 삭제
	    event.preventDefault();
	    cell.parentNode.innerHTML = '';
	    var xx;
	
	    for (var i = 0; i < markers.length; i++) {
	        if (placeName === markers[i].getTitle()) {
	            xx = i;
	
	            markers[i].setMap(null);
	            //infowindows[i].setMap(null);
	
	            // markers 배열에서 해당하는 i번째 값을 제거
	            markers.splice(i, 1);
	            // infowindows 배열에서 해당하는 i번째 값을 제거
	
	            break;
	        }
	    }
	    addRankToTable('dragDropTable');
	}
	var childWindow;
	function openSearchMap(){
		childWindow = window.open('${pageContext.request.contextPath}/schedule/searchMapPopup.do','childForm','width= 1024, height=585');
	}


</script>

</head>
<body>
<div id="headers" ondragstart="return false;"></div>
<div class="innerwrap">
<h3>일정 만들기</h3>
<form name="frm">
<div id="inputs">
<hr>
    제목 <input id="title" style="width:40%" type="text" name="scheduleSubject">
    공개여부
    <select id="selectYN" name="scheduleShareYN">
        <option value="Y">예</option>
        <option value="N">아니요</option>
    </select>
   <br>
<hr>
<div id="period">
      기간 <input id="startDate" type="date" name="scheduleStartDate"> ~ <input id="endDate" type="date" name="scheduleEndDate">
    <div id="periodBtn"><a href="javascript:createPeriod()">기간등록</a></div>  
</div>
    <input id="write" type="button" value="저장" onclick="goWrite()"> <br>
<hr>    
</div>

	<div id="preNext" ondragstart="return false;">
		<div id="restBtn">
		    <a href="#" onclick="prevPageRest()"><</a>
		    <b id="pageIndexRest"></b>
		    <a href="#" onclick="nextPageRest()">></a>
		</div>
		
		<div id="foodBtn">
		    <a href="#" onclick="prevPage()"><</a>
		    <b id="pageIndex"></b>
		    <a href="#" onclick="nextPage()">></a>
		</div>
		
		<div id="placeBtn">
		    <a href="#"><</a>
		    <b id="pageIndexPlace"></b>
		    <a href="#" onclick="nextPagePlace()">></a>
		</div>
		
		<div id="tourBtn">
		    <a href="#" onclick="prevPageTour()"><</a>
		    <b id="pageIndexTour"></b>
		    <a href="#" onclick="nextPageTour()">></a>
		</div>
	</div>
	<div id="totaltbl">
		<div id="tourselect" ondragstart="return false;">
		<div id="buttons">
			<div id="rest">
			<a href="#" onclick="getRest()">음식점</a>
			</div>
			<div id="tour">
			<a href="#" onclick="getTour()">관광지</a>
			</div>
			<div id="food">
			<a href="#" onclick="getFood()">맛집 추천</a>
			</div>
			<div id="place">
			<a href="#" onclick="getPlace()">명소 추천</a>
			</div>
		</div>
		<div class="searchPlace">
			<select name="searchP" class="searchP">
				<option value="food">음식점</option>
				<option value="place">관광지</option>
			</select>
			<input type="text" name="searchK">
			<button type="button" name="searchPBtn" onclick="javascript:searchKeyword()">검색</button>
			<script>
			function searchKeyword(){
			    var category = $('select[name=searchP]').val();
			    var keyword = $('input[name=searchK]').val();
			    
			    let obj = document.getElementById("jj");
		        let existingPs = obj.querySelectorAll('p');
		        existingPs.forEach((p) => {
		            p.remove();
		        });
		        
			    if(category==='food'){
					let totalElemental = 0;
			        fetch("http://apis.data.go.kr/B551011/KorService1/areaBasedList1?numOfRows=122&pageNo=1&MobileOS=ETC&MobileApp=AppTest&ServiceKey=%2BUFeyGq0yCyRGAnfn2BZHmpxwulEWArLYaKEKRMZZSGW85K8Gxlkum5LSZjUcypheIifRSpj1kFDOTS3yFa5wQ%3D%3D&listYN=Y&arrange=A&contentTypeId=39&areaCode=37&sigunguCode=12&cat1=&cat2=&cat3=&_type=json")
			        .then((response) => response.json())
			        .then((data) => {
			            // items -> item 배열을 가져와서 forEach
			            data.response.body.items.item.slice(0, 850).forEach((place) => {
				            let newP = document.createElement("p");
			                let newImage = document.createElement("img");
			                newImage.classList.add("placeimg");
			                let placeName = place['title'];
			                let placelatitude = place['mapy'];
			                let placelongitude = place['mapx'];
			                let placeImage = place['firstimage'];
							
			                if (placeImage) {
			                    newImage.src = placeImage;
			                } else {
			                	 // 사진없을 때
			                    newImage.src = 'https://via.placeholder.com/100x100/CCCCCC/FFFFFF?text=No+Image';
			                }
			              	if(placeName.includes(keyword)){
				                newP.appendChild(newImage);   
				                newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
				                newP.innerHTML += "<a href='javascript:addToTable(\"" + placeName + "," + placelatitude + "," + placelongitude + "\")'>" + placeName + "</a>";
				                newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
				                newP.innerHTML += '<a href=\'https://map.kakao.com/link/map/' + placeName + ',' + placelatitude + ',' + placelongitude + '\'>지도</a>';
				                obj.appendChild(newP);
				                totalElemental += 1;
			              	}
			            });
			        })
			        .then(() => {
			            $('#pageIndexRest').text("검색결과 총 "+totalElemental+"개");
			            $('#placeBtn').removeClass('active');
			            $('#foodBtn').removeClass('active');
			            $('#tourBtn').removeClass('active');
			            $('#restBtn').addClass('active');
			        });
			    }else{
			        let totalTourElemental = 0;
			        fetch("https://apis.data.go.kr/B551011/KorService1/areaBasedList1?numOfRows=82&pageNo=1&MobileOS=ETC&MobileApp=AppTest&ServiceKey=%2BUFeyGq0yCyRGAnfn2BZHmpxwulEWArLYaKEKRMZZSGW85K8Gxlkum5LSZjUcypheIifRSpj1kFDOTS3yFa5wQ%3D%3D&listYN=Y&arrange=A&contentTypeId=12&areaCode=37&sigunguCode=12&cat1=&cat2=&cat3=&_type=json")
			            .then((response) => response.json())
			            .then((data) => {
			                // items -> item 배열을 가져와서 forEach
			                data.response.body.items.item.slice(0, 850).forEach((place) => {
			                    let newP = document.createElement("p");
			                    let newImage = document.createElement("img");
			                    newImage.classList.add("placeimg");
			                    let placeName = place['title'];
			                    let placelatitude = place['mapy'];
			                    let placelongitude = place['mapx'];
			                    let placeImage = place['firstimage'];
			                    if (placeImage) {
			                        newImage.src = placeImage;
			                    } else {
			                        // 사진없을 때
			                        newImage.src = 'https://via.placeholder.com/100x100/CCCCCC/FFFFFF?text=No+Image';
			                    }
			                    if(placeName.includes(keyword)){
				                    newP.appendChild(newImage);  
				                    newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
				                    newP.innerHTML += "<a href='javascript:addToTable(\"" + placeName + "," + placelatitude + "," + placelongitude + "\")'>" + placeName + "</a>";
				                    newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
				                    newP.innerHTML += '<a href=\'https://map.kakao.com/link/map/' + placeName + ',' + placelatitude + ',' + placelongitude + '\'>지도</a>';
				                    obj.appendChild(newP);
				                    totalTourElemental += 1;
			                    }
			                });
			            })
			            .then(() => {
			                $('#pageIndexTour').text("검색결과 총 "+totalTourElemental+"개");
			                $('#placeBtn').removeClass('active');
			                $('#foodBtn').removeClass('active');
			                $('#tourBtn').addClass('active');
			                $('#restBtn').removeClass('active');
			            });
			    }
			}
			</script>
		</div>
		
		<div id="jj"></div>
		</div>
		<br>
			<div id = "scheduletbl">
			<table id="timetbl">
			        <thead><th class="fixed">시간</th></thead>
			        <tbody>
			            <tr class="fixed_1"><td>08 ~ 22:00</td></tr>
			            <tr><td>08:00</td></tr>
			            <tr><td>09:00</td></tr>
			            <tr><td>10:00</td></tr>
			            <tr><td>11:00</td></tr>
			            <tr><td>12:00</td></tr>
			            <tr><td>13:00</td></tr>
			            <tr><td>14:00</td></tr>
			            <tr><td>15:00</td></tr>
			            <tr><td>16:00</td></tr>
			            <tr><td>17:00</td></tr>
			            <tr><td>18:00</td></tr>
			            <tr><td>19:00</td></tr>
			            <tr><td>20:00</td></tr>
			            <tr><td>21:00</td></tr>
			            <tr><td>22:00</td></tr>
			        </tbody>
			</table>
		
			<div id="table-container">
				<table id="firstTable">
					<thead>
						<th class="fixed" style="height:57px; width:1200px">기간을 먼저 등록해주세요 ! </th>
					<thead>
					<tbody>
			            <tr><td class="fixed_1"></td></tr>
			            <tr><td></td></tr>
			            <tr><td></td></tr>
			            <tr><td></td></tr>
			            <tr><td></td></tr>
			            <tr><td></td></tr>
			            <tr><td></td></tr>
			            <tr><td></td></tr>
			            <tr><td></td></tr>
			            <tr><td></td></tr>
			            <tr><td></td></tr>
			            <tr><td></td></tr>
			            <tr><td></td></tr>
			            <tr><td></td></tr>
			            <tr><td></td></tr>
			            <tr><td></td></tr>
					</tbody>
				</table>
			</div>
			</div>
		</form>
		<div id="mapDate">
		<input id="nDate" readonly="true"></input>
		<div id="map" style="width:400px;height:400px;"></div>
		</div>
		<div class="searchMap">
			<button type="button" onclick="openSearchMap()">지도로 찾기</button>
		</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dbee45d6252968c16f0f651bb901ef42&libraries=services"></script>
<script src="../js/scheduleWrite-map.js"></script>
<script type="text/javascript" src ="../js/scheduleWrite-dragDropTable.js"></script>

<script>    

    <!-- 글 작성 함수 -->
    function goWrite() {
    	
        var fm = document.frm;
        var tbodyCells = document.querySelectorAll('#dragDropTable tbody td');
        var tourCourseTime 
        var tourCourseDate 
        var tourCourseNDate
        var jsonArray 	= new Array();
    	var scheduleSubject = fm.scheduleSubject.value;
	    var scheduleStartDate = fm.scheduleStartDate.value;
	    var scheduleEndDate = fm.scheduleEndDate.value;
	    var scheduleShareYN = fm.scheduleShareYN.value;
    	//각 td 엘리먼트를 순회하면서 텍스트가 있는지 확인
    	tbodyCells.forEach(function(td) {
    	 // 텍스트가 있는 경우
    	 
	    	 if ((td.textContent.trim() !== "") &&(td.textContent !== "장소를 누르시고 원하는 시간대에 드래그하세요")) {
	    	     // 원하는 작업 수행

	    	     	var jsonObj = new Object();

	    	     	var inputs = td.getElementsByTagName('input');
	    	     	var tourCoursePlace = inputs[0].value;
	    	     	var tourCourseLatitude = inputs[1].value;
	    	     	var tourCourseLongitude = inputs[2].value;
		    		  		
		    	    nameArray = td.getAttribute('name').split('_');
		    	    tourCourseDate = nameArray[0];
		    	    tourCourseTime = nameArray[1];
		    	    tourCourseNDate = nameArray[2];

					jsonObj.tourCourseDate = tourCourseDate;
					jsonObj.tourCourseTime = tourCourseTime;
					jsonObj.tourCourseNDate = tourCourseNDate;
					jsonObj.tourCoursePlace = tourCoursePlace;
					jsonObj.tourCourseLatitude = tourCourseLatitude;
					jsonObj.tourCourseLongitude = tourCourseLongitude;
					
					jsonObj = JSON.stringify(jsonObj);
					jsonArray.push(JSON.parse(jsonObj));

    	 			
    	 	}
    	});
    	let arrays = JSON.stringify(jsonArray);
    	
        if (fm.scheduleSubject.value == "") {
            alert('제목을 입력해주세요');
            fm.scheduleSubject.focus();
            return;
        }
        else if (fm.scheduleStartDate.value == "" || fm.scheduleEndDate.value == "") {
            alert('날짜를 입력해주세요');
            fm.scheduleStartDate.focus();
            return;
         
        }	  
        $.ajax({
			type : "post",
			url : "<%=request.getContextPath()%>/schedule/scheduleWriteAction.do",
			data : {
				scheduleShareYN:scheduleShareYN,
				scheduleSubject:scheduleSubject,
				scheduleStartDate:scheduleStartDate,
				scheduleEndDate:scheduleEndDate,
				tourCourseDate:tourCourseDate,
				tourCourseTime:tourCourseTime,
				tourCourseNDate:tourCourseNDate,
				
				Array:arrays
			},
			dataType : "json",
			success : function(data){
    			if(data.value == 0){
					alert("입력오류");	    				
    			}else{
	    			//alert("완료");
    			}				
			},
			error : function(request, status, error){
				//alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				return;
			} 
	});
        alert("글이 작성되었습니다");
        
        var loc = "<%=request.getContextPath()%>/schedule/scheduleList.do";
		location.href=loc;
	   	return;
}
 $(document).ready(function(){
	  getRest();
	 //getFood();
	   
}); 

</script>
</div>
<div id="footers" ondragstart="return false;"></div>
</body>
</html>