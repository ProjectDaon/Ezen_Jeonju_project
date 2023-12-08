<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
nidx: ${nv.nidx} <br>
카테고리: ${nv.noticeCategory} <br>
제목: ${nv.noticeSubject} <br>
작성일: ${nv.noticeWriteday} <br>
내용: ${nv.noticeArticle} <br>
첨부파일: ${nv.noticeFileName} <br>
파일경로: ${nv.noticeFilePath} <br>

</body>
</html>