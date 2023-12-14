<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ezen_jeonju.myapp.domain.ScheduleRootVo" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>일정 목록</h2>
<table border=1 style="width:600px">	
<thead>
		<tr>
		<th>No</th>
		<th>제목</th>
		<th>조회수</th>
		<th>작성일</th>
		</tr>
</thead>
<tbody>
	<c:forEach var="sv" items="${list}">	
		<tr>
		<td>${sv.sidx}</td>
		<td class="subject">
		
		${sv.scheduleSubject}
				
		</td>
		<td>${sv.scheduleViewCount}</td>
		<td>${sv.scheduleWriteday}</td>
		</tr>
	</c:forEach>
</tbody>	
</table>	
	
    <a href="<%=request.getContextPath()%>/schedule/scheduleWrite.do">여행일정 만들기</a>
</body>
</html>