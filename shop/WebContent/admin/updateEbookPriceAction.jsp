<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int newEbookPrice = Integer.parseInt(request.getParameter("newEbookPrice"));
	
	System.out.println(ebookNo + "<-- ebookNo");
	System.out.println(newEbookPrice + "<-- newEbookPrice");
	
	Ebook ebook = new Ebook();
	ebook.setEbookNo(ebookNo);
	ebook.setEbookPrice(newEbookPrice);
	EbookDao ebookDao = new EbookDao();
	ebookDao.updateEbookPrice(ebook);
	
	System.out.println("Ebook가격 수정 성공");
	response.sendRedirect(request.getContextPath() + "/admin/selectEbookOne.jsp?ebookNo=" + ebookNo);
%>