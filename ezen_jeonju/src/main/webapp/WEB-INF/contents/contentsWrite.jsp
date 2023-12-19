<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>컨텐츠 작성</title>
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/contentsWrite.css">
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
function goWrite(){
	var fm = document.frm;
	if(fm.contentsSubject.value==""){
		alert('제목을 입력해주세요');
		fm.contentsSubject.focus();
		return;
	}

	fm.action ="<%=request.getContextPath()%>/contents/contentsWriteAction.do"; 
    fm.method = "post"; 
    fm.enctype= "multipart/form-data";
    fm.submit();
    return;
}


</script>
<div class="panel-heading">글 작성하기</div>
	<div class="panel-body">
		<form name="frm">
			<div class="form-group">
				<label>카테고리</label>
				<select name="contentsCategory">
					<option value="명소">명소</option>
					<option value="음식">음식</option>
				</select>
			</div> 
			<div>
				<label>제목</label>
				<input type="text" name="contentsSubject"><br>
				<script src="https://unpkg.com/@yaireo/tagify"></script>
				<!-- 폴리필 (구버젼 브라우저 지원) -->
				<script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
				<link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />
				
				태그<input name='contentsHashtag'>
				
				<script>
				    const input = document.querySelector('input[name=contentsHashtag]');
				    let tagify = new Tagify(input); // initialize Tagify
				    
				    // 태그가 추가되면 이벤트 발생
				    tagify.on('add', function() {
				      console.log(tagify.value); // 입력된 태그 정보 객체
				    })
				</script>
			</div>
			<textarea id="summernote" name="contentsArticle"></textarea>
			<input type="file" name="contentsFileName">
			
	<script>
	$(document).ready(function() {
	  $('#summernote').summernote({
	    lang: 'ko-KR' // default: 'en-US'
	  });
	});
	</script>
	
	<br>
	
	<input type="text" id="contentsLatitude"name="contentsLatitude" value="">
	<input type="text" id="contentsLongitude" name="contentsLongitude" value="">
	</form>
	<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>

    <div id="menu_wrap" class="bg_white">
        <div class="option">
            <div>
                <form onsubmit="searchPlaces(); return false;">
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
<input type="button" value="등록" onclick="goWrite()">
</body>
</html>