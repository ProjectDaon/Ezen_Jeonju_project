<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
.number {font-weight:bold;color:#ee6152;}
.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
.distanceInfo {position:relative;top:5px;left:5px;list-style:none;margin:0;}
.distanceInfo .label {display:inline-block;width:50px;}
.distanceInfo:after {content:none;}
    #scheduletbl{
        display: flex; 
        flex-direction: row;
        width: 900px;
        height: 600px;
        overflow: scroll;
    }
	.scheduletbl th,tr,td{
		border: 1px solid black;
		border-collapse: collapse;
	}
  	 #totaltbl{
    	display: flex; 
        flex-direction: row;
    }
	
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(document).ready(function () {
	var sidx = ${sidx};
	var tourCourseNDate = document.getElementById("selectDate").value;
	getTourCourse(sidx);
	getTourCourseNDate(sidx,tourCourseNDate);
	setCenter();
    $('#selectDate').on('change', function () {
    	hideMarkers();
    	hideInfoWindows();
    	tourCourseNDate = $(this).val();
        getTourCourseNDate(sidx,tourCourseNDate);
        setCenter();
    });

	
});

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

function getTourCourseNDate(sidx,tourCourseNDate){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/schedule/getTourCourseNDate.do",
		data : {
			"sidx" : sidx,
			"tourCourseNDate" : tourCourseNDate
		},
		dataType : "json",
		success : function(data){
			var positions = [];
			$(data).each(function(){
				positions.push({
					title: this.tourCoursePlace,
				    latlng: new kakao.maps.LatLng(this.tourCourseLatitude, this.tourCourseLongitude)
									
				});
				
				for (var i = 0; i < positions.length; i ++) {
				   // 마커를 생성합니다
					addMarker(positions[i].latlng,positions[i].title);
					
				}	
			});
			drawLine(positions);
			
		},
		error: function(request, status, error){
			alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
	});
}
</script>

</head>
<body>

<h1>일정 내용</h1>
		<table border=1 style="width:600px;">
		<tr>
		<th>제목</th>
		<td>${sv.scheduleSubject}</td>
		<th>기간</th>
		<td>${sv.scheduleStartDate}</td><td>${sv.scheduleEndDate}</td>
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
        <tr>
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
<div id="map" style="width:500px;height:400px;"></div>
   <div>
   <select name="selectDate" id="selectDate">
   	<c:forEach var="tl" items="${tlist}">
       <option value="${tl.tourCourseNDate}">${tl.tourCourseNDate} 일차 </option>
   </c:forEach>
   </select>
   </div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24905b65af4a0e247d268677c3972e9d"></script>
<script type="text/javascript" charset="UTF-8" src="../js/scheduleContents-map.js"></script>
</body>
</html>