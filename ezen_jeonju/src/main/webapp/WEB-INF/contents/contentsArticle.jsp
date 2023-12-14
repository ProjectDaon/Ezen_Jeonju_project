<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Article</title>
</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");

});
</script>
<div id="headers"></div>


cidx: ${cv.cidx} <br>
제목: ${cv.contentsSubject} <br>
작성일: ${cv.contentsWriteday} <br>
조회수: ${cv.contentsViewCount} <br>
내용: ${cv.contentsArticle} <br>
<%-- 첨부파일: ${cv.noticeFileName} <br>
파일경로: ${cv.noticeFilePath} <br> --%>


<a href="${pageContext.request.contextPath}/contents/contentsModify.do?cidx=${cv.cidx}">수정하기</a>
</body>
</html>