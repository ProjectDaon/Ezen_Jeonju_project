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

</style>


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
		
		<table id="coursetbl" border="1" style="width:600px;">
     
		<tr>
		    <c:forEach var="tv" items="${tlist}">
		        <th>${tv.tourCourseDate}</th>
		    </c:forEach>
		</tr>

		</table>
</div>
</body>
</html>