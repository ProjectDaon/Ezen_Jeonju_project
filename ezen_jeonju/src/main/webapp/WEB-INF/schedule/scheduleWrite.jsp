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
        width: 600px;
        height: 300px;
        overflow: scroll;
    }

    #timetbl td {
        text-align: center; /* Optional: center the text inside the td */
        height: 50px;
    }

    #timetbl th {
        text-align: center; /* Optional: center the text inside the td */
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
<script>
	<!--테이블 생성함수-->
    function createTable(parentElementId, columnCount) {
      
        // 테이블있으면 삭제하고 생성
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
        for (var j = 1; j <= 5; j++) {
            var trBody = document.createElement('tr');
            for (var k = 1; k <= columnCount; k++) {
                var td = document.createElement('td');
                td.textContent = "";

            // 바디 셀에 스타일 추가
            td.style.height = '50px';
            td.style.width = '300px';
            th.style.maxHeight = '50px';
            td.style.whiteSpace = 'nowrap';

        trBody.appendChild(td);
    }
    tbody.appendChild(trBody);
}
table.appendChild(tbody);

        // 부모 요소에 테이블 추가
        parentElement.appendChild(table);
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

        if (fm.scheduleSubject.value == "") {
            alert('제목을 입력해주세요');
            fm.scheduleSubject.focus();
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
    기간 <input id="startDate" type="date"> ~ <input id="endDate" type="date">
    <a href="javascript:createPeriod()">기간등록</a>
    <br>
    공개여부
    <select name="noticeCategory">
        <option value="Y">예</option>
        <option value="N">아니요</option>
    </select>
    <input type="button" value="글쓰기" onclick="goWrite()"> <br>

</form>

<table>
    <tr id="schedulePeriod" value="">
        <!-- 기간 표시 엘리먼트 -->
    </tr>
</table>

<div id = "scheduletbl">
<table id="timetbl">
        <thead><th>시간</th></thead>
        <tbody>
            <tr><td>08:00</td></tr>
            <tr><td>09:00</td></tr>
            <tr><td>11:00</td></tr>
            <tr><td>12:00</td></tr>
            <tr><td>13:00</td></tr>
        </tbody>
</table>


<div id="table-container"></div>
</div>
</body>
</html>