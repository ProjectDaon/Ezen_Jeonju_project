<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 조회</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/noticeContents.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" integrity="sha512-MV7K8+y+gLIBoVD59lQIYicR65iaqukzvf/nwasF0nqhPay5w/9lJmVM2hMDcnK1OnMGCdVK+iQrJ7lzPJQd1w==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	$('#headers').load("../nav/nav.jsp");
	$('#footers').load("../nav/footer.jsp");
});
</script>
<div id="headers"></div>

<br><br><br>
<br><br><br>
<br><br><br>
<div class="contentsWrap">
	<div class="contentsHeader">
		<input type="hidden" value="${nv.nidx}">
		<div class="title">
		<div class="category">${nv.noticeCategory}</div>
		<div class="subject">${nv.noticeSubject}</div>
		</div>
		<div class="hashtag">
			<c:forEach var="item" items="${hashtag}">${item.value}</c:forEach>
		</div>
		<div class="writeday">작성일 : ${nv.noticeWriteday}</div>
	</div>
	<div class="article">${nv.noticeArticle}</div>
	<div class="attachFile">
		<div class="attach">첨부파일</div> 
		<div class="fileName"><i class="fa fa-floppy-o" aria-hidden="true"></i>${af.originalFileName}</div>
	</div>
	<%-- 파일경로: ${nv.noticeFilePath} <br> --%>
	<%-- <img src="<spring:url value='/img/notice/${af.storedFilePath}'/>" /> --%>
	
	<div class="btn">
		<a href="${pageContext.request.contextPath}/notice/noticeModify.do?nidx=${nv.nidx}">수정하기</a>
		<a href="javascript:window.history.back();">목록</a>
	</div>
</div>
<div id="footers"></div>
</body>
</html>