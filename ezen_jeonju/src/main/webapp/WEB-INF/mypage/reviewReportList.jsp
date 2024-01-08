<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reviewReportList.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("${pageContext.request.contextPath}/nav/nav.jsp");
	$('#footers').load("${pageContext.request.contextPath}/nav/footer.jsp");
	
	reportList();
});

function reportList(){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/reviewReport/reportListGet.do",
		dataType : "json",
		cache : false,
		success : function(data){
			reportListPrint(data.list);
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
}

function reportListPrint(data){
	var txt = "<table><thead><tr><th>No</th><th>신고자</th><th>피신고자</th><th>게시글</th><th>신고사유</th>"
			+ "<th>댓글내용</th><th>신고일자</th><th>처리</th></tr></thead><tbody>";
	$(data).each(function(i){
		txt = txt + "<tr><td>"+(i+1)+"</td><td>"+this.reporter+"</td>"
			+ "<td>"+this.reported+"</td>"
			+ "<td>"+this.contentsSubject+"</td>"
			+ "<td>"+this.reviewReportReason+"</td>"
			+ "<td style='text-align:left; width:835px;'>"+this.reviewArticle+"</td>"
			+ "<td>"+this.reviewReportDate+"</td>"
			+ "<td><button onclick='reportCancel("+this.rridx+")'>반려</button>"
			+ "<button onclick='reviewDelete("+this.ridx+")'>삭제</button></td></tr>";
	});
	txt = txt + "</tbody></table>";
	$('#reportList').html(txt);
}

function reportCancel(rridx){
	if(!confirm("신고를 반려하시겠습니까?")){
		return false;
	}
	
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/reviewReport/reportCancel.do",
		data: {
			"rridx": rridx
		},
		dataType : "json",
		cache : false,
		success : function(data){
			alert(data.txt);
			reportList();
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
}

function reviewDelete(ridx){
	if(!confirm("리뷰를 삭제하시겠습니까?")){
		return false;
	}
	
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/reviewReport/reviewDelete.do",
		data: {
			"ridx": ridx
		},
		dataType : "json",
		cache : false,
		success : function(data){
			alert(data.txt);
			reportList();
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
}
</script>
<div id="headers"></div>
<div class="contents">
	<div class="category">
		<ul>
			<li><strong><a href="${pageContext.request.contextPath}/mypage/userMypage.do">신고목록</a></strong></li>
			<li>메인배너 설정</li>
		</ul>
	</div>
	<div class="top-title">
		<h3>신고목록</h3>
	</div>
	<div id="reportList" class="reportList">
	</div>
</div>
<div id="footers"></div>
</body>
</html>