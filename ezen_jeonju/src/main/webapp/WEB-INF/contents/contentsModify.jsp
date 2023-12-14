<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.ezen_jeonju.myapp.domain.ContentsVo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
ContentsVo cv = (ContentsVo)request.getAttribute("cv");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>컨텐츠 수정</title>
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
	$("#contentsCategory").change(function() {
		$("#contentsCategorySelected").val($(this).val());
	});
});

function goModify(){

	var fm = document.frm; //문서객체안의 폼객체이름
	
	if(fm.contentsCategorySelected.value ==""){
		alert("카레고리를 선택하세요.");
		fm.contentsSubject.focus();
		return;
	}else if (fm.contentsSubject.value ==""){
		alert("제목을 입력하세요.");
		fm.contentsArticle.focus();
		return;
	}else if (fm.contentsArticle.value ==""){
		alert("내용을 입력하세요.");
		fm.contentsArticle.focus();
		return;}		
/*  	}else if (fm.pwd.value ==""){
		alert("비밀번호를 입력하세요");
		fm.pwd.focus();
		return;		
	} */
 	//처리하기위해 이동하는 주소
	fm.action ="<%=request.getContextPath()%>/contents/contentsModifyAction.do";  
	fm.method = "post";  //이동하는 방식  get 노출시킴 post 감추어서 전달
	fm.enctype= "multipart/form-data";
	fm.submit(); //전송시킴
	return;
}

function goDelete(){
	alert("컨텐츠를 삭제하시겠습니까?");
	
	var fm = document.frm; //문서객체안의 폼객체이름
	var category = fm.contentsCategorySelected.value;
	var cidx = fm.cidx.value;
 	//처리하기위해 이동하는 주소
	fm.action ="<%=request.getContextPath()%>/contents/contentsDeleteAction.do?cidx="+cidx+"&category="+category;  
	fm.method = "post";  //이동하는 방식  get 노출시킴 post 감추어서 전달
	fm.submit(); //전송시킴
	return;
}
</script>
<div class="panel-heading">글 수정하기</div>
	<div class="panel-body">
		<form name="frm">
		<input type="hidden" name="cidx" value="<%=cv.getCidx()%>">
			<div class="form-group">
				<label>카테고리</label>
				<input type="text" id="contentsCategorySelected" name="contentsCategorySelected" value="<%=cv.getContentsCategory()%>">
				<select id="contentsCategory" name="contentsCategory">
					<option value="">선택</option>
					<option value="명소">명소</option>
					<option value="음식">음식</option>
<%--					<c:forEach var="cv" items="${courselist}">
					<option value="${cv.cidx}">${cv.c_name}</option>
					</c:forEach> --%>
				</select>
			</div> 
			<div>
				<label>제목</label>
				<input type="text" name="contentsSubject" value="<%=cv.getContentsSubject()%>">
			</div>
			<textarea id="summernote" name="contentsArticle"><%=cv.getContentsArticle() %></textarea>

<!-- 	<tr>
		<th>비밀번호</th>
		<td>
		<input type="password" name="pwd">		
		</td>
		</tr> -->		
			<input type="file" name="contentsFileName">
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