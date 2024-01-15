<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/scheduleList.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 목록</title>
<style>

</style>
</head>
<body>
<script>
$(document).ready( function() {
	$('#headers').load("../nav/nav.jsp");
	$('#footers').load("../nav/footer.jsp");

});

</script>
<div id="headers"></div>
<div class="innerwrap">
<h3>일정 목록</h3>
<table border=1 style="width:100%">	
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
		<td class="subject"><strong>
		<a href="${pageContext.request.contextPath}/schedule/scheduleContents.do?sidx=${sv.sidx}">
		${sv.scheduleSubject}
		</a>
		</strong>					
		</td>
		<td>${sv.scheduleViewCount}</td>
		<td>${sv.scheduleWriteday}</td>
		</tr>
	</c:forEach>
</tbody>	
</table>
	<div class="write">	
    <a href="<%=request.getContextPath()%>/schedule/scheduleWrite.do">여행일정 만들기</a>
    </div>
    <div class="paging">
			<c:if test="${pm.prev == true}">
				<a class="pagePreview" href = "${pageContext.request.contextPath}/schedule/scheduleList.do?page=${pm.startPage-1}">
				<ion-icon name="chevron-back-outline"></ion-icon>
				</a>
			</c:if>
			<c:set var="nowpage" value="${pm.sscri.page/10+1}" />
			<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1">
				<c:choose>
				<c:when test="${i == (nowpage-(nowpage%1))}">
					<a class="pageNumberActive" href="${pageContext.request.contextPath}/schedule/scheduleList.do?page=${i}">${i}</a>
				</c:when>
				<c:otherwise>
					<a class="pageNumber" href="${pageContext.request.contextPath}/schedule/scheduleList.do?page=${i}">${i}</a>
				</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${pm.next == true && pm.endPage>0}">
				<a class="pageNext" href = "${pageContext.request.contextPath}/schedule/scheduleList.do?page=${pm.endPage+1}">
				<ion-icon name="chevron-forward-outline"></ion-icon>
				</a>
			</c:if>
	</div>
</div>	
	<div id="footers"></div>
</body>
</html>