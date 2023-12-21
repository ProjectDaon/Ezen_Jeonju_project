<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
    #scheduletbl{
        display: flex; 
        flex-direction: row;
        width: 1200px;
        height: 800px;
        overflow: scroll;
    }
	.scheduletbl th,tr,td{
		border: 1px solid black;
		border-collapse: collapse;
	}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function () {
	var sidx = ${sidx};
	getTourCourse(sidx);
    
});
function getTourCourse(sidx){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/schedule/getTourCourse.do",
		data : {
			"sidx" : sidx
		},
		dataType : "json",
		success : function(data){
			$(data).each(function(){
				
				var td_id = "#"+this.tourCourseDate+"_"+this.tourCourseTime;
				$(td_id).html(this.tourCoursePlace);
				
			});
		},
		error: function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}
</script>

</head>
<body>

<h1>일정 내용</h1>
		<table border=1 style="width:600px;">
		<tr>
		<th>제목</th>
		<td>${sv.scheduleSubject}</td>
		<th>기간</th>
		<td>${sv.scheduleStartDate}</td><td>${sv.scheduleEndDate}</td>
		<th>조회수</th>
		<td>${sv.scheduleViewCount}</td>
		</tr>
		</table>
		<br>
		<div class="scheduletbl" id = "scheduletbl">		
		<table id="timetbl">
        <thead>
        <tr>
        <th>시간</th>
        <c:forEach var="dl" items="${dateList}">
        	<th>${dl}</th>
        </c:forEach>
        <tr>
        </thead>
        <tbody>
        <c:forEach var="hour" begin="8" end="22">
		    <tr>
		    	<c:choose>
		    		<c:when test="${hour lt 10}">
		    			<td>0${hour}:00</td>
		    	 	</c:when>
		    	 	<c:otherwise>
		    			<td>${hour}:00</td>
		    	 	</c:otherwise>
		    	</c:choose>
		        
		        <c:forEach var="dl" items="${dateList}">
		        
		        	<td id="${dl}_${hour}"></td>
		        
		        </c:forEach>	
		    </tr>
		</c:forEach>

        </tbody>
		</table>	
		
</div>
</body>
</html>