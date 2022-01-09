<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	int orderNo = Integer.parseInt(request.getParameter("orderNo"));
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int orderScore = Integer.parseInt(request.getParameter("orderScore"));
	String orderCommentContent = request.getParameter("orderCommentContent");
	
	System.out.println(orderNo + "<-- orderNo");
	System.out.println(ebookNo + "<-- ebookNo");
	System.out.println(orderScore + "<-- orderScore");
	System.out.println(orderCommentContent + "<-- orderCommentContent");
	
	OrderDao orderDao = new OrderDao();
	OrderComment orderComment = new OrderComment();
	
	orderComment.setOrderNo(orderNo);
	orderComment.setEbookNo(ebookNo);
	orderComment.setOrderScore(orderScore);
	orderComment.setOrderCommentContent(orderCommentContent);
	
	 int row = orderDao.inserOrderComment(orderComment);
	 
	 if(row != 1) {
		 response.sendRedirect(request.getContextPath() + "/insertOrderCommentForm.jsp");
	 } else {
		 response.sendRedirect(request.getContextPath() + "/selectOrderListByMember.jsp");
	 }
%>