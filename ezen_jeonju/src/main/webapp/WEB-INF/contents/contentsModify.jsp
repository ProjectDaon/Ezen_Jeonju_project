<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="com.ezen_jeonju.myapp.domain.ContentsVo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%> 
<%
ContentsVo cv = (ContentsVo)request.getAttribute("cv");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>컨텐츠 수정</title>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/contentsModify.css">
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
		return;
	}		
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

function readURL(input) {
	if (input.files && input.files[0]) {
	  var reader = new FileReader();
	  reader.onload = function(e) {
	    document.getElementById('preview').src = e.target.result;
	  };
	  reader.readAsDataURL(input.files[0]);
	} else {
	  document.getElementById('preview').src = "";
	}
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
					<option value="<%=cv.getContentsCategory()%>">선택</option>
					<option value="명소">명소</option>
					<option value="음식">음식</option>
				</select>
			</div> 
			<div>
				<label>제목</label>
				<input type="text" name="contentsSubject" value="<%=cv.getContentsSubject()%>"><br>
				<script src="https://unpkg.com/@yaireo/tagify"></script>
				<!-- 폴리필 (구버젼 브라우저 지원) -->
				<script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
				<link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />
				
				태그<input name='contentsHashtag'>
				
				<script>
				    const input = document.querySelector('input[name=contentsHashtag]');
				    var tags = '${values}';
				    input.value=tags;
				    let tagify = new Tagify(input); // initialize Tagify
				    
				    // 태그가 추가되면 이벤트 발생
				    tagify.on('add', function() {
				      console.log(tagify.value); // 입력된 태그 정보 객체
				    })
				</script>
			</div>
			<textarea id="summernote" name="contentsArticle"><%=cv.getContentsArticle() %></textarea>
   		 	<div class="uploadedFile">
 				<span>기존 이미지</span>
   				<img width="200" src="<spring:url value='/img/contents/${af.storedFilePath}'/>"/>
   		 	</div>
			<div id="customFileUpload">
        		<input type="file" name="uploadFileName" id="uploadFile" onchange="readURL(this);" value="">
       			<label for="uploadFile">변경할 메인사진</label>
       			<img id="preview" width="200" />
   		 	</div>
   		 	<input type="hidden" name="storedFile" value="${af.storedFilePath}">
   		 	<input type="hidden" name="storedThumbnail" value="${af.thumbnailFilePath}">
   		 	<input type="hidden" name="aidx" value="${af.aidx}">
	<script>
	$(document).ready(function() {
	  $('#summernote').summernote({
	    lang: 'ko-KR' // default: 'en-US'
	  });
	});
	</script>
	
	<br>
	<!-- Map Section -->
	<input type="hidden" id="contentsLatitude" name="contentsLatitude" value="${cv.contentsLatitude}">
	<input type="hidden" id="contentsLongitude" name="contentsLongitude" value="${cv.contentsLongitude}">
	</form>
	<div class="map_wrap">
		<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
	
		<div id="menu_wrap" class="bg_white">
			<div class="option">
				<div>
					<form onsubmit="searchPlaces(); return false;">
					 키워드 : <input type="text" value="${cv.contentsSubject}" id="keyword" size="15"> 
					<button type="submit">검색하기</button> 
					</form>
				</div>
			</div>
			<hr>
			<ul id="placesList"></ul>
				<div id="pagination"></div>
		</div>
		<div class="hAddr">
			<span class="title">지도중심기준 행정동 주소정보</span>
			<span id="centerAddr"></span>
		</div>
	</div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dbee45d6252968c16f0f651bb901ef42&libraries=services"></script>
	<script src="../js/contentsModify-map.js"></script>
	
		<input type="button" value="수정" onclick="goModify()">
		<input type="button" value="삭제" onclick="goDelete()">
	</div>		
</body>
</html>