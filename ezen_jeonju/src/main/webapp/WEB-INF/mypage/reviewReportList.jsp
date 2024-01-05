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
<tr>
	<th>rridx</th>
	<th>ridx</th>
	<th>신고자</th>
	<th>피신고자</th>
	<th>게시글</th>
	<th>댓글내용</th>
	<th>신고사유</th>
	<th>신고일자</th>
</tr>
<c:forEach var="rrd" items="${reportList}">
	<tr>
	<td>${rrd.rridx}</td>
	<td>${rrd.ridx}</td>
	<td>${rrd.reporter}</td>
	<td>${rrd.reported}</td>
	<td>${rrd.contentsSubject}</td>
	<td>${rrd.reviewArticle}</td>
	<td>${rrd.reviewReportReason}</td>
	<td>${rrd.reviewReportDate}</td>
	</tr>
</c:forEach>
</table>
</body>
</html>