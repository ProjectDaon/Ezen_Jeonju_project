<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="http://cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.7.1.min.js"></script>
</head>
<body>
<script src="${pageContext.request.contextPath}/js/nav-bar.js"></script>
<header class="navigation" id="navigation">
    <nav class="nav-bar">
        <h1>
            <a href="/">
                <img src="${pageContext.request.contextPath}/images/logo.png">
            </a>
        </h1>
        <div class="menu-wrap">
            <ul class="menu-element">
                <li class="dep">
                    <a href="#none">전주에가면</a>
                    <div class="dep-inner" style="display: none;">
                        <div class="inner-sub-title">
                            <p class="large-text">전주에가면</p>
                        </div>
						<ul class="depth-2">
							<li><a href="${pageContext.request.contextPath}/contents/sight/contentsList.do">명소</a></li>
							<li><a href="${pageContext.request.contextPath}/contents/food/contentsList.do">음식</a></li>
							<li><a href="${pageContext.request.contextPath}/contents/youtube.do?page=1">영상</a></li>
						</ul>
                    </div>
                </li>
                <li class="dep">
                    <a href="#none">여행일정</a>
                    <div class="dep-inner" style="display: none;">
                        <div class="inner-sub-title">
                            <p class="large-text">여행일정</p>
                        </div>
                        <ul class="depth-2">
                            <li><a href="${pageContext.request.contextPath}/schedule/scheduleList.do">여행공유</a></li>
                        </ul>
                    </div>
                </li>
                <li class="dep">
                    <a href="#none">공지사항</a>
                    <div class="dep-inner" style="display: none;">
                        <div class="inner-sub-title">
                            <p class="large-text">공지사항</p>
                        </div>
                        <ul class="depth-2">
                            <li><a href="${pageContext.request.contextPath}/notice/noticeList.do">공지사항</a></li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
        <div class="my-menu-element">
            <div class="login-element">
                <%if(session.getAttribute("midx")==null){%>
                <a class="login" href="${pageContext.request.contextPath}/member/memberLogin.do">로그인</a>
                <%} else{ %>
                <a href="${pageContext.request.contextPath}/member/memberLogout.do">로그아웃</a>
                <%} %>
                <a href="${pageContext.request.contextPath}/mypage/userMypage.do">마이페이지</a>
            </div>
        </div>
        <div class="menu-hamburger" onclick="toggleMenu()">
            <i class="xi-bars"></i>
        </div>
    </nav>
        <div class="menu-hamburger-area" id="menu-hamburger-area" style="display: none;">
            <div class="login-box">
                <%if(session.getAttribute("midx")==null){%>
                <a href="${pageContext.request.contextPath}/member/memberLogin.do">로그인</a>
                <%} else{ %>
                <a href="${pageContext.request.contextPath}/member/memberLogout.do">로그아웃</a>
                <%} %>
                <a href="${pageContext.request.contextPath}/mypage/userMypage.do">마이페이지</a>
            </div>
            <div class="menu-hamburger-list">
                <div class="menu-list-wrap">
                    <div class="menu-title" onclick="toggleSubMenu('submenu-title-1')">
                        <p>전주에가면</p>
                    </div>
                    <ul class="submenu-title-1" style="display: none;">
                        <li><a href="${pageContext.request.contextPath}/contents/sight/contentsList.do">명소</a></li>
                        <li><a href="${pageContext.request.contextPath}/contents/food/contentsList.do">음식</a></li>
                        <li><a href="${pageContext.request.contextPath}/contents/youtube.do?page=1">영상</a></li>
                    </ul>
                </div>
                <div class="menu-list-wrap">
                    <div class="menu-title" onclick="toggleSubMenu('submenu-title-2')">
                        <p>여행일정</p>
                    </div>
                    <ul class="submenu-title-2" style="display: none;">
                        <li><a href="${pageContext.request.contextPath}/schedule/scheduleList.do">여행공유</a></li>
                    </ul>
                </div>  
                <div class="menu-list-wrap">
                    <div class="menu-title" onclick="toggleSubMenu('submenu-title-3')">
                        <p>공지사항</p>
                    </div>
                    <ul class="submenu-title-3" style="display: none;">
                        <li><a href="${pageContext.request.contextPath}/notice/noticeList.do">공지사항</a></li>
                    </ul>
                </div>
            </div>
        </div>
</header>

</body>
</html>