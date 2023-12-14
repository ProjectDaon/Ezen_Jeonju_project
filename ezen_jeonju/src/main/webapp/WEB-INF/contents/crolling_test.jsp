<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<table>
<tr><td>ㅠㅠ</td></tr>
	<c:forEach var="url" items="${url}" varStatus="status" begin="4">
	<tr>
		<td>
			${blogname[status.index]}<br>
			<a href="${url}">
			${title[status.index]}</a><br>
			${contents[status.index]}<br>
		</td>
	</tr>
	</c:forEach>
</table>
</body>
</html>