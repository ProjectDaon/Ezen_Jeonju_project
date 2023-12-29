<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배너 목록 페이지</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/registerMainImages.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<style>

h3 {
    font-size: 42px;
    font-weight: 500;
    margin: 0;
}

.contents {
    margin-top: 5%; 
    padding: 5%;
    text-align: center;
    display: flex;
}

.inner-wrap {
    position: relative;
    margin: 0 auto;
    width: 1500px;
    height: auto;
}

.title-wrap{
    margin-bottom: 30px;
}

.registeredVanners{
    text-align: center;
}

.registeredVannersTable {
    border-collapse :collapse;
    margin: 0 auto;
    padding-top: 1000px;
}

.registeredVannersTable th, td {
    border: 1px solid #000000;
    padding: 10px;
}

.registeredVannersSubject{
	width: 500px;
}

.registeredVannersDay{
	width: 200px
}

a {
    text-decoration: none;
    color: #000;
}


.registeredVannersSubject .registerBtn{
	border : 1px solid #000000;
	border-radius : 10px;
	padding: 2px;
}

</style>

</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");
});

$(document).ready( function() {
	
});
</script>
<div id="headers"></div>

<body>

<div class="contents">
	<div class="inner-wrap">
		<div class="title-wrap">
			<h3>등록된 배너 목록</h3>
		</div>
		<div class="registeredVanners">
			<table class="registeredVannersTable">
				<thead>
					<tr>
						<th>배너 순서</th>
						<th class="registeredVannersSubject">등록된 배너 제목</th>
						<th class="registeredVannersDay">배너 등록일</th>
						<th>삭제</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="mpv" items="${mpvlist}">
						<tr>
							<td>${mpv.mainPageSequence}</td>
							<td class="registeredVannersSubject"><a href="${pageContext.request.contextPath}/main/mainPageContents.do?mpidx=${mpv.mpidx}">${mpv.mainPageSubject}</a></td>
							<td class="registeredVannersDay">${mpv.fileUploadDay}</td>
							<td><button class="registeredVannersDelete" value="${mpv.mpidx}" onclick="vannersDelete()">배너 삭제</button></td>
						</tr>
					</c:forEach>
					<c:if test="${fn:length(mpvlist) > 0}">
					    <c:set var="lastItem" value="${mpvlist[fn:length(mpvlist) - 1]}" />
					    <tr>
					        <td>${lastItem.mainPageSequence + 1}</td>
					        <td class="registeredVannersSubject"><a class="registerBtn" href="<%=request.getContextPath()%>/main/vannerRegister.do?mainPageSequence=${lastItem.mainPageSequence + 1}">등록 하기</a></td>
					        <td class="registeredVannersDay"></td>
					        <td></td>
					    </tr>
					</c:if>
				</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>