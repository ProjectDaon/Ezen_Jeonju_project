<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sightsList</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");

});
</script>
<div id="headers"></div>

<br><br><br>
<br><br><br>
<br><br><br>

<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>조회수</th>
			<th>리뷰수</th>
			<th>좋아요수</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="cv" items="${cvlist}">
		<tr>
			<td>${cv.cidx}</td>
			<td><a href="${pageContext.request.contextPath}/contents/contentsArticle.do?cidx=${cv.cidx}">${cv.contentsSubject}</a></td>
			<td>${cv.contentsViewCount}</td>
			<td>${cv.contentsReviewCount}</td>
			<td>♥</td>
		</tr>
		</c:forEach>
	</tbody>
</table>

<a href="<%=request.getContextPath()%>/contents/contentsWrite.do">글쓰기</a>
</body>
</html>