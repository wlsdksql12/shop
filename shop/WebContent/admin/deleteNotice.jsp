<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// encoding
	request.setCharacterEncoding("utf-8");

	String memberNo = request.getParameter("memberNo");
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	
	// debug
	System.out.println(memberNo + "<-- memberNo");
	System.out.println(noticeNo + "<-- noticeNo");
	
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setMemberNo(memberNo);
	
	// dao
	NoticeDao noticeDao = new NoticeDao();
	
	noticeDao.deleteNotice(notice);
	System.out.println("공지게시글 삭제 성공");
	response.sendRedirect(request.getContextPath() + "/admin/selectNoticeList.jsp");
%>