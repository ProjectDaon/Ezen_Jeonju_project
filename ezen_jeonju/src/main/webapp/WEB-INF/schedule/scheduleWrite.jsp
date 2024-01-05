<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
.number {font-weight:bold;color:#ee6152;}
.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
.distanceInfo .label {display:inline-block;width:50px;}
.distanceInfo:after {content:none;}
	img {
		width : 70px;
		height : 70px;
	}

	table {
		border-collapse: collapse;
		
	}

	th, td {
		border: 1px solid #ddd;
		padding: 16px;
		text-align: left;

	}

	th {
		background-color: #f2f2f2;
	}

	#jj{
		width:150px;
	}
	
    #schedulePeriod{
        text-align: center;
    }

    #timetbl{
       width:50px; 
    }
    #totaltbl{
    	display: flex; 
        flex-direction: row;
    }

    #scheduletbl{
        display: flex; 
        flex-direction: row;
        width: 800px;
        height: 600px;
        overflow: scroll;
        margin-left: 300px;
    }

    #timetbl td {
        text-align: center; 
        height: 50px;
    }

    #timetbl th {
        text-align: center;
        height: 50px;
    }
    #table-container tbody th {
    height: 50px; /* 각 셀의 높이를 50px로 설정 */
    width: 300px; /* 각 셀의 너비를 200px로 설정 */
    max-height: 50px; /* 최대 너비를 200px로 설정 */
    white-space: nowrap; /* 텍스트가 줄 바꿈되지 않도록 설정 */ 
    }

    #table-container tbody td {
    
    height: 50px; /* 각 셀의 높이를 50px로 설정 */
    width: 300px; /* 각 셀의 너비를 200px로 설정 */
    max-height: 50px; /* 최대 너비를 200px로 설정 */
    white-space: nowrap; /* 텍스트가 줄 바꿈되지 않도록 설정 */
	}

	p {
	 
	 white-space: nowrap;
	
	}
	
	#foodBtn, #placeBtn, #tourBtn, #restBtn{
		
	display : none;
		
	} 
	
	#foodBtn.active,
	#placeBtn.active,
	#tourBtn.active,
	#restBtn.active {
  
    display: inline-block;
  	}
	.customoverlay a{
		color : black;
		font-weight:bold;
	}
	
    .highlight {
      
       background-color: #f2f2f2;
    }
    .fixed{
     position: sticky;
     top : 0; 
    }
    .fixed_1{
     position: sticky;
     top : 83.09px; 
    }
    #addSchedule{
   
   	color : orange;
   	font-weight : bold;
    }
</style>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>

	
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
    function getFood() {
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
                let placeScore = place['네이버 인기도'];

                newP.innerHTML = "<a href='#' onclick='addToTable(\"" + placeName + "," + placelatitude + "," + placelongitude + "\")'>" + placeName + "</a>";
                newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
                newP.innerHTML += "네이버 별점 : " + placeScore
                newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
                newP.innerHTML += '<a href=\'https://map.kakao.com/link/map/' + placeName + ',' + placelatitude + ',' + placelongitude + '\'>지도 자세히보기</a>';

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
    function getRest() {
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
                let placeName = place['title'];
                let placelatitude = place['mapy'];
                let placelongitude = place['mapx'];
                let placeImage = place['firstimage'];
                newP.innerHTML = "<a href='#' onclick='addToTable(\"" + placeName + "," + placelatitude + "," + placelongitude + "\")'>" + placeName + "</a>";
                newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
                newP.innerHTML += '<a href=\'https://map.kakao.com/link/map/' + placeName + ',' + placelatitude + ',' + placelongitude + '\'>지도 자세히보기</a>';
				
                if (placeImage) {
                    newImage.src = placeImage;
                } else {
                	 // 사진없을 때
                    newImage.src = 'https://via.placeholder.com/100x100/CCCCCC/FFFFFF?text=No+Image';
                }

              
                newP.appendChild(newImage);                   
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
    
    function getTour() {
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
                    let placeName = place['title'];
                    let placelatitude = place['mapy'];
                    let placelongitude = place['mapx'];
                    let placeImage = place['firstimage'];
                    newP.innerHTML = "<a href='#' onclick='addToTable(\"" + placeName + "," + placelatitude + "," + placelongitude + "\")'>" + placeName + "</a>";
                    newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
                    newP.innerHTML += '<a href=\'https://map.kakao.com/link/map/' + placeName + ',' + placelatitude + ',' + placelongitude + '\'>지도 자세히보기</a>';
					
                    if (placeImage) {
                        newImage.src = placeImage;
                    } else {
                        // 사진없을 때
                        newImage.src = 'https://via.placeholder.com/100x100/CCCCCC/FFFFFF?text=No+Image';
                    }

                    newP.appendChild(newImage);                   
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
    
    function getPlace() {
        let obj = document.getElementById("jj");
        let existingPs = obj.querySelectorAll('p');
        existingPs.forEach((p) => {
            p.remove();
        });

        let startIdx = (currentPagePlace - 1) * itemsPerPage;
        let endIdx = startIdx + itemsPerPage;

        fetch("https://api.odcloud.kr/api/15125431/v1/uddi:3f24f89a-940d-4512-88d7-80b993cd28b8?page=" + currentPagePlace + "&perPage=10&serviceKey=%2BUFeyGq0yCyRGAnfn2BZHmpxwulEWArLYaKEKRMZZSGW85K8Gxlkum5LSZjUcypheIifRSpj1kFDOTS3yFa5wQ%3D%3D")
            .then((response) => response.json())
            .then((data) => {
                data.data.slice(startIdx, endIdx).forEach((place) => {
                    let newP = document.createElement("p");
                    let placeName = place['관광명소명'];
                    let placelatitude = place['위도'];
                    let placelongitude = place['경도'];
                    newP.innerHTML =  "<a href='#' onclick='addToTable(\"" + placeName +","+placelatitude +","+ placelongitude +"\")'>" + placeName + "</a>";
                    newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
                    newP.innerHTML += '<a href=\'https://map.kakao.com/link/map/' + placeName + ',' + placelatitude + ',' + placelongitude + '\'>지도 자세히보기</a>';

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

    	    let tableCell = document.getElementById("addSchedule");
    	    let placeArray = placeName.split(',');
    	    // 이름 추가
    	    tableCell.innerHTML = placeArray[0];
    	    
    	    // X 버튼 및 추가 정보를 담은 input 태그 추가
    	    tableCell.innerHTML += "<input type='hidden' value='" + placeArray[0] + "'>";
    	    tableCell.innerHTML += "<input type='hidden' value='" + placeArray[1] + "'>";
    	    tableCell.innerHTML += "<input type='hidden' value='" + placeArray[2] + "'>";
    	    tableCell.innerHTML += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' onclick='Xclose(this, \"" + placeArray[0] + "\");'>X</a>";

    	    // 이후 작업 수행 (panTo 함수 호출 등)
    	 //   panTo(placeArray[0], placeArray[1], placeArray[2]);
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
	            //infowindows[i].setMap(null);
	
	            // markers 배열에서 해당하는 i번째 값을 제거
	            markers.splice(i, 1);
	            // infowindows 배열에서 해당하는 i번째 값을 제거
	
	            break;
	        }
	    }
	    addRankToTable('dragDropTable');
	}



</script>

</head>
<body>
<button id="rest" onclick="getRest()">음식점</button>
<button id="tour" onclick="getTour()">관광지</button>
<button id="food" onclick="getFood()">맛집 추천</button>
<button id="place" onclick="getPlace()">명소 추천</button>

<div id="restBtn">
<button onclick="prevPageRest()">Previous</button>
<b id=pageIndexRest></b>
<button onclick="nextPageRest()">Next</button>
</div>

<div id="foodBtn">
<button onclick="prevPage()">Previous</button>
<b id=pageIndex></b>
<button onclick="nextPage()">Next</button>
</div>

<div id="placeBtn">
<button>Previous</button>
<b id=pageIndexPlace></b>
<button onclick="nextPagePlace()">Next</button>
</div>

<div id="tourBtn">
<button onclick="prevPageTour()">Previous</button>
<b id=pageIndexTour></b>
<button onclick="nextPageTour()">Next</button>
</div>


<form name="frm">
    제목 <input type="text" name="scheduleSubject"> <br>
    기간 <input id="startDate" type="date" name="scheduleStartDate"> ~ <input id="endDate" type="date" name="scheduleEndDate">
    <a href="javascript:createPeriod()">기간등록</a>
    <br>
    공개여부
    <select name="scheduleShareYN">
        <option value="Y">예</option>
        <option value="N">아니요</option>
    </select>
    <input id="write" type="button" value="글쓰기" onclick="goWrite()"> <br>

<div id="totaltbl">

<div id="jj"></div>
	<div id = "scheduletbl">
	<table id="timetbl">
	        <thead><th class="fixed">시간</th></thead>
	        <tbody>
	            <tr class="fixed_1"><td></td></tr>
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
		<table>
			<thead>
				<th class="fixed" style="height:50px; width:1200px">기간을 등록해주세요 ! </th>
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
<div id="map" style="width:500px;height:400px;"></div>

</div>

</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24905b65af4a0e247d268677c3972e9d&libraries=services"></script>
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
</body>
</html>