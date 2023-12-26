<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
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
	
	#foodBtn, #placeBtn{
		
	display : none;
		
	} 
	
	#foodBtn.active,
	#placeBtn.active {
  
    display: inline-block;
  	}
	.customoverlay a{
		color : black;
		font-weight:bold;
	}

</style>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
    <!--전주 음식점 api 불러오는 함수-->
    let currentPageFood = 1;
    let currentPagePlace = 1;
    const itemsPerPage = 10;
    let perPage = 55;
    function getFood() {
        let obj = document.getElementById("jj");
        let existingPs = obj.querySelectorAll('p');
        existingPs.forEach((p) => {
            p.remove();
        });
		//api 가져올 갯수
        
        let startIdx = (currentPageFood - 1) * itemsPerPage;
        let endIdx = startIdx + itemsPerPage;

        fetch("https://api.odcloud.kr/api/15076735/v1/uddi:98edad48-0892-4621-8741-cdff64f99c79?page=" + currentPageFood + "&perPage="+perPage+"&serviceKey=%2BUFeyGq0yCyRGAnfn2BZHmpxwulEWArLYaKEKRMZZSGW85K8Gxlkum5LSZjUcypheIifRSpj1kFDOTS3yFa5wQ%3D%3D")
            .then((response) => response.json())
            .then((data) => {
            	
            	let List = "<ul>";
            	
                data.data.slice(startIdx, endIdx).forEach((place) => {
                    let newP = document.createElement("p");
                    let placeName = place['식당명'];
                    let placelatitude = place['식당위도'];
                    let placelongitude = place['식당경도'];
                    newP.innerHTML = "<a href='#' onclick='addToTable(\"" + placeName +","+placelatitude +","+ placelongitude +"\")'>" + placeName + "</a>";
                    newP.innerHTML += "&nbsp;&nbsp;&nbsp;"
                    newP.innerHTML += '<a href=\'https://map.kakao.com/link/map/' + placeName + ',' + placelatitude + ',' + placelongitude + '\'>지도 자세히보기</a>';

                    // newP.innerHTML += `<button onclick="panTo(${restaurant['식당위도']},${restaurant['식당경도']})">좌표이동</button>`;
                    obj.appendChild(newP);
                });
            });

        $('#pageIndex').text(currentPageFood +" / " + (Math.floor(perPage/itemsPerPage) +1) );
        $('#placeBtn').removeClass('active');
        $('#foodBtn').addClass('active');
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
            });

        $('#pageIndexPlace').text(currentPagePlace+" / 1");
        $('#foodBtn').removeClass('active');
        $('#placeBtn').addClass('active');
       
    }

    function nextPage() {
        if (currentPageFood > perPage/10) {
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

    function nextPagePlace() {
        if (currentPagePlace > 0) {
            alert('마지막 페이지입니다.');
        } else {
            currentPagePlace++;
            getPlace();
        }
        
    }
 
//X눌렀을 때 사라지게하기
    function Xclose(cell) {
        // 부모 노드인 <td>를 찾아서 삭제
    	  cell.parentNode.innerHTML = '';

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
		tableCell.innerHTML += "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' onclick='Xclose(this);'>X</a>"; 

        // 이후 작업 수행 (panTo 함수 호출 등)
        panTo(placeArray[0], placeArray[1], placeArray[2]);
    }

  

</script>

</head>
<body>

<button id="food" onclick="getFood()">음식점</button>
<button id= "place" onclick="getPlace()">명소</button>

<div id="foodBtn">
<button onclick="prevPage()">Previous</button>
<b id=pageIndex></b>
<button onclick="nextPage()">Next</button>
</div>

<div id="placeBtn">
<button onclick="prevPagePlace()">Previous</button>
<b id=pageIndexPlace></b>
<button onclick="nextPagePlace()">Next</button>
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


<table>
    <tr id="schedulePeriod" value="">
    	
        <!-- 기간 표시 엘리먼트 -->
    </tr>
</table>

<div id="totaltbl">

<div id="jj"></div>
	<div id = "scheduletbl">
	<table id="timetbl">
	        <thead><th>시간</th></thead>
	        <tbody>
	            <tr><td></td></tr>
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
				<th style="height:50px; width:1200px">기간을 등록해주세요 ! </th>
			<thead>
		</table>
	</div>
	</div>
</form>
<div id="map" style="width:500px;height:400px;"></div>

</div>

</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24905b65af4a0e247d268677c3972e9d"></script>
<script src="../js/scheduleWrite-map.js"></script>
<script type="text/javascript" src ="../js/scheduleWrite-dragDropTable.js"></script>

<script>
    <!-- 글 작성 함수 -->
    
    function goWrite() {
        var fm = document.frm;
        var tbodyCells = document.querySelectorAll('#dragDropTable tbody td');
        var tourCourseTime 
        var tourCourseDate 
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

	    	     	var tourCoursePlace = td.querySelector('input:nth-child(1)').value;
	    	        var tourCourseLatitude = td.querySelector('input:nth-child(2)').value;
	    	        var tourCourseLongitude = td.querySelector('input:nth-child(3)').value;
		    		  		
		    	    var underscoreIndex = td.getAttribute('name').indexOf("_");
		    	    tourCourseDate = td.getAttribute('name').substring(0, underscoreIndex);
		    	    tourCourseTime = td.getAttribute('name').substring(underscoreIndex+1); 
	    	          	    
					jsonObj.tourCourseDate = tourCourseDate;
					jsonObj.tourCourseTime = tourCourseTime;
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
	   
	 getFood();
	   
	   
});
   
</script>
</body>
</html>