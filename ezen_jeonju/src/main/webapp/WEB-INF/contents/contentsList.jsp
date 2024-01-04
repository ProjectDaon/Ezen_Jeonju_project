<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>sightsList</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/contentsList.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("${pageContext.request.contextPath}/nav/nav.jsp");
	$('#footers').load("${pageContext.request.contextPath}/nav/footer.jsp");

});
</script>
<div id="headers"></div>
<c:choose>
	<c:when test="${category eq '명소'}">
		<c:set var="categoryEng" value="sight" />
	</c:when>
	<c:otherwise>
		<c:set var="categoryEng" value="food" />
	</c:otherwise>
</c:choose>
<c:set var="parm" value="&keyword=${pm.cscri.keyword}" />

<br><br><br>

<div class="innerwrap">
	<h3>${category}</h3>
</div>
<div class="inner">
	<div class="innerwrap">
		<div class="searchArray">
			<div class="totalCount">
				<span style="font-weight:bold;">총 게시물
				<i style="color:red;">${pm.totalCount}</i>
				건</span>
			</div>
		<form action="">
			<div class="search">
<!-- 				<select name="searchType"> -->
				<div class="searchGroup">
				<input name="keyword" class="searchinput" type="text" <%if(session.getAttribute("keyword") != null) { %> value="<%= session.getAttribute("keyword") %>" <%}%>>
				<button type="submit" class="sbt" name="sbt"><ion-icon name="search" class="searchBtnIcon"></ion-icon></button>
				</div>
			</div>
		</form>
		</div>
	
		<div class="contents-list">
			<ul>
			<c:forEach var="cv" items="${cv}">
				<li>
					<a href="${pageContext.request.contextPath}/contents/contentsArticle.do?cidx=${cv.cidx}">
					<p><img src="${pageContext.request.contextPath}/thumbnailLoading.do?aidx=${cv.aidx}" /></p>
					<p >${cv.contentsSubject}</p></a>
					<div class="contents-list-sub">
						<span><ion-icon name="eye-outline"></ion-icon>&nbsp;${cv.contentsViewCount}</span>&ensp;
						<span><ion-icon name="chatbox-ellipses-outline"></ion-icon>&nbsp;${cv.contentsReviewCount}</span>&ensp;
						<span><ion-icon name="heart-outline"></ion-icon>&nbsp;${cv.likecount}</span>
					</div>
				</li>
			</c:forEach>
			</ul>
		</div>
	</div>
	<div class="innerwrap">	
		<div class="write">
			<a href="<%=request.getContextPath()%>/contents/contentsWrite.do">글쓰기</a>
		</div>
		<div class="paging">
			<c:if test="${pm.prev == true}">
				<a class="pagePreview" href = "${pageContext.request.contextPath}/contents/${categoryEng}/contentsList.do?page=${pm.startPage-1}">
				이전
				</a>
			</c:if>
			<c:set var="nowpage" value="${pm.cscri.page/9+1}" />
			<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1">
			<c:choose>
			<c:when test="${i == (nowpage-(nowpage%1))}">
				<a class="pageNumber active" href="${pageContext.request.contextPath}/contents/${categoryEng}/contentsList.do?page=${i}${parm}">${i}</a>
			</c:when>
			<c:otherwise>
				<a class="pageNumber" href="${pageContext.request.contextPath}/contents/${categoryEng}/contentsList.do?page=${i}${parm}">${i}</a>
			</c:otherwise>
			</c:choose>
			</c:forEach>
			<c:if test="${pm.next == true && pm.endPage>0}">
			<a class="pageNext" href = "${pageContext.request.contextPath}/contents/${categoryEng}/contentsList.do?page=${pm.endPage+1}">
			다음
			</a>
			</c:if>
		</div>
	</div>
</div>
<div id="footers"></div>
</body>
</html>