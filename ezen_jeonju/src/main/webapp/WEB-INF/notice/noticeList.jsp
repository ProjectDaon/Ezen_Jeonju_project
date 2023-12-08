<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>카테고리</th>
			<th>제목</th>
			<th>작성일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="nv" items="${nvlist}">
		<tr>
			<td>${nv.nidx}</td>
			<td>${nv.noticeCategory}</td>
			<td><a href="${pageContext.request.contextPath}/notice/noticeContents.do?nidx=${nv.nidx}">${nv.noticeSubject}</a></td>
			<td>${nv.noticeWriteday}</td>
		</tr>
		</c:forEach>
	</tbody>
</table>
</body>
</html>