<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Article</title>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<script src="../js/contentsArticle.js"></script> 
<link rel="stylesheet" href="../css/navbar.css">
<link rel="stylesheet" href="../css/contentsArticle.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<script src="http://code.jquery.com/jquery-3.1.0.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js" integrity="sha512-3j3VU6WC5rPQB4Ld1jnLV7Kd5xr+cq9avvhwqzbH/taCRNURoeEpoPBK9pDyeukwSxwRPJ8fDgvYXd6SkaZ2TA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
<!-- SweetAlert2 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.min.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/7.2.0/sweetalert2.all.min.js"></script>
</head>
<body>
<script type="text/javascript">
var cidx = ${cv.cidx};

$(document).ready(function(){

	//가져올때 navbar.css도 같이 가져올 것
	$('#headers').load("../nav/nav.jsp");
	$('#footers').load("../nav/footer.jsp");
	
	/*좋아요 체크*/
	likeCheck();
	
	/*리뷰창 로딩*/
	$('#tab3').click(function(){
		reviewList();
	});
	
	$('#tab2').click(function(){
		relayout();
	});
	
	$('#tab4').click(function(){
		blogReviewLead();
	});
	
	$("#loadMoreBtn").click(function () {
	    blogReviewLead();
	});
});
/*리뷰글쓰기창 열기*/
function revWriteOpen(){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/review/loginCheck.do",
		dataType : "json",
		cache : false,
		success : function(data){
			if(data.txt === "pass"){
				$('#writeReview').css('display','block');
			}else{
				alert(data.txt);
			}
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
	
}

function likeCheck(){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/contentsLike/contentsLikeCheck.do",
		dataType : "json",
		data : {
				"cidx" : cidx
		},
		cache : false,
		success : function(data){
			if(data.value != 0){
				$('.ck').attr('class','ck-on');
				swal(
					'',
					'<b style="font-weight:bold;">좋아요가 추가되었습니다.</b>',
					'success'
				)
			}else{
				$('.ck-on').attr('class','ck');
				swal(
					'',
					'<b style="font-weight:bold;">좋아요가 취소되었습니다.</b>',
					'success'
					)
			}
			$('#likeCnt').html(data.likeCount);
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
}
function likeThis(event){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/contentsLike/contentsLike.do",
		dataType : "json",
		data : {
				"cidx" : cidx
		},
		cache : false,
		success : function(data){
			/* alert(data.value); */
			likeCheck();
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
}
function reviewWrite(){
	var fm = document.rev_frm;
	var score = fm.reviewScore.value;
	var article = fm.reviewArticle.value;
	
	if(score == ""){
		swal(
			'',
			'<b style="font-weight:bold;">별점을 등록해주세요.</b>',
			'warning'
		)
		return;
	}else if(article == ""){
		swal(
			'',
			'<b style="font-weight:bold;">리뷰내용을 작성해주세요.</b>',
			'warning'
		)
		fm.reviewArticle.focus();
		return;
	}
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/review/reviewWrite.do",
		dataType : "json",
		data : {
				"cidx" : cidx,
				"reviewScore" : score,
				"reviewArticle" : article
		},
		cache : false,
		success : function(data){
			
			if(data.bad != null){
				swal(
					'',
					'<b style="font-weight:bold;">'+data.bad+'는 비속어입니다.</b>',
					'error'
					)
				return;
			}
			
			if(data.txt === "pass"){
				swal(
					'',
					'<b style="font-weight:bold;">리뷰가 등록되었습니다.</b>',
					'success'
					)
				$('#writeReview').css('display','none');
				reviewList();
			}else{
				alert(data.txt);
			}
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
}
function reviewList(){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/review/reviewList.do",
		dataType : "json",
		data : {
				"cidx" : cidx
		},
		cache : false,
		success : function(data){
			reviewListPrint(data.list);
			reviewPaging(data.pm);
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
}
function reviewListPaging(page){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/review/reviewList.do?page="+page,
		dataType : "json",
		data : {
				"cidx" : cidx
		},
		cache : false,
		success : function(data){
			reviewListPrint(data.list);
			reviewPaging(data.pm);
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
}
function reviewListPrint(data){
	var str = "";
	var delbtn = "";
	var loginMidx="${sessionScope.midx}";
	
	$(data).each(function(){
		if(loginMidx==this.midx){
			delbtn = "<button class='delBtn' onclick='reviewDel("+this.ridx+")'>삭제</button>";
		}else{
			delbtn= "<button id='reportBtn' class='reportBtn' onclick='reviewReport("+this.ridx+")'><i class='fa fa-bell' aria-hidden='true'></i></button>";
		}
		str = str+"<tr><td class='rev-writer'><div class='writer-wrap'><div class='rev-name'>"+this.memberName
			+"</div><div class='rev-date'>"+this.reviewWriteday
			+"</div><div class='rev-score'><img src='../images/rev-starOn.png'><div style='margin-left: 5px'>"+this.reviewScore
			+"</div></div></div></td><td class='rev-contents'>"+this.reviewArticle
			+"</td><td class='rev-del'>"+delbtn+"</td></tr>";
	});
	
	str = "<table class='listTable'>"+str+"</table>"
	
	$('#reviewTable').html(str);
	return;
}
function reviewPaging(data){
	var paging = "";
	var nowpage=data.rcri.page/5+1;
	if(data.prev == true){
		paging = paging + "<a class='pagePreview' href='javascript:reviewListPaging("+data.startPage-1+")'>이전</a>";
	}
	//var nowpage = data.cscri.page/9+1;
	for(var i=data.startPage; i<=data.endPage; i++){
		if(i==nowpage){
			paging = paging + "<a class='pageNumber active' href='javascript:reviewListPaging("+i+")'>"+i+"</a>";	
		}else{
			paging = paging + "<a class='pageNumber' href='javascript:reviewListPaging("+i+")'>"+i+"</a>";
		}
	}
	if(data.next == true && data.endPage>0){
		paging = paging + "<a class='pageNext' href='javascript:reviewListPaging("+(data.endPage+1)+")'>다음</a>";
	}
	$('#paging').html(paging);
}
function reviewDel(ridx){
	if(!confirm("댓글을 삭제하시겠습니까?")){
		return false;
	}
	
/* 	Swal.fire({
	      title: '정말로 그렇게 하시겠습니까?',
	      text: "다시 되돌릴 수 없습니다. 신중하세요.",
	      icon: 'warning',
	      showCancelButton: true,
	      confirmButtonColor: '#3085d6',
	      cancelButtonColor: '#d33',
	      confirmButtonText: '승인',
	      cancelButtonText: '취소',
	      reverseButtons: true, // 버튼 순서 거꾸로
	      
	    }),
	    function(result) {
	    	if (result.isConfirmed) { */
	
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/review/reviewDel.do",
		dataType : "json",
		data : {
				"ridx" : ridx
		},
		cache : false,
		success : function(data){
			if(data.txt === "pass"){
				swal(
					'',
					'<b style="font-weight:bold;">리뷰가 삭제되었습니다.</b>',
					'success'
				)
				reviewList();
			}else{
				alert(data.txt);
			}
		},
		error : function(){
			alert("통신오류 실패");
		}		
	});
}/* else {
	return false;
	}
}
} */
	var start = 4; // 시작 인덱스
	var batchSize = 5; // 한 번에 보여줄 항목의 개수
function blogReviewLead() {
    var subject = "전주 ${cv.contentsSubject}";
    $.ajax({
        type: "post",
        url: "${pageContext.request.contextPath}/review/blogReview.do",
        dataType: "json",
        data: {
            "subject": subject
        },
        cache: false,
        success: function (data) {
            displayBlogItems(data);
        },
        error: function () {
            alert("통신 오류 실패");
        }
    });
}

function displayBlogItems(data) {
    var txt = "";
    var end = Math.min(start + batchSize, data.url.length);

    for (var i = start; i < end; i++) {
        txt += "<a href='" + data.url[i] + "'>"
            + "<div class='blogCon'>"
            + "<div class='blogName'>" + data.blogname[i] + "</div>"
            + "<div class='blogSubject'>" + data.title[i] + "</div>"
            + "<div class='blogContents'>" + data.contents[i] + "</div>"
            + "</div>"
            + "</a>";
    }

    $(".blogList").append(txt);
    start = end;

    // 더 불러올 데이터가 있는 경우에만 "더 보기" 버튼을 표시
    if (start < data.url.length) {
        $("#loadMoreBtn").show();
    } else {
        $("#loadMoreBtn").hide();
    }
}

function reviewReport(ridx){
	
	$.ajax({
        type: "post",
        url: "${pageContext.request.contextPath}/review/reviewReport.do",
        dataType: "json",
        data: {
            "ridx": ridx
        },
        cache: false,
        success: function (data) {
        	if(data.txt === 'noLogin'){
        		swal(
    				'',
    				'<b style="font-weight:bold;">로그인 후 이용바랍니다.</b>',
    				'info'
    			)
        	}else if(data.txt ==='already'){
        		swal(
        			'',
        			'<b style="font-weight:bold;">이미 신고한 리뷰입니다.</b>',
        			'info'
        		)
        	}else{
				$('#rev-report').css("display","block");
        		reportArticle(data.review);
        	}
        },
        error: function () {
            alert("통신 오류 실패");
        }
    });
}

function reportArticle(data){
	var txt = "<input type='hidden' name='cidx' value='"+data.cidx+"'>"
			+"<input type='hidden' name='ridx' value='"+data.ridx+"'>"
			+"<table><tr><th>신고자</th>"
			+"<td>"+data.myName+"<input type='hidden' name='midx2' value='"+data.midx2+"'></td></tr>"
			+"<tr><th>피신고자</th>"
			+"<td>"+data.memberName+"<input type='hidden' name='midx' value='"+data.midx+"'></td></tr>"
			+"<tr><th>신고내용</th>"
			+"<td>"+data.reviewArticle+"</td></tr>"
			+"<tr><th>신고사유</th><td><select id='reviewReportReason' name='reviewReportReason' onchange='selectOther();'>"
			+"<option value='비방 및 욕설'>비방 및 욕설</option><option value='글과 상관없는 내용'>글과 상관없는 내용</option>"
			+"<option value='광고글'>광고글</option><option value='other'>기타</option></select>"
			+"<div id='otherCheck' style='display:none'><input type='text' name='otherReason'></div></td></tr></table>";
	$('#reportTable').html(txt);
}
function selectOther(){
	var value = document.getElementById("reviewReportReason").value;
	if(value == "other"){
		$('#otherCheck').css("display","inline");
	}else{
		$('#otherCheck').css("display","none");
	}
}
function reportWrite(){
	if(!confirm("해당 리뷰를 신고하시겠습니까?")){
		return false;
	}
	var fm = document.reportFrm;
	var ridx = fm.ridx.value;
	var cidx = fm.cidx.value;
	var midx = fm.midx.value;
	var midx2 = fm.midx2.value;
	var reviewReportReason = fm.reviewReportReason.value;
	var otherReason = fm.otherReason.value;
	
	if(reviewReportReason == "other" && otherReason != ""){
		reviewReportReason = otherReason;
	}
	
	if(reviewReportReason == "other" && otherReason == ""){
		swal(
			'',
			'<b style="font-weight:bold;">기타사유를 작성해주세요.</b>',
			'warning'
		)
		return;
	}
	$.ajax({
        type: "post",
        url: "${pageContext.request.contextPath}/review/reviewReportAction.do",
        dataType: "json",
        data: {
            "ridx": ridx,
            "cidx": cidx,
            "midx": midx,
            "midx2": midx2,
            "reviewReportReason": reviewReportReason
        },
        cache: false,
        success: function (data) {
        	swal(
            	'',
           		'<b style="font-weight:bold;">신고가 완료되었습니다.</b>',
           		'success'
          	)
        	$('#rev-report').css('display','none');
        },
        error: function () {
            alert("통신 오류 실패");
        }
    });
	
}
</script>
<div id="headers"></div>
<div class="contents">
	<div class="title">
		<h4>${cv.contentsSubject}</h4>
		<% String memberGradeValue = (String) session.getAttribute("memberGrade");	
		if("관리자".equals(memberGradeValue)) {%>
		<a class="modifylink" href="${pageContext.request.contextPath}/contents/contentsModify.do?cidx=${cv.cidx}">수정하기</a>
		<%} %>
	</div>
	<div class="mainImg">
		<img src="${pageContext.request.contextPath}/imageLoading.do?aidx=${cv.aidx}" />
	</div>
	<div class="actionUserBar">
		<ul class="left">
			<li>평점 &nbsp;<img src="../images/starimg.jpg">&nbsp;<strong>${csd.starAverage}</strong></li>
			<li>조회 &nbsp;<strong>${cv.contentsViewCount}</strong></li>
			<li>리뷰 <strong>${csd.reviewCount}</strong></li>
		</ul>
		<div class="right">
			<a href="#actionUserBar" onclick="likeThis(event);" class="ck">좋아요 (<span id="likeCnt"></span>)</a>
		</div>
	</div>
	<div>
		<h2>해시태그</h2>
		<ul class="listul">
		    <c:forEach var="item" items="${hashtag}">
		        <li class="listli">#${item.value}</li>
		    </c:forEach>
		</ul>
	</div>
	<div class="tabSection">
		<div class="tab-wrap">
			<ul id="tablist" class="tab innerwrap">
				<li class="on" id="tab1"><button>상세정보</button></li>
				<li id="tab2"><button>지도/길찾기</button></li>
				<li id="tab3"><button>리뷰</button></li>
				<li id="tab4"><button>블로그리뷰</button></li>
			</ul>
		</div>
		<div class="tab-con innerwrap" id="tab_con">
			<div class="con-det">
				${cv.contentsArticle}
			</div>
			<div class="con-map" style="display:none">
				<div id="map" style="width:100%; height:500px;"></div>
				<input type="hidden" id="latitude" value="${cv.contentsLatitude}">
				<input type="hidden" id="longitude" value="${cv.contentsLongitude}">
				<div class="loadSearch">
					<div class="inner">
						<strong class="title">길찾기</strong>
						<div class="loadPutBox">
							<div class="start">
								<span>출발지</span>
								<input type="text" id="findPath_start" class="loadInput">
							</div>
							<div class="end">
								<span>도착지</span>
								<input type="text" id="findPath_end" class="loadInput" value="${cv.contentsSubject}">
							</div>
						</div>
						<div class="loadBtn">
							<a href="https://map.kakao.com/link/to/${cv.contentsSubject},${cv.contentsLatitude},${cv.contentsLongitude}" target="_blank">길찾기</a>
						</div>
					</div>
				</div>
			</div>
			<div class="con-review" style="display:none">
				<div class="revHead">
					<div class="title">여행후기</div>
					<a href="javascript:revWriteOpen();" class="write" id="revWrite"><span>리뷰작성하기</span></a>
				</div>
				<div class="revList" id="revList">
					<div id="reviewTable"></div>
					<div class="paging" id="paging"></div>
				</div>
			</div>
			<div class="con-blog" style="display:none">
				<div class="revHead">
					<div class="title">블로그리뷰</div>
				</div>
				<div class="blogList">
				</div>
				<button id="loadMoreBtn" style="color:coral; float: right;">+더보기</button>
			</div>
		</div>
	</div>
	<div id="writeReview" class="writeReview" style="display:none">
	<div class="writeReview-wrap">
		<div class="writeReview-header">
			<h5 class="modal-title" style="color: #fff;font-size: 1.3rem;">리뷰 등록</h5>
		</div>
		<form name="rev_frm">
			<div class="rev-container">
			<table class="rev-contb">
				<colgroup>
					<col style="width: 15%">
					<col style="width: 85%">
				</colgroup>
				<tbody>
					<tr>
						<th>리뷰장소</th>
						<td>${cv.contentsSubject}</td>
					</tr>
					<tr>
						<th>평가</th>
						<td>
							<div id="rev_star_grade" class="rev-starGrade">
								<i class="rating__star far fa-star"></i>
								<i class="rating__star far fa-star"></i>
								<i class="rating__star far fa-star"></i>
								<i class="rating__star far fa-star"></i>
								<i class="rating__star far fa-star"></i>
								<input type="hidden" name="reviewScore" id="reviewScore"  value="">
							</div>
						</td>
					</tr>
					<tr>
						<th>리뷰내용</th>
						<td>
							<div class="rev-text">
								<textarea rows="4" cols="50" maxlength="1000" id="reviewArticle" name="reviewArticle"></textarea>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		</form>
		<div class="writebtn">
			<a class="rev-basic" href="javascript:reviewWrite();">등록</a>
			<a href="javascript:closeWrite();" class="rev-cc" id="rev-cc">취소</a>
		</div>
		</div>
	</div>
	
	<div class="rev-report" id="rev-report" style="display:none;">
		<div class="reportReview">
			<div class="report-top">
				<h5 class="modal-title" style="color: #fff;font-size: 1.3rem;">댓글 신고하기</h5>
			</div>
			<div class="report-contents">
				<form name="reportFrm">
				<div id="reportTable">
				
				</div>
				</form>
				<div class="writebtn">
					<a class="rev-basic" href="javascript:reportWrite();">등록</a>
					<a href="javascript:closeReport();" class="rev-cc" id="rep-cc">취소</a>
				</div>
			</div>
		</div>
	</div>
</div>
<div id="footers"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=dbee45d6252968c16f0f651bb901ef42&libraries=services"></script>
<script>

	var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
	var latitude = document.getElementById('latitude').value;
    var longitude = document.getElementById('longitude').value;
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(latitude, longitude), //지도의 중심좌표.
		level: 4 //지도의 레벨(확대, 축소 정도)
		};
	var map = new kakao.maps.Map(container, options);
	
	// 마커가 표시될 위치입니다 
	var markerPosition  = new kakao.maps.LatLng(latitude, longitude); 

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
	    position: markerPosition
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
	
	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new kakao.maps.MapTypeControl();
	
	// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
	// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
	map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new kakao.maps.ZoomControl();
	map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
	
 	function relayout() {    
	    // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
	    // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
	    // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
	    map.relayout();
	    map.setCenter(new kakao.maps.LatLng(latitude, longitude));
	} 
</script>
</body>
</html>