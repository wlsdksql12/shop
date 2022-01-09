<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String qnaCommentContent = request.getParameter("qnaCommentContent");
	
	System.out.println(qnaNo + "<-- qnaNo");
	System.out.println(memberNo + "<-- memberNo");
	System.out.println(qnaCommentContent + "<-- qnaCommentContent");
	
	QnaDao qnaDao = new QnaDao();
	QnaComment qnaComment = new QnaComment();
	
	qnaComment.setQnaNo(qnaNo);
	qnaComment.setMemberNo(memberNo);
	qnaComment.setQnaCommentContent(qnaCommentContent);
	
	qnaDao.insertQnaComment(qnaComment);
	response.sendRedirect(request.getContextPath() + "/selectQnaOne.jsp");
%>