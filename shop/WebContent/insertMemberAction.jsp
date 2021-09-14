<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	
	String memberId = request.getParameter("memberId");
	String memberPw = request.getParameter("memberPw");
	String memberName = request.getParameter("memberName");
	int memberAge = Integer.parseInt(request.getParameter("memberAge"));
	String memberGender = request.getParameter("memberGender");
	
	// 디버깅
	System.out.println("memberId : "+ memberId);
	System.out.println("memberPw : "+ memberPw);
	System.out.println("memberName : "+ memberName);
	System.out.println("memberAge : "+ memberAge);
	System.out.println("memberGender : "+ memberGender);
	
	Member member = new Member(); // Member 객체를 정의함
	
	member.setMemberId(memberId);
	member.setMemberPw(memberPw);
	member.setMemberName(memberName);
	member.setMemberAge(memberAge);
	member.setMemberGender(memberGender);
	
	MemberDao memberDao = new MemberDao(); // MemberDao 객체를 정의함
	memberDao.insertMember(member);
	
	response.sendRedirect("./index.jsp");
%>
</body>
</html>