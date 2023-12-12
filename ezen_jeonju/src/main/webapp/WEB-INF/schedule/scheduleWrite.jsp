<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script>
function createPeriod(){
	
	let schedulePeriod = document.getElementById("schedulePeriod");

	let startDatePeriod = document.getElementById("startDate").value;

	let endDatePeriod = document.getElementById("endDate").value;

	let startDate = new Date(document.getElementById("startDate").value);

	let endDate = new Date(document.getElementById("endDate").value);

	if(startDate>endDate){
		alert("날짜 설정을 제대로 해주세요");
		return;
	}
	
	var timeDifference = endDate.getTime() - startDate.getTime(); // 밀리초 단위의 차이

	var dayDifference = timeDifference / (1000 * 60 * 60 * 24); 

	if(dayDifference > 7){
		alert("기간은 최대 일주일까지 가능합니다");
		return;
	}


	schedulePeriod.innerHTML=startDatePeriod + "~" + endDatePeriod;

}
</script>

</head>
<body>
<script>

function goWrite(){
	var fm = document.frm;
	
	if(fm.scheduleSubject.value==""){
		alert('제목을 입력해주세요');
		fm.scheduleSubject.focus();
		return;
	}


	fm.action ="<%=request.getContextPath()%>/schedule/scheduleWriteAction.do"; 
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
	</tr>
	<td></td>

</table>

</body>
</html>