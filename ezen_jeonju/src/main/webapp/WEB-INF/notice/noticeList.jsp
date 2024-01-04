<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/noticeList.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
<script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>

</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	$('#headers').load("../nav/nav.jsp");
	$('#footers').load("../nav/footer.jsp");
	//filterBtn 초기화
	var keywordFilter = "${keywordFilter}";
	$('#keywordFilter').val(keywordFilter);
	// filterBtn active
	var activebtn = "button[name='keywordFilter'][value='"+keywordFilter+"']";
	$(activebtn).addClass("active");
	
});
</script>
<div id="headers"></div>

<br><br><br>

<div class="innerwrap">
<h3>공지</h3>

<form name="frm" method="get">
<div class="filter">
<input type = hidden name="searchType" value="noticeCategory">
<button class="filterBtn" type="submit" name="keywordFilter" value=""># 전체</button>
<button class="filterBtn" type="submit" name="keywordFilter" value="공연"># 공연</button>
<button class="filterBtn" type="submit" name="keywordFilter" value="전시"># 전시</button>
<button class="filterBtn" type="submit" name="keywordFilter" value="축제"># 축제</button>
<button class="filterBtn" type="submit" name="keywordFilter" value="행사"># 행사</button>
</div>
<c:set var="keywordFilter" value="${pm.scri.keywordFilter}" />
<c:set var="parm1" value="&searchType=${pm.scri.searchType}&keywordFilter=${pm.scri.keywordFilter}" />
</form>
</div>

<div class="inner">
	<div class="innerwrap">
		<div class="searchArray">
			<form action="">
			<div class="totalCount">
				<span style="font-weight:bold;">전체
				<i style="color:red;">${pm.totalCount}</i>
				건</span>
			</div>
			<div class="search">
				<select name="searchType">
					<!-- <option value="noticeCategory">카테고리</option> -->
					<option value="noticeSubject" <%if(session.getAttribute("searchType") != null && session.getAttribute("searchType").equals("noticeSubject")) {%> selected <%}%>>제목</option>
					<option value="noticeArticle" <%if(session.getAttribute("searchType") != null && session.getAttribute("searchType").equals("noticeArticle")) {%> selected <%}%>>내용</option>
				</select>
				<div class="searchGroup">
				<input type="text" name="keyword" id="keyword" <%if(session.getAttribute("keyword") != null) { %> value="<%= session.getAttribute("keyword") %>" <%}%>>
				<!-- <button type="button" id="searchBtn">검색</button> -->
				<button type="submit" class="sbt" name="sbt"><ion-icon name="search" class="searchBtnIcon"></ion-icon></button>
				</div>
			</div>
			<c:set var="keyword" value="${pm.scri.keyword}" />
			<c:set var="parm2" value="&searchType=${pm.scri.searchType}&keyword=${pm.scri.keyword}" />
			</form>
		</div>
	
		<div class="noticeCalendar">
			<ul id="noticeList">
			<c:forEach var="nv" items="${nvlist}">
				<li>
					<a href="${pageContext.request.contextPath}/notice/noticeContents.do?nidx=${nv.nidx}">
					<p class="imgwrap"><img style="width:300px; height:400px;" src="${pageContext.request.contextPath}/thumbnailLoading.do?aidx=${nv.aidx}" /></p>
					<c:choose>
						<c:when test="${nv.noticeCategory eq '공연'}">
							<span style="background-color: #FEB326;">${nv.noticeCategory}</span>
						</c:when>
						<c:when test="${nv.noticeCategory eq '전시'}">
							<span style="background-color: #E84D8A;">${nv.noticeCategory}</span>
						</c:when>
						<c:when test="${nv.noticeCategory eq '축제'}">
							<span style="background-color: #64C5EB;">${nv.noticeCategory}</span>
						</c:when>
						<c:otherwise>
							<span>${nv.noticeCategory}</span>
						</c:otherwise>
					</c:choose>
					<p class="subject">${nv.noticeSubject}</p>
					<p class="writeday" style="color:gray;">작성일 : ${nv.noticeWriteday}</p>
					</a>
				</li>
			</c:forEach>
			</ul>
		</div>
	</div>
	<div class="innerwrap">	
		<div class="write">
			<a href="<%=request.getContextPath()%>/notice/noticeWrite.do">글쓰기</a>
		</div>
		<div class="paging">
			<c:if test="${pm.prev == true}">
				<a class="pagePreview" href = "${pageContext.request.contextPath}/notice/noticeList.do?page=${pm.startPage-1}">
				<ion-icon name="chevron-back-outline"></ion-icon>
				</a>
			</c:if>
			<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}" step="1">
			<c:choose>
			<c:when test="${pm.scri.searchType eq 'noticeCategory'}">
				<c:choose>
				<c:when test="${i eq pm.cri.page}">
					<a class="pageNumber active" href="${pageContext.request.contextPath}/notice/noticeList.do?page=${i}${parm1}">${i}</a>
				</c:when>
				<c:otherwise>
					<a class="pageNumber" href="${pageContext.request.contextPath}/notice/noticeList.do?page=${i}${parm1}">${i}</a>
				</c:otherwise>
				</c:choose>
			</c:when>
			<c:otherwise>
				<c:choose>
				<c:when test="${i eq pm.cri.page}">
					<a class="pageNumber active" href="${pageContext.request.contextPath}/notice/noticeList.do?page=${i}${parm2}">${i}</a>
				</c:when>
				<c:otherwise>
					<a class="pageNumber" href="${pageContext.request.contextPath}/notice/noticeList.do?page=${i}${parm2}">${i}</a>
				</c:otherwise>
				</c:choose>
			</c:otherwise>
			</c:choose>
			</c:forEach>
			<c:if test="${pm.next == true && pm.endPage>0}">
				<a class="pageNext" href = "${pageContext.request.contextPath}/notice/noticeList.do?page=${pm.endPage+1}">
				<ion-icon name="chevron-forward-outline"></ion-icon>
				</a>
			</c:if>
		</div>
	</div>
</div>
<div id="footers"></div>
</body>
</html>