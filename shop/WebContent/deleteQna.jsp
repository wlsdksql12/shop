<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//encoding
	request.setCharacterEncoding("utf-8");

	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	
	// debug
	System.out.println(memberNo + "<-- memberNo");
	System.out.println(qnaNo + "<-- qnaNo");
	
	Qna qna = new Qna();
	qna.setMemberNo(memberNo);
	qna.setQnaNo(qnaNo);
	
	// dao
	QnaDao qnaDao = new QnaDao();
	
	qnaDao.deleteQna(qna);
	System.out.println("QnA게시글 삭제 성공");
	response.sendRedirect(request.getContextPath() + "/selectQnaList.jsp");
%>