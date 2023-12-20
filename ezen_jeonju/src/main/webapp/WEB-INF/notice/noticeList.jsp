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
a {
    text-decoration: none;
    color: #555;
}

.inner {
    position: relative;
    margin: 0 auto;
    width: 1300px;
    /* height: 100%; */
}

.innerwrap {
    max-width: 1300px;
    width: 100%;
    margin: 5% auto;
    padding : 0 5%;
    overflow: hidden;
    word-wrap: break-word;
}

h3 {
    font-weight: 500;
    text-align: center;
    font-size: 42px;
    color: #222;
    /* margin: unset; */
    line-height: normal;
}

.filter {
    width: 80%;
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    overflow: hidden;
    margin: 0 auto;
}

.filter button {
    display: inline-block;
    padding: 5px 20px;
    margin: 5px;
    font-size: calc(12px + 0.2vw);
    font-weight : bold;
    color: #FFA07A;
/*     background-color: #FFA07A;
    border: 1px solid #FFA07A;
    border-radius: 30px; */
    border-bottom : 2px solid #FFA07A;
    cursor: pointer;
}

.totalCount {
    padding: 15px 0;
    float: left;
}

.search {
    width: 28%;
    float: right;
    padding: 15px 0;
    width: auto;
    position: absolute;
    right: 13px;
}

.noticeCalendar {
    overflow: hidden;
    clear: both;
}

.noticeCalendar li {
    float: left;
    /* width: calc(33.33% - 23px); */
    margin: 0 44px 0 20px;
    height: auto;
}

.noticeCalendar li span {
    display: block;
    padding: 5px 8px;
    margin: 10px 0;
    background-color: #7F58AF;
    width: 77px;
    text-align: center;
    color: #fff;
    font-size: 15px;
    border-radius: 9px;
}

.noticeCalendar li p {
    font-size: 17px;
    color: #000;
    line-height: 1.5em;
    margin-bottom: 10px;
    font-weight: 500;
    /* height: 51px; */
    overflow: hidden;
}

.write {
    margin: 30px 0 0;
    padding: 15px 0;
    float: left;
    border-radius: 30px;
    background-color: #FFA07A;
    border: 1px solid #FFA07A;
    cursor: pointer;
}

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

<div class="innerwrap">
<h3>공지</h3>

<form name="frm" method="get">
<div class="filter">
<input type = hidden name="searchType" value="noticeCategory">
<button class="filterBtn" type="submit" name="keyword" value=""># 전체</button>
<button class="filterBtn" type="submit" name="keyword" value="공연"># 공연</button>
<button class="filterBtn" type="submit" name="keyword" value="전시"># 전시</button>
<button class="filterBtn" type="submit" name="keyword" value="축제"># 축제</button>
<button class="filterBtn" type="submit" name="keyword" value="행사"># 행사</button>
</div>
<c:set var="keyword" value="${pm.scri.keyword}" />
<c:set var="parm" value="&searchType=${pm.scri.searchType}&keyword=${pm.scri.keyword}" />
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
		</div>
	
		<div class="noticeCalendar">
			<ul id="noticeList">
			<c:forEach var="nv" items="${nvlist}">
				<li>
					<a href="${pageContext.request.contextPath}/notice/noticeContents.do?nidx=${nv.nidx}">
					<p class="imgwrap"><img src="${pageContext.request.contextPath}/images/2023BUSAN.jpg" style="width:312px; height:428px;">
					</p>
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
					<p class="writeday">${nv.noticeWriteday}</p>
					</a>
				</li>
			</c:forEach>
			</ul>
		</div>
		<div class="write">
			<a href="<%=request.getContextPath()%>/notice/noticeWrite.do" style="color:white; font-weight:bold;">글쓰기</a>
		</div>
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
	</div>
</div>
</body>
</html>