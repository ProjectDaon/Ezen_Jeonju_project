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

</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	window.history.replaceState({}, document.title, 'http://localhost:8080');
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");
	$('#footers').load("../nav/footer.jsp");
	
});

function vannersDelete(mpidx){
	var isConfirmed = confirm('등록된 배너를 삭제하겠습니까?');
	if (isConfirmed) {
		var fm = document.frm;
		fm.action ="<%=request.getContextPath()%>/main/mainVannerDeleteAction.do?mpidx="+mpidx;
	    fm.method = "post";
	    fm.submit();
	    return;
	}
};

</script>
<div id="headers"></div>

<body>
<form name="frm">
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
					<tbody style="text-aling:center;">
						<c:forEach var="mpv" items="${mpvlist}">
							<tr>
								<td>${mpv.mainPageSequence}</td>
								<td class="registeredVannersSubject"><a class="contentsBtn" href="${pageContext.request.contextPath}/main/mainVannerContents.do?mpidx=${mpv.mpidx}">${mpv.mainPageSubject}</a></td>
								<td class="registeredVannersDay">${mpv.fileUploadDay}</td>
								<td><a href="#" class="registeredVannersDelete" onclick="vannersDelete(${mpv.mpidx})">배너 삭제</a></td>
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
				<%
					String message = (String)request.getAttribute("message");
					if (message != null && !message.isEmpty()) {
					%>
					<script>
					    alert("<%= message %>");
					</script>
					<%
					}
				%>
			</div>
		</div>
	</div>
</form>
<div id="footers"></div>
</body>
</html>