<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>

<style>
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

.paging a.select {
    background: #333;
    color: #fff;
    border: 1px solid #333;
}

</style>

</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	$('#headers').load("../nav/nav.jsp");

});
</script>
<div id="headers"></div>

<br><br><br>
<br><br><br>
<br><br><br>
<br><br><br>

<h3>공지</h3>
<br>

<form name="frm" method="get">
<div class="filter">
<input type = hidden name="searchType" value="noticeCategory">
<button type="submit" name="keyword" value="">전체</button>
<button type="submit" name="keyword" value="공연">공연</button>
<button type="submit" name="keyword" value="전시">전시</button>
<button type="submit" name="keyword" value="축제">축제</button>
<button type="submit" name="keyword" value="행사">행사</button>
</div>
<c:set var="keyword" value="${pm.scri.keyword}" />
<c:set var="parm" value="&searchType=${pm.scri.searchType}&keyword=${pm.scri.keyword}" />
</form>

<br>

<form action="">
<div class="search">
	<select name="searchType">
		<option value="noticeSubject" <%if(session.getAttribute("searchType") != null && session.getAttribute("searchType").equals("noticeSubject")) {%> selected <%}%>>제목</option>
		<option value="noticeArticle" <%if(session.getAttribute("searchType") != null && session.getAttribute("searchType").equals("noticeArticle")) {%> selected <%}%>>내용</option>
	</select>
	<input type="text" name="keyword" <%if(session.getAttribute("keyword") != null) {%>
	value="<%= session.getAttribute("keyword") %>"
	<%}%>>
	<!-- <button type="button" id="searchBtn">검색</button> -->
	<button type="submit" name="sbt">검색</button>
</div>
<c:set var="keyword" value="${pm.scri.keyword}" />
<c:set var="parm" value="&searchType=${pm.scri.searchType}&keyword=${pm.scri.keyword}" />
</form>

<div class="totalCount">
<span style="font-weight:bold;">전체
<i style="color:red;">${pm.totalCount}</i>
건</span>
</div>

<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>카테고리</th>
			<th>제목</th>
			<th>작성일</th>
			<th>이미지</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="nv" items="${nvlist}">
		<tr>
			<td>${nv.nidx}</td>
			<td>${nv.noticeCategory}</td>
			<td><a href="${pageContext.request.contextPath}/notice/noticeContents.do?nidx=${nv.nidx}">${nv.noticeSubject}</a></td>
			<td>${nv.noticeWriteday}</td>
			<td><a href="${pageContext.request.contextPath}/notice/noticeContents.do?nidx=${nv.nidx}"><img src="${pageContext.request.contextPath}/images/망고.jpg"></a></td>
		</tr>
		</c:forEach>
	</tbody>
</table>

<a href="<%=request.getContextPath()%>/notice/noticeWrite.do">글쓰기</a>

<div class="paging">
<c:if test="${pm.prev == true}">
<a class="pagePreview" href = "${pageContext.request.contextPath}/notice/noticeList.do?page=${pm.startPage-1}">
이전
</a>
</c:if>
<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1">
<a class="pageNumber" href="${pageContext.request.contextPath}/notice/noticeList.do?page=${i}${parm}">${i}</a>
</c:forEach>
<c:if test="${pm.next == true && pm.endPage>0}">
<a class="pageNext" href = "${pageContext.request.contextPath}/notice/noticeList.do?page=${pm.endPage+1}">
다음
</a>
</c:if>
</div>
</body>
</html>