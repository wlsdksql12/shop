<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String noticeTitle = request.getParameter("noticeTitle");
	String noticeContent = request.getParameter("noticeContent");
	String memberNo = request.getParameter("memberNo");
	
	System.out.println(noticeNo + "<-- noticeNo");
	System.out.println(noticeTitle + "<-- noticeTitle");
	System.out.println(noticeContent + "<-- noticeContent");
	System.out.println(memberNo + "<-- memberNo");
	
	Notice notice = new Notice();
	notice.setNoticeNo(noticeNo);
	notice.setNoticeTitle(noticeTitle);
	notice.setNoticeContent(noticeContent);
	notice.setMemberNo(memberNo);
	
	NoticeDao noticeDao = new NoticeDao();
	noticeDao.updateNoitce(notice);
	
	System.out.println("공지게시글 수정 성공");
	response.sendRedirect(request.getContextPath() + "/admin/selectNoticeList.jsp");
%>