<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[EZEN-JEONJU]배너 목록</title>
<link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/images/favicon-32x32.png">
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/registerMainImages.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<!-- SweetAlert2 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.all.min.js"></script>
<style type="text/css">
.swal2-popup .swal2-content {
    font-weight: bold;
}
</style>
</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	window.history.replaceState({}, document.title, 'http://192.168.0.30:8080');
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");
	
});

function vannersDelete(mpidx){
<%-- 	var isConfirmed = confirm('등록된 배너를 삭제하겠습니까?');
	if (isConfirmed) {
		var fm = document.frm;
		fm.action ="<%=request.getContextPath()%>/main/mainVannerDeleteAction.do?mpidx="+mpidx;
	    fm.method = "post";
	    fm.submit();
	    return;
	} --%>
	
	swal({
		title: "",
		text: "등록된 배너를 삭제하시겠습니까?",
		type: "question",
		showCancelButton: true,
		confirmButtonText: "Yes",
		cancelButtonText: "Cancel"
	}). then ((result) => {
		if(result.value){
			swal(
				'',
				'<b style="font-weight:bold;">배너가 삭제되었습니다.</b>',
				'success'
			).then(function(){
				var fm = document.frm;
				fm.action ="<%=request.getContextPath()%>/main/mainVannerDeleteAction.do?mpidx="+mpidx;
			    fm.method = "post";
			    fm.submit();
				
			    return;	
			});
		}
	});
}

</script>
<div id="headers"></div>

<body>
<form name="frm">
	<div class="contents">
		<div class="inner-wrap">
			<div class="category">
				<ul>
					<li><a href="${pageContext.request.contextPath}/mypage/userMypage.do">신고목록</a></li>
					<li><strong><a href="${pageContext.request.contextPath}/main/vannerRegisterList.do">메인배너 관리</a></strong></li>
				</ul>
			</div>
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
								<td><a href="javascript:vannersDelete(${mpv.mpidx})" class="registeredVannersDelete" >배너 삭제</a></td>
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
</body>
</html>