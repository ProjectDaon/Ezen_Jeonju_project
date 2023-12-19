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

    #schedulePeriod{
        text-align: center;
    }

    #timetbl{
       width:50px; 
    }

    #scheduletbl{
        display: flex; 
        flex-direction: row;
        width: 1200px;
        height: 800px;
        overflow: scroll;
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


</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
    <!--전주 음식점 api 불러오는 함수-->
    function getJeonju() {
        let obj = document.getElementById("jj");
        let existingPs = obj.querySelectorAll('p');
        existingPs.forEach((p) => {
            p.remove();
        });
        
        fetch("https://api.odcloud.kr/api/15076735/v1/uddi:98edad48-0892-4621-8741-cdff64f99c79?page=1&perPage=10&serviceKey=%2BUFeyGq0yCyRGAnfn2BZHmpxwulEWArLYaKEKRMZZSGW85K8Gxlkum5LSZjUcypheIifRSpj1kFDOTS3yFa5wQ%3D%3D")
            .then((response) => response.json())
            .then((data) => {
                data.data.forEach((place) => {
                    let newP = document.createElement("p");
                    let placeName = place['식당명'];
                    newP.innerHTML = "<a href='#' onclick='addToTable(\"" + placeName + "\")'>" + placeName + "</a>";
                    obj.appendChild(newP);
                });
            });
    }

    function getHotplace(){
        let obj = document.getElementById("jj");
        let existingPs = obj.querySelectorAll('p');
        existingPs.forEach((p) => {
            p.remove();
        });

        fetch("https://api.odcloud.kr/api/15125431/v1/uddi:3f24f89a-940d-4512-88d7-80b993cd28b8?page=1&perPage=10&serviceKey=%2BUFeyGq0yCyRGAnfn2BZHmpxwulEWArLYaKEKRMZZSGW85K8Gxlkum5LSZjUcypheIifRSpj1kFDOTS3yFa5wQ%3D%3D")
            .then((response) => response.json())
            .then((data) => {
                data.data.forEach((place) => {
                    let newP = document.createElement("p");
                    let placeName = place['관광명소명'];
                    newP.innerHTML = "<a href='#' onclick='addToTable(\"" + placeName + "\")'>" + placeName + "</a>";
                    obj.appendChild(newP);
                });
            });

    }

    //음식점이름 클릭하면 테이블 cell로 음식점 이름이동
    function addToTable(restaurantName) {
        let tableCell = document.getElementById("addSchedule");
        tableCell.innerHTML = restaurantName;
    }
</script>
<script>

	function addDays(dateString, days) {
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
            
            $(td).attr("name", addDays($('#startDate').val(), k) + "_" + hour);
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

        if (startDatePeriod == "") {
            alert("날짜 설정을 해주세요");
            return;
        }else{
            if(endDatePeriod == ""){
                endDatePeriod = startDatePeriod;
            }
        }

        if (startDate > endDate) {
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
    
</script>
</head>
<body>

<script>


    <!-- 글 작성 함수 -->
    
    function goWrite() {
        var fm = document.frm;
        var tbodyCells = document.querySelectorAll('#dragDropTable tbody td');
        var tourCourseTime 
        var tourCourseDate 
        var jsonArray 	= new Array();
    	//각 td 엘리먼트를 순회하면서 텍스트가 있는지 확인
    	tbodyCells.forEach(function(td) {
    	 // 텍스트가 있는 경우
    	 if ((td.textContent.trim() !== "") &&(td.textContent !== "장소를 누르시고 원하는 시간대에 드래그하세요")) {
    	     // 원하는 작업 수행
    	     console.log('td 엘리먼트:', td.textContent);

    	     	var jsonObj = new Object();
	    		var tourCoursePlace = td.textContent;
	    	    var underscoreIndex = td.getAttribute('name').indexOf("_");
	    	    var tourCourseDate = td.getAttribute('name').substring(0, underscoreIndex);
	    	    var tourCourseTime = td.getAttribute('name').substring(underscoreIndex+1); 
    	      
	    	    console.log('장소: ' + td.textContent + ' 날짜: ' +  tourCourseDate + ' 시간: ' + tourCourseTime);
    	 }
    	});
    
    	

       if (fm.scheduleSubject.value == "") {
            alert('제목을 입력해주세요');
            fm.scheduleSubject.focus();
           return;
       }
        else if (fm.scheduleStartDate.value == "") {
            alert('날짜를 입력해주세요');
           fm.scheduleStartDate.focus();
           return;
       }
       
        
       fm.action = "<%=request.getContextPath()%>/schedule/scheduleWriteAction.do";
       fm.method = "post";
       fm.submit();
      return;
   }
    
</script>

<form name="frm">
    제목 <input type="text" name="scheduleSubject"> <br>
    기간 <input id="startDate" type="date" name="scheduleStartDate"> ~ <input id="endDate" type="date" name="scheduleEndDate">
    <a href="javascript:createPeriod()">기간등록</a>
    <br>
    공개여부
    <select name="scheduleShare">
        <option value="Y">예</option>
        <option value="N">아니요</option>
    </select>
    <input id="write" type="button" value="글쓰기" onclick="goWrite()"> <br>

<table>
    <tr id="schedulePeriod" value="">
        <!-- 기간 표시 엘리먼트 -->
    </tr>
</table>

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

<div id="table-container"></div>
</div>
</form>
<button onclick="getJeonju()">음식점</button>
<button onclick="getHotplace()">명소</button>
<div id="jj"></div><br>


</body>
</html>