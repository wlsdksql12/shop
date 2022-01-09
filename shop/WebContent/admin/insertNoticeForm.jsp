<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
	int memberNo = loginMember.getMemberNo();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div class="container p-3 my-3 border">
	<form id="insertNoticeForm" method="post" action="<%=request.getContextPath() %>/admin/insertNoticeAction.jsp">
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
		<button class="btn btn-outline-info" id="NoticeBtn" type="button">공지게시글 추가</button>
	</form>
	<script>
		$('#NoticeBtn').click(function() {
			if($('#noticeTitle').val() == '') { // noticeTitle가 공백이면
				 alert('noticeTitle를 입력하세요');
		            return;
			} else if($('#noticeContent').val() == '') { // noticeContent가 공백이면
				alert('noticeContent를 입력하세요');
	           	 return;
		} else {
			$('#insertNoticeForm').submit();	
		}
	});
	</script>
	</div>
</div>
</body>
</html>