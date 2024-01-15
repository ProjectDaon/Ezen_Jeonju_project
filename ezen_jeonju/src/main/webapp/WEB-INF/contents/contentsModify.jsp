<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>컨텐츠 수정</title>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/contentsWrite.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<script src="../summernote/summernote-ko-KR.js"></script>

<!-- 해시태그 source -->
<script src="https://unpkg.com/@yaireo/tagify"></script>
<!-- 폴리필 (구버젼 브라우저 지원) -->
<script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
<link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />
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
	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");
	
	$('#summernote').summernote({
	    lang: 'ko-KR' // default: 'en-US'
	});

});
</script>
<script>

$(document).ready(function(){
	$("#contentsCategory").change(function() {
		$("#contentsCategorySelected").val($(this).val());
	});
});

function goModify(){

	var fm = document.frm; //문서객체안의 폼객체이름
	
	if(fm.contentsCategorySelected.value ==""){
		swal(
			'',
			'<b style="font-weight:bold;">카테고리를 선택해주세요.</b>',
			'warning'
		);
		fm.contentsSubject.focus();
		return;
	}else if (fm.contentsSubject.value ==""){
		swal(
			'',
			'<b style="font-weight:bold;">제목을 입력해주세요.</b>',
			'warning'
		);
		fm.contentsArticle.focus();
		return;
	}else if (fm.contentsArticle.value ==""){
		swal(
			'',
			'<b style="font-weight:bold;">내용을 입력해주세요.</b>',
			'warning'
		);
		fm.contentsArticle.focus();
		return;
	}
	swal({
		title: "",
		text: "컨텐츠를 수정하시겠습니까?",
		type: "question",
		showCancelButton: true,
		confirmButtonText: "Yes",
		cancelButtonText: "Cancel"
	}). then ((result) => {
		if(result.value){
			swal(
				'',
				'<b style="font-weight:bold;">컨텐츠가 수정되었습니다.</b>',
				'success'
			).then(function(){
				fm.action ="${pageContext.request.contextPath}/contents/contentsModifyAction.do";  
				fm.method = "post";  //이동하는 방식  get 노출시킴 post 감추어서 전달
				fm.enctype= "multipart/form-data";
				fm.submit(); //전송시킴
				return;
			});
		}
	});
}

function goDelete(){
	swal({
		title: "",
		text: "컨텐츠를 삭제하시겠습니까?",
		type: "question",
		showCancelButton: true,
		confirmButtonText: "Yes",
		cancelButtonText: "Cancel"
	}). then ((result) => {
		if(result.value){
			swal(
				'',
				'<b style="font-weight:bold;">컨텐츠가 삭제되었습니다.</b>',
				'success'
			).then(function(){
				var fm = document.frm; //문서객체안의 폼객체이름
				var category = fm.contentsCategorySelected.value;
				var cidx = fm.cidx.value;
			 	//처리하기위해 이동하는 주소
				fm.action ="${pageContext.request.contextPath}/contents/contentsDeleteAction.do?cidx="+cidx+"&category="+category;  
				fm.method = "post";  //이동하는 방식  get 노출시킴 post 감추어서 전달
				fm.submit(); //전송시킴
				return;
			});
		}
	});
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
<div id="headers"></div>

<br><br><br>
<br><br><br>
<br><br><br>

<div class="WritingWrap">
	<div class="WritingHeader">
		<h2 class="title">컨텐츠 수정하기</h2>
		<div class="btnArea">
			<input class="twobtn" type="button" value="수정" onclick="goModify()">
			<input class="twobtn" type="button" value="삭제" onclick="goDelete()">
		</div>
	</div>
	<div class="WritingContent">
		<form name="frm">
		<input type="hidden" name="cidx" value="${cv.cidx}">
		<div class="editer_wrap">
			<div class="formCategory">
				<label>카테고리</label>
				<input type="text" id="contentsCategorySelected" name="contentsCategorySelected" value="${cv.contentsCategory}">
				<select id="contentsCategory" name="contentsCategory">
					<option value="${cv.contentsCategory}">선택</option>
					<option value="명소">명소</option>
					<option value="음식">음식</option>
				</select>
			</div> 
			<div class="formSubject">
				<label>제목</label>
				<input type="text" name="contentsSubject" value="${cv.contentsSubject}">
			</div>
			<div class="hashTagArea">
				<label>해시태그</label>
				<input name='contentsHashtag'>
			</div>
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
			<div class="file_wrap">
   		 	<div class="uploadedFile">
 				<label style="width:24%;">첨부된 메인사진</label>
   				<img width="350" src="${pageContext.request.contextPath}/thumbnailLoading.do?aidx=${cv.aidx}"/>
   		 	</div>
			<div id="customFileUpload" style="width:50%; margin-top:0;">
        		<input type="file" name="uploadFileName" id="uploadFile" onchange="readURL(this);" value="">
       			<label for="uploadFile" style="width:24%;cursor: pointer;">메인사진 변경하기</label>
       			<img id="preview" width="350" />
   		 	</div>
   		 	</div>
   		 	<input type="hidden" name="storedFile" value="${af.storedFilePath}">
   		 	<input type="hidden" name="storedThumbnail" value="${af.thumbnailFilePath}">
   		 	<input type="hidden" name="aidx" value="${af.aidx}">
		</div>
		<textarea id="summernote" name="contentsArticle">${cv.contentsArticle}</textarea>
	
		<!-- Map Section -->
		<input type="hidden" id="contentsLatitude" name="contentsLatitude" value="${cv.contentsLatitude}">
		<input type="hidden" id="contentsLongitude" name="contentsLongitude" value="${cv.contentsLongitude}">
		</form>
		<div class="editer_wrap">
			<div class="map_wrap">
				<label>지도 등록하기</label>
				<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;">
				</div>
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
		</div>
	</div>
</div>
</body>
</html>