<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 조회</title>
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

nidx: ${nv.nidx} <br>
카테고리: ${nv.noticeCategory} <br>
제목: ${nv.noticeSubject} <br>
작성일: ${nv.noticeWriteday} <br>
내용: ${nv.noticeArticle} <br>
첨부파일: ${nv.noticeFileName} <br>
파일경로: ${nv.noticeFilePath} <br>
해시태그:
<c:forEach var="item" items="${hashtag}">
${item.value}
</c:forEach>

<div>
<a href="${pageContext.request.contextPath}/notice/noticeModify.do?nidx=${nv.nidx}">수정하기</a>
</div>
</body>
</html>