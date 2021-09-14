<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원가입</h1>
	<form method = "post" action="insertMemberAction.jsp">
		<table>
			<tr>
				<td>아이디 : </td>
				<td><input type = "text" name = "memberId"></td>
			</tr>
			<tr>
				<td>비밀번호 : </td>
				<td><input type = "password" name = "memberPw"></td>
			</tr>
			<tr>
				<td>이름 : </td>
				<td><input type = "text" name = "memberName"></td>
			</tr>
			<tr>
				<td>나이 : </td>
				<td><input type = "text" name = "memberAge"></td>
			</tr>
			<tr>
				<td>
				<select name = "memberGender">
					<option value = "남">남</option>
					<option value = "여">여</option>
				</select>
				</td>
			</tr>
		</table>
		<div><button type = "submit">가입하기</button></div>
	</form>
</body>
</html>