<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>[EZEN-JEONJU]리뷰신고 리스트</title>
<link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/images/favicon-32x32.png">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/navbar.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/reviewReportList.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
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
	$('#headers').load("${pageContext.request.contextPath}/nav/nav.jsp");
	
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
			swal(
				'',
				'<b style="font-weight:bold;">통신오류 실패</b>',
				'error'
			);
		}		
	});
}

function reportListPrint(data){
	var txt = "<table><thead><tr><th>No</th><th>신고자</th><th>피신고자</th><th>게시글</th><th>신고사유</th>"
			+ "<th>리뷰내용</th><th>신고일자</th><th>처리</th></tr></thead><tbody>";
	$(data).each(function(i){
		txt = txt + "<tr><td>"+(i+1)+"</td><td>"+this.reporter+"</td>"
			+ "<td>"+this.reported+"</td>"
			+ "<td>"+this.contentsSubject+"</td>"
			+ "<td>"+this.reviewReportReason+"</td>"
			+ "<td style='text-align:left; width:835px;'>"+this.reviewArticle+"</td>"
			+ "<td>"+this.reviewReportDate+"</td>"
			+ "<td><button class='cancelBtn' onclick='reportCancel("+this.rridx+")'>반려</button>"
			+ "<button class='deleteBtn' onclick='reviewDelete("+this.rridx+")'>삭제</button></td></tr>";
	});
	txt = txt + "</tbody></table>";
	$('#reportList').html(txt);
}

function reportCancel(rridx){
	swal({
		title: "",
		text: "신고를 반려하시겠습니까?",
		type: "question",
		showCancelButton: true,
		confirmButtonText: "Yes",
		cancelButtonText: "Cancel"
	}). then ((result) => {
		if(result.value){
			$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath}/reviewReport/reportCancel.do",
				data: {
					"rridx": rridx
				},
				dataType : "json",
				cache : false,
				success : function(data){
					if(data.txt === "신고가 반려되었습니다."){
						swal(
							'',
							'<b style="font-weight:bold;">신고가 반려되었습니다.</b>',
							'success'
						);
						reviewList();
					}else{
						alert(data.txt);
					}
					reportList();
				},
				error : function(){
					swal(
						'',
						'<b style="font-weight:bold;">통신오류 실패</b>',
						'error'
					);
				}		
			});
		}
	});
}


function reviewDelete(rridx){
	swal({
		title: "",
		text: "리뷰를 삭제하시겠습니까?",
		type: "question",
		showCancelButton: true,
		confirmButtonText: "Yes",
		cancelButtonText: "Cancel"
	}). then ((result) => {
		if(result.value){
			$.ajax({
				type : "post",
				url : "${pageContext.request.contextPath}/reviewReport/reviewDelete.do",
				data: {
					"rridx": rridx
				},
				dataType : "json",
				cache : false,
				success : function(data){
					if(data.txt === "리뷰가 삭제되었습니다."){
						swal(
							'',
							'<b style="font-weight:bold;">리뷰가 삭제되었습니다.</b>',
							'success'
						);
						reviewList();
					}else{
						alert(data.txt);
					}
					reportList();
				},
				error : function(){
					swal(
						'',
						'<b style="font-weight:bold;">통신오류 실패</b>',
						'error'
					);
				}		
			});
		}
	});
}
</script>
<div id="headers"></div>
<div class="contents">
	<div class="category">
		<ul>
			<li><strong><a href="${pageContext.request.contextPath}/mypage/userMypage.do">신고목록</a></strong></li>
			<li><a href="${pageContext.request.contextPath}/main/vannerRegisterList.do">메인배너 관리</a></li>
		</ul>
	</div>
	<div class="top-title">
		<h3>신고목록</h3>
	</div>
	<div id="reportList" class="reportList">
	</div>
</div>
</body>
</html>