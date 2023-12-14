<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.ezen_jeonju.myapp.domain.NoticeVo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
NoticeVo nv = (NoticeVo)request.getAttribute("nv");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>공지사항 수정</title>
<link rel="stylesheet" href="../css/navbar.css">
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="../summernote/summernote-ko-KR.js"></script>

</head>
<body>
<script type="text/javascript">
$(document).ready( function() {
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");

});
</script>
<div id="headers"></div>

<br><br><br>
<br><br><br>
<br><br><br>

<script>

$(document).ready(function(){
	$("#noticeCategory").change(function() {
		$("#noticeCategorySelected").val($(this).val());
	});
});

function goModify(){

	var fm = document.frm; //문서객체안의 폼객체이름
	
	if(fm.noticeCategorySelected.value ==""){
		alert("카레고리를 선택하세요.");
		fm.contentsSubject.focus();
		return;
	}else if (fm.noticeSubject.value ==""){
		alert("제목을 입력하세요.");
		fm.contentsArticle.focus();
		return;
	}else if (fm.noticeArticle.value ==""){
		alert("내용을 입력하세요.");
		fm.contentsArticle.focus();
		return;}		
/*  	}else if (fm.pwd.value ==""){
		alert("비밀번호를 입력하세요");
		fm.pwd.focus();
		return;		
	} */
 	//처리하기위해 이동하는 주소
	fm.action ="<%=request.getContextPath()%>/notice/noticeModifyAction.do";  
	fm.method = "post";  //이동하는 방식  get 노출시킴 post 감추어서 전달
	fm.enctype= "multipart/form-data";
	fm.submit(); //전송시킴
	return;
}

function goDelete(){
	alert("공지사항을 삭제하시겠습니까?");
	
	var fm = document.frm; //문서객체안의 폼객체이름
	var nidx = fm.nidx.value;
	var category = fm.noticeCategorySelected.value;
 	//처리하기위해 이동하는 주소
	fm.action ="<%=request.getContextPath()%>/notice/noticeDeleteAction.do?nidx="+nidx+"&category="+category;  
	fm.method = "post";  //이동하는 방식  get 노출시킴 post 감추어서 전달
	fm.submit(); //전송시킴
	return;
}
</script>
<div class="panel-heading">공지사항 수정하기</div>
	<div class="panel-body">
		<form name="frm">
		<input type="hidden" name="nidx" value="<%=nv.getNidx()%>">
			<div class="form-group">
				<label>카테고리</label>
				<input type="text" id="noticeCategorySelected" name="noticeCategorySelected" value="<%=nv.getNoticeCategory()%>">
				<select id="noticeCategory" name="noticeCategory">
					<option value="">선택</option>
					<option value="공연">공연</option>
					<option value="전시">전시</option>
					<option value="축제">축제</option>
					<option value="행사">행사</option>
				</select>
			</div> 
			<div>
				<label>제목</label>
				<input type="text" name="noticeSubject" value="<%=nv.getNoticeSubject()%>">
			</div>
			<textarea id="summernote" name="noticeArticle"><%=nv.getNoticeArticle() %></textarea>

<!-- 	<tr>
		<th>비밀번호</th>
		<td>
		<input type="password" name="pwd">		
		</td>
		</tr> -->		
			<input type="file" name="noticeFileName">
			<input type="button" value="수정" onclick="goModify()">
			<input type="button" value="삭제" onclick="goDelete()">
		</form>
	<script>
	$(document).ready(function() {
	  $('#summernote').summernote({
	    lang: 'ko-KR' // default: 'en-US'
	  });
	});
	</script>
	</div>
</body>
</html>