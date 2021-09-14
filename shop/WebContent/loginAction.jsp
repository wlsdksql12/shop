<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "vo.*" %>
<%@ page import= "dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		
		// 값받아옴
		String memberId = request.getParameter("memberId");
		String memberPw = request.getParameter("memberPw");
		
		//디버깅
		System.out.println(memberId + "<-- 로그인할때 필요한 memberId");
		System.out.println(memberPw + "<-- 로그인할때 필요한 memberPw");
		
		// MemberDao, Member를 정의함
		MemberDao memberDao = new MemberDao();
		Member member = new Member();
		
		member.setMemberId(memberId);
		member.setMemberPw(memberPw);
		
		Member member1 = memberDao.login(member);
		
		if(member1 == null) {
			System.out.println("로그인 실패");
			response.sendRedirect("./loginForm.jsp");
			return ;
		} else {
			System.out.println("로그인 성공");
			System.out.println(member1.getMemberId());
			System.out.println(member1.getMemberName());
			// request, session : JSP내장객체
			// 특정 사용자 공간(session)에 변수를 생성
			session.setAttribute("loginMember", member1);
			response.sendRedirect("./index.jsp");
		}
	%>
</body>
</html>