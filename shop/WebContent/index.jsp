<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %> %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
</head>
<body>
	<!-- start : submenu include -->
	<div>
		<jsp:include page="/partial/submenu.jsp"></jsp:include>
	</div>
	<!-- end : submenu include -->
	<h1>메인페이지</h1>
	<%
		// 세션에 값이 없으면 실행
		if(session.getAttribute("loginMember") == null) {
	%>
	<div>
		<div><a href="<%=request.getContextPath()%>/loginForm.jsp">로그인</a></div>
		<div><a href="<%=request.getContextPath()%>/insertMemberForm.jsp">회원가입</a></div>
	</div>
	<%	
		// 세션에 값이 있을시 실행
		} else {
			Member loginMember = (Member)session.getAttribute("loginMember");
			Member member = new Member();
			System.out.println(loginMember.getMemberId() + "<-- 로그인 성공후 아이디");
			System.out.println(loginMember.getMemberName() + "<-- 로그인 성공후 이름");
	%>
		<!-- 로그인 후 -->
		<div><%=loginMember.getMemberName() %>님 반갑습니다.</div>
	<%
		}
	%>
</body>
</html>