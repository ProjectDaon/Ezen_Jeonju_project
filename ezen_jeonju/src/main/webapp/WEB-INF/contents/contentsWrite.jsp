<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>컨텐츠 작성</title>
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
	  lang: 'ko-KR', // default: 'en-US'
	  toolbar: [
          // 스타일 관련 기능
          ['style', ['style']],
          // 글자 크기 설정
          ['fontsize', ['fontsize']],
          // 글꼴 스타일
          ['font', ['bold', 'underline', 'clear']],
          // 글자 색상
          ['color', ['color']],
          // 테이블 삽입
          ['table', ['table']],
          // 문단 스타일
          ['para', ['paragraph']],
          // 에디터 높이 설정
          ['height', ['height']],
          // 이미지, 링크, 동영상 삽입
          ['insert', ['picture', 'link', 'video']],
          // 코드 보기, 전체화면, 도움말
          ['view', ['codeview', 'fullscreen', 'help']],
      ],
      fontSizes: [
          // 글자 크기 선택 옵션
          '8', '9', '10', '11', '12', '14', '16', '18', '20', '22', '24', '28', '30', '36', '50', '72'
      ],
      styleTags: [
          // 스타일 태그 옵션
          'p',
          { title: 'Blockquote', tag: 'blockquote', className: 'blockquote', value: 'blockquote' },
          'pre',
          { title: 'code_light', tag: 'pre', className: 'code_light', value: 'pre' },
          { title: 'code_dark', tag: 'pre', className: 'code_dark', value: 'pre' },
          'h1', 'h2', 'h3', 'h4', 'h5', 'h6'
      ]
	});

});

function goWrite(){
	var fm = document.frm;
	if(fm.contentsSubject.value==""){
		swal(
			'',
			'<b style="font-weight:bold;">제목을 입력해주세요.</b>',
			'warning'
		);
		fm.contentsSubject.focus();
		return;
	}
	swal({
		title: "",
		text: "컨텐츠를 등록하시겠습니까?",
		type: "question",
		showCancelButton: true,
		confirmButtonText: "Yes",
		cancelButtonText: "Cancel"
	}). then ((result) => {
		if(result.value){
			swal(
				'',
				'<b style="font-weight:bold;">컨텐츠가 등록되었습니다.</b>',
				'success'
			).then(function(){
				fm.action ="<%=request.getContextPath()%>/contents/contentsWriteAction.do"; 
			    fm.method = "post"; 
			    fm.enctype= "multipart/form-data";
			    fm.submit();
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
		<h2 class="title">컨텐츠 작성하기</h2>
		<input class="btn" type="button" value="등록" onclick="goWrite()">
	</div>
	<div class="WritingContent">
		<form name="frm">
		<div class="editer_wrap">
			<div class="formCategory">
				<label>카테고리</label>
				<select name="contentsCategory" required>
					<option value="" disabled selected>카테고리를 선택해 주세요.</option>
					<option value="명소">명소</option>
					<option value="음식">음식</option>
				</select>
			</div>
			<div class="formSubject">
				<label>제목</label>
				<input type="text" name="contentsSubject"  placeholder="제목을 입력해 주세요.">
			</div>
			<div class="hashTagArea">
				<label>해시태그</label>
				<input name='contentsHashtag'>
			</div>
			<script>
			    const input = document.querySelector('input[name=contentsHashtag]');
			    let tagify = new Tagify(input); // initialize Tagify
			    
			    // 태그가 추가되면 이벤트 발생
			    tagify.on('add', function() {
			      console.log(tagify.value); // 입력된 태그 정보 객체
			    })
			</script>
			<div id="customFileUpload">
        		<input type="file" name="uploadFileName" id="uploadFile" onchange="readURL(this);">
       			<label for="uploadFile" style="cursor: pointer;">메인사진 등록하기</label>
       			<img id="preview" width="350" height="205"/>
			</div>
				<input type="hidden" id="contentsLatitude"name="contentsLatitude" value="">
				<input type="hidden" id="contentsLongitude" name="contentsLongitude" value="">
		</div>
		<textarea id="summernote" name="contentsArticle"></textarea>
		</form>
		<div class="editer_wrap">
			<div class="map_wrap">
				<label>지도 등록하기</label>
				<div id="map">
				</div>
					<div id="menu_wrap" class="bg_white">
						<div class="option">
							<div>
								<form name="map_frm" onsubmit="searchPlaces(); return false;">
								키워드 : <input type="text" value="" id="keyword" size="15"> 
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
			<script src="../js/contentsWrite-map.js"></script>
		</div>
	</div>
</div>
</body>
</html>