<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%
	request.setCharacterEncoding("utf-8");
	
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	int orderPrice = Integer.parseInt(request.getParameter("orderPrice"));
	
	System.out.println(ebookNo + "<-- ebookNo");
	System.out.println(memberNo + "<-- memberNo");
	System.out.println(orderPrice + "<-- orderPrice");
	
	Order order = new Order();
	
	order.setEbookNo(ebookNo);
	order.setMemberNo(memberNo);
	order.setOrderPrice(orderPrice);
	
	OrderDao orderDao = new OrderDao();
	orderDao.insertOrder(order);
	
%>