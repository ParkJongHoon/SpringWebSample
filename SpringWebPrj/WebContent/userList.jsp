<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
</head>
<body>

<tbody>
	<c:forEach var="user" items="${userList}">
		<tr>
			<td>${user.userId}</td>
			<td>${user.name}</td>
			<td>${user.gender}</td>
			<td>${user.city}</td>
			<td>수정</td>
			<td>삭제</td>		
		</tr>
	</c:forEach>
</tbody>

</body>
</html>