<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
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
	getTourCourse(sidx);
    
});
function getTourCourse(sidx){
	$.ajax({
		type : "post",
		url : "${pageContext.request.contextPath}/schedule/getTourCourse.do",
		data : {
			"sidx" : sidx
		},
		dataType : "json",
		success : function(data){
			var positions = [];
			$(data).each(function(){
				
				var td_id = "#"+this.tourCourseDate+"_"+this.tourCourseTime;
				$(td_id).html(this.tourCoursePlace);
				
				positions.push({
					
					title: this.tourCoursePlace,
				    latlng: new kakao.maps.LatLng(this.tourCourseLatitude, this.tourCourseLongitude)
									
				});
				
				for (var i = 0; i < positions.length; i ++) {
				    
				    // 마커를 생성합니다
				    var marker = new kakao.maps.Marker({
				        position: positions[i].latlng, // 마커를 표시할 위치
				        title : positions[i].title // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
				       
				    });
				    var iwContent = positions[i].title;
				    var iwPosition = positions[i].latlng;
			    
				    var infowindow = new kakao.maps.InfoWindow({
				        map: map, // 인포윈도우가 표시될 지도
				        position: iwPosition,
				        content: iwContent
				      });
				       // 마커를 지도에 표시합니다
				       marker.setMap(map);

				      infowindow.open(map, marker);
				    
				      setCenter();
				}
				
			});
			
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
   <select name="nDate">
   	<c:forEach var="tl" items="${tlist}">
       <option value="${tl.tourCourseNDate}">${tl.tourCourseNDate}</option>
   </c:forEach>
   </select>
   </div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24905b65af4a0e247d268677c3972e9d"></script>
<script src="../js/scheduleContents-map.js"></script>
</body>
</html>