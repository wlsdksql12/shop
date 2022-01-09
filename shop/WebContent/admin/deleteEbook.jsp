<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	System.out.println(ebookNo + "<--selectEbookOne.jsp.ebookNo");
	
	EbookDao ebookDao = new EbookDao();
	ebookDao.deleteEbook(ebookNo);
	
	System.out.println("Ebook 삭제 성공");
	response.sendRedirect(request.getContextPath() + "/admin/selectEbookList.jsp");
%>
