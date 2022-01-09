<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//encoding
	request.setCharacterEncoding("utf-8");
	
	// 방어코드
	if(request.getParameter("memberNo") == null) {
		response.sendRedirect("./selectMemberList.jsp?currentPage=1");
		return;
	}

	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String memberNo = request.getParameter("memberNo");
	// debug
	System.out.println("debug " + noticeNo + " <-- noticeNo");
	System.out.println("debug " + memberNo + " <-- memberNo");
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지게시글 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div class="container p-3 my-3 border">
	<form id="updateNoticeForm" method="post" action="<%=request.getContextPath() %>/admin/updateNoticeAction.jsp">
			<input type="hidden" name="noticeNo" value="<%=noticeNo%>">
		<table class="table table-borderless table-hover">
			<tr class="border-bottom font-weight-bold">
				<td class="text-right">noticeTitle</td>
				<td class="text-right"><input id="noticeTitle" type="text" name="noticeTitle"></td>
			</tr>
			<tr class="border-bottom font-weight-bold">
				<td class="text-right">noticeContent</td>
				<td class="text-right"><textarea id="noticeContent" name="noticeContent" rows="5" cols="50"></textarea></td>
			</tr>
			<tr class="border-bottom font-weight-bold">
				<td class="text-right">memberNo</td>
				<td class="text-right"><input type="text" name="memberNo" value="<%=memberNo%>" readonly="readonly"></td>
			</tr>
		</table>
		<button class="btn btn-outline-info" id="updateBtn" type="button">공지게시글 수정</button>
	</form>
	<script>
		$('#updateBtn').click(function() {
			if($('#noticeTitle').val() == '') { // noticeTitle이 공백이면
				alert('noticeTitle를 입력하세요');
	            return;
			} else if($('#noticeContent').val() == '') {
				alert('noticeContent를 입력하세요');
	            return;
			} else {
				$('#updateNoticeForm').submit();
			}
		
		})
	</script>
	</div>
</div>
</body>
</html>