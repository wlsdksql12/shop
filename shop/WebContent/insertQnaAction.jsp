<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	String qnaCategroy = request.getParameter("qnaCategroy");
	String qnaTitle = request.getParameter("qnaTitle");
	String qnaContent = request.getParameter("qnaContent");
	String qnaSecret = request.getParameter("qnaSecret");
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	System.out.println(qnaCategroy + "<-- qnaCategroy");
	System.out.println(qnaTitle + "<-- qnaTitle");
	System.out.println(qnaContent + "<-- qnaContent");
	System.out.println(qnaSecret + "<-- qnaSecret");
	System.out.println(memberNo + "<-- memberNo");
	
	Qna qna = new Qna();
	qna.setQnaCategroy(qnaCategroy);
	qna.setQnaTitle(qnaTitle);
	qna.setQnaContent(qnaContent);
	qna.setQnaSecret(qnaSecret);
	qna.setMemberNo(memberNo);
	
	QnaDao qnaDao = new QnaDao();
	qnaDao.insertQnaList(qna);
	System.out.println("QnA 추가 성공");
	response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
%>