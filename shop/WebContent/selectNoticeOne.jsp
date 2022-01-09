<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
   int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세보기</title>
</head>
<body>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<div class="container">
	<div class="container p-3 my-3 border">
	<div class="jumbotron">
		<h2>공지사항 상세보기</h2>
	</div>
	<!-- 상품상세출력 -->
      <%
         NoticeDao noticeDao = new NoticeDao();
      Notice notice = noticeDao.selectNoticeOne(noticeNo);
      %>
      <table class="table table-borderless table-hover">
      	<tr class="border-bottom font-weight-bold">
      		<td class="text-right">NoticeTitle</td>
      		<td class="text-right"><%=notice.getNoticeTitle()%></td>
      	</tr>
      	<tr class="border-bottom font-weight-bold">
      		<td class="text-right">NoticeContent</td>
      		<td class="text-right"><%=notice.getNoticeContent()%></td>
      	</tr>
      	<tr class="border-bottom font-weight-bold">
      		<td class="text-right">CreateDate</td>
      		<td class="text-right"><%=notice.getCreateDate()%></td>
      	</tr>
      </table>
      </div>
</div>
</body>
</html>