<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*"%>
<%@ page import = "dao.*"%>
<%@ page import = "java.util.*"%>
<%
	request.setCharacterEncoding("utf-8");
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	String qnaCategroy = request.getParameter("qnaCategroy");
	String qnaTitle = request.getParameter("qnaTitle");
	String qnaContent = request.getParameter("qnaContent");
	String qnaSecret = request.getParameter("qnaSecret");
	
	System.out.println(qnaNo + "<-- 넘어온 qnaNo");
	System.out.println(memberNo + "<-- 넘어온 memberNo");
	System.out.println(qnaCategroy + "<-- 넘어온 qnaCategroy");
	System.out.println(qnaTitle + "<-- 넘어온 qnaTitle");
	System.out.println(qnaContent + "<-- 넘어온 qnaContent");
	System.out.println(qnaSecret + "<-- 넘어온 qnaSecret");
	
	Qna qna = new Qna();
	QnaDao qnaDao = new QnaDao();
	
	qna.setQnaNo(qnaNo);
	qna.setMemberNo(memberNo);
	qna.setQnaCategroy(qnaCategroy);
	qna.setQnaTitle(qnaTitle);
	qna.setQnaContent(qnaContent);
	qna.setQnaSecret(qnaSecret);
	
	qnaDao.updateQna(qna);
	System.out.println("QnA 수정 성공");
	response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
	
%>