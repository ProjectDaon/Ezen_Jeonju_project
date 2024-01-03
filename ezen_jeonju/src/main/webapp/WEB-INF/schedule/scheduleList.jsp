<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.ezen_jeonju.myapp.domain.ScheduleRootVo" %>    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.paging {
    text-align: center;
    margin: 30px 0 0;
    font-size: 0;
    clear: both;
}


.paging a {
    display: inline-block;
    text-align: center;
    min-width: 44px;
    line-height: 44px;
    font-size: 16px;
    vertical-align: middle;
    border: 1px solid #c9c9c9;
    margin: 0 1px;
}

.paging a:hover {
    background: #333;
    color: #fff;
    border: 1px solid #333;
}

.pageNumber.active {
    background: #333;
    color: #fff;
    border: 1px solid #333;
}
</style>
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
		<a href="${pageContext.request.contextPath}/schedule/scheduleContents.do?sidx=${sv.sidx}">
		${sv.scheduleSubject}
		</a>					
		</td>
		<td>${sv.scheduleViewCount}</td>
		<td>${sv.scheduleWriteday}</td>
		</tr>
	</c:forEach>
</tbody>	
</table>	
    <a href="<%=request.getContextPath()%>/schedule/scheduleWrite.do">여행일정 만들기</a>
    <div class="paging">
			<c:if test="${pm.prev == true}">
				<a class="pagePreview" href = "${pageContext.request.contextPath}/schedule/scheduleList.do?page=${pm.startPage-1}">
				<ion-icon name="chevron-back-outline"></ion-icon>
				</a>
			</c:if>
			<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1">
				<c:choose>
				<c:when test="${i eq pm.cri.page}">
					<a class="pageNumber active" href="${pageContext.request.contextPath}/schedule/scheduleList.do?page=${i}">${i}</a>
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
</body>
</html>