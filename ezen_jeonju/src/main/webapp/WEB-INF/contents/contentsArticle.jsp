<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>contentsArticle</title>
</head>
<body>
cidx: ${cv.cidx} <br>
카테고리: ${cv.contentsCategory} <br>
제목: ${cv.contentsSubject} <br>
작성일: ${cv.contentsWriteday} <br>
내용: ${cv.contentsArticle} <br>
<%-- 첨부파일: ${cv.noticeFileName} <br>
파일경로: ${cv.noticeFilePath} <br> --%>

</body>
</html>