<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/navbar.css">
<link rel="stylesheet" href="./css/mainhome.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="http://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

</head>
<body>
<script src="./js/nav-bar.js"></script>
<header class="navigation" id="navigation">
    <nav class="nav-bar" style="height: 82px;">
        <h1>
            <a href="index.jsp">
                <img src="./images/logo.png">
            </a>
        </h1>
        <div class="menu-wrap">
            <ul class="menu-element">
                <li class="dep">
                    <a href="#">전주에가면</a>
                    <div class="dep-inner" style="display: none;">
                        <div class="inner-sub-title">
                            <p class="large-text">전주에가면</p>
                        </div>
                        <ul class="depth-2">
                            <li><a href="#">명소</a></li>
                            <li><a href="#">음식</a></li>
                            <li><a href="#">영상</a></li>
                        </ul>
                    </div>
                </li>
                <li class="dep">
                    <a href="#">여행일정</a>
                    <div class="dep-inner" style="display: none;">
                        <div class="inner-sub-title">
                            <p class="large-text">여행일정</p>
                        </div>
                        <ul class="depth-2">
                            <li><a href="#">여행공유</a></li>
                        </ul>
                    </div>
                </li>
                <li class="dep">
                    <a href="#">공지사항</a>
                    <div class="dep-inner" style="display: none;">
                        <div class="inner-sub-title">
                            <p class="large-text">공지사항</p>
                        </div>
                        <ul class="depth-2">
                            <li><a href="#">공지</a></li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
        <div class="my-menu-element">
            <div class="login-element">
                <%if(session.getAttribute("midx")==null){%>
                <a class="login" href="<%=request.getContextPath()%>/member/memberLogin.do">로그인</a>
                <%} else{ %>
                <a href="<%=request.getContextPath()%>/member/memberLogout.do">로그아웃</a>
                <%} %>
                <a href="<%=request.getContextPath()%>/mypage/userMypage.do">마이페이지</a>
            </div>
        </div>
    </nav>
    
</header>

<i class="xi-angle-left"></i>
<i class="xi-angle-right"></i>	

<section class="main-slide">
    <div class="main-slide-img">
	    <div><a href="#" style="background-image: url('./images/test.jpg');"></a></div>
	    <div><a href="#" style="background-image: url('./images/test2.jpg');"></a></div>
	    <div><a href="#" style="background-image: url('./images/test3.jpg');"></a></div>
	    <div><a href="#" style="background-image: url('./images/test.jpg');"></a></div>
	    <div><a href="#" style="background-image: url('./images/test2.jpg');"></a></div>
	    <div><a href="#" style="background-image: url('./images/test3.jpg');"></a></div>
    </div>
    <div class="main-text">
        <div class="main-slide-text">
            <div><a href="#"><p class="slide_txt">부산으로 떠나는 여행!</p></a></div>
            <div><a href="#"><p class="slide_txt">전주로 떠나는 여행, 먹고 자고 놀고, 아주 끝장내자!</p></a></div>
            <div><a href="#"><p class="slide_txt">얼마나 길게 쓸 수 있는데 너는 어디까지 나올 수 있는데 이거 설마 넘어가니 안넘어가니 확인해보자 어디 보여줘</p></a></div>
            <div><a href="#"><p class="slide_txt">안녕하세요4</p></a></div>
            <div><a href="#"><p class="slide_txt">안녕하세요5</p></a></div>
            <div><a href="#"><p class="slide_txt">안녕하세요6</p></a></div>
        </div>
        <div class="main-slide-page">
            <span class="main-current-num">1</span>
            <span>/</span>
            <span class="main-total-num">6</span>
        </div>  
	    <div class="admin-click" style="font-size: 17px;">
	        <div><a href="#"><p style="padding-top: 7px; width: 50px;" >배너 등록</p></a></div>
	    </div>
    </div>
</section>
<section class="second-slide">
	<div class="second-title">
	<span style="font-size:52px;">지금 전주는</span>
	<span style="font-size:24px;">어디가 좋을까?</span>
	</div>
	<div class="second-controll">
		<span class="prevArrow">이전</span>
		<span class="prevArrow">중지</span>
	    <span class="nextArrow">다음</span> 
	</div>
    <div class="second-slide-img">
	    <div><a href="#"><div class="thumbnail"><img src="./images/test.jpg"></div><p>이거되냐고1</p></a></div>
	    <div><a href="#"><div class="thumbnail"><img src="./images/test2.jpg"></div><p>이거되냐고2</p></a></div>
	    <div><a href="#"><div class="thumbnail"><img src="./images/test3.jpg"></div><p>이거되냐고3</p></a></div>
	    <div><a href="#"><div class="thumbnail"><img src="./images/test.jpg"></div><p>이거되냐고4</p></a></div>
	    <div><a href="#"><div class="thumbnail"><img src="./images/test2.jpg"></div><p>이거되냐고5</p></a></div>
	    <div><a href="#"><div class="thumbnail"><img src="./images/test3.jpg"></div><p>이거되냐고6</p></a></div>
    </div>
</section>



</body>
</html>

<script src="./js/mainhome.js"></script>
