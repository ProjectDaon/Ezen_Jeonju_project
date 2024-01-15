<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="com.ezen_jeonju.myapp.domain.*" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>여행 일정</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="../css/scheduleContents.css">
<link rel="stylesheet" href="../css/navbar.css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24905b65af4a0e247d268677c3972e9d"></script>
<script>
$(document).ready(function () {
	$('#headers').load("../nav/nav.jsp");
	$('#footers').load("../nav/footer.jsp");

	var sidx = ${sidx};
	var tourCourseNDate = document.getElementById("selectDate").value;
	getTourCourse(sidx);
	
	//일차에 맞춰 지도나오는 함수
	getTourCourseNDate(sidx,tourCourseNDate);
    $('#nDate').val("1 일차");
    $('#timetbl tr').find('td:eq(1)').addClass('highlight');
    $('#timetbl th:eq(1)').addClass('highlight2');
    
    $('#selectDate').on('change', function () {
    	hideMarkers();
    	tourCourseNDate = $(this).val();
        getTourCourseNDate(sidx,tourCourseNDate);
        $('#nDate').val(tourCourseNDate+" 일차");
        $(".highlight").removeClass("highlight");
        $(".highlight2").removeClass("highlight2");
        $('#timetbl tr').find('td:eq('+tourCourseNDate+')').addClass('highlight');
        $('#timetbl th:eq(' + tourCourseNDate + ')').addClass('highlight2');
    }); 
    $('#timetbl td').on('click', function () {
        var rowIndex = $(this).parent().index();
        var columnIndex = $(this).index();

        if (columnIndex === 0) {
            return;
        }
        $(".highlight").removeClass("highlight");
        $(".highlight2").removeClass("highlight2");
        // 첫 번째 행 또는 첫 번째 열인 경우 이벤트 발생하지 않도록 처리

        $('#timetbl tr').find('td:eq(' + columnIndex + ')').addClass('highlight');
        $('#timetbl th:eq(' + columnIndex + ')').addClass('highlight2'); // 수정된 부분
        hideMarkers();
        tourCourseNDate = columnIndex; // 수정된 부분
        // n일차 지도출력
        getTourCourseNDate(sidx, tourCourseNDate);

        $('#nDate').val(tourCourseNDate + " 일차");
    });
    
});

//페이지가 모두 로드된후 랭크부여 0.05초 딜레이
$(window).on('load', function() {
	setTimeout(function() {
	    addRankToTable('timetbl');
	}, 50);
});

//랭크 부여
function addRankToTable(tableId) {

	var table = document.getElementById(tableId);
	var rows = table.getElementsByTagName('tr');
	
	for (var j = 0; j < rows[0].cells.length; j++) {
		if (j === 0) {
            continue;
        }
		
	    var rank = 1;
	    
	    for (var i = 1; i < rows.length; i++) {
	        var cell = rows[i].cells[j];
	        
	        // td에 값이 있을 경우에만 랭크 추가
	        if (cell.innerHTML.trim() !== "") {
	            
                var existingRank = cell.querySelector('#sequence');
                if (existingRank) {
                    existingRank.parentNode.removeChild(existingRank);
                }
	        	
	        	cell.innerHTML = "<div id='sequencediv'><Strong id='sequence'>" + "<div id='rankdiv'><div id='rank'>" + rank + "</div></div>" + "</Strong><span id='place'>" + cell.innerHTML + "</span></div>";
	            rank++;
	       		}
	   		 }
		}
	
	}
//일정표
function getTourCourse(sidx){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/schedule/getTourCourse.do",
		data : {
			"sidx" : sidx
		},
		dataType : "json",
		success : function(data){
		
			$(data).each(function(){
				
				var td_id = "#"+this.tourCourseDate+"_"+this.tourCourseTime;
				$(td_id).html(this.tourCoursePlace);
				
			});
			
		},
		error: function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}

var bounds = new kakao.maps.LatLngBounds();

//범위 재설정
function clearBounds() {
    if (!bounds.isEmpty()) {
    	bounds = new kakao.maps.LatLngBounds();	
    }
}
function setBounds() {
    map.setBounds(bounds);
}

function getTourCourseNDate(sidx, tourCourseNDate) {
    $.ajax({
        type: "post",
        url: "${pageContext.request.contextPath}/schedule/getTourCourseNDate.do",
        data: {
            "sidx": sidx,
            "tourCourseNDate": tourCourseNDate
        },
        dataType: "json",
        success: function (data) {
            var positions = [];

            $(data).each(function () {
                positions.push({
                    title: this.tourCoursePlace,
                    latlng: new kakao.maps.LatLng(this.tourCourseLatitude, this.tourCourseLongitude)
                });
            });

            if(positions.length != 0){
            	clearBounds();
            	
                for (var i = 0; i < positions.length; i++) {
                    addMarker(positions[i].latlng, positions[i].title, (i + 1));
                    bounds.extend(positions[i].latlng);
                }

                setBounds();
                drawLine(positions);
            }
            else{
            	polyline.setMap(null);
                distanceOverlay.setMap(null);
                distanceOverlay = null;
            }

        },
        error: function (request, status, error) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
}

function goDelete() {
    // 사용자에게 삭제 여부를 확인하는 경고창 표시
    var confirmDelete = confirm("삭제하시겠습니까?");
    
    // 사용자가 확인을 누른 경우에만 삭제 진행
    if (confirmDelete) {
        // 현재 URL에서 sidx 값을 추출
        var urlParams = new URLSearchParams(window.location.search);
        var sidx = urlParams.get('sidx');
        
        // sidx 값을 확인한 후에 삭제 페이지로 이동
        if (sidx) {
            // 삭제 페이지로 이동
            alert("일정이 삭제 되었습니다");
            window.location.href = "<%=request.getContextPath()%>/schedule/scheduleDelete.do?sidx=" + sidx;
        } else {
            alert("삭제 실패");
        }
    }
}
</script>

</head>
<body>
<div id="headers"></div>
<div class="innerwrap">
<h3>여행 일정</h3>
		<table id="headtbl">
		<tr>
		<th>제목</th>
		<td>${fn:escapeXml(sv.scheduleSubject)}</td>
		<th>기간</th>
		<td style="padding-left:6%">${sv.scheduleStartDate}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ~ &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${sv.scheduleEndDate}</td>
		<th>조회수</th>
		<td>${sv.scheduleViewCount}</td>
		</tr>
		</table>
		<br>
<div id="totaltbl">	
		<div class="scheduletbl" id = "scheduletbl">		
		<table id="timetbl">
        <thead>
        <tr>
        <th>시간</th>
        <c:forEach var="dl" items="${dateList}">
        	<th>${dl}</th>
        </c:forEach>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="hour" begin="8" end="22">
		    <tr>
		    	<c:choose>
		    		<c:when test="${hour lt 10}">
		    			<td>0${hour}:00</td>
		    	 	</c:when>
		    	 	<c:otherwise>
		    			<td>${hour}:00</td>
		    	 	</c:otherwise>
		    	</c:choose>
		        
		        <c:forEach var="dl" items="${dateList}">	        
		        	<td id="${dl}_${hour}"></td>
		        </c:forEach>	
		    </tr>
		</c:forEach>

        </tbody>
		</table>	
   </div>
<div id="mapSelect">
<input id="nDate" readonly="true"></input>
<div id="map" style="width:500px;height:85%;"></div>
   <div id="Dates">
   <select name="selectDate" id="selectDate">
   	<c:forEach var="tl" items="${tlist}">
       <option value="${tl.tourCourseNDate}">${tl.tourCourseNDate} 일차</option>
   </c:forEach>
   </select>
   </div>
</div>   

</div>
<div id=listdel>
	<div class="listbtn"><a href="${pageContext.request.contextPath}/schedule/scheduleList.do">목록</a></div>
	
	<%
	String memberGradeValue = (String) session.getAttribute("memberGrade");
	Integer sessionMidxObj = (Integer) session.getAttribute("midx"); // Integer로 타입 캐스팅
	
	// sessionMidx가 null이 아닐 때에만 int로 변환
	int sessionMidx = (sessionMidxObj != null) ? sessionMidxObj.intValue() : -1; // 적절한 기본값으로 변경
	
	ScheduleRootVo sv = (ScheduleRootVo) request.getAttribute("sv");
	
	// sv가 null이 아니고, 작성자인 경우 또는 관리자인 경우에만 삭제 버튼 표시
	if (sv != null && ("관리자".equals(memberGradeValue) || sessionMidx == sv.getMidx())) {
	%>
	    <div id="delbtn">
	        <a href="javascript:goDelete();">일정 삭제</a>
	    </div>
	<%
	}
	%>
	
</div>

</div>
<div id="footers"></div>
<script type="text/javascript" charset="UTF-8" src="../js/scheduleContents-map.js"></script>
</body>
</html>