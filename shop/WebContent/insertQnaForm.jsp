<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// 방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
	int memberNo = loginMember.getMemberNo();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Qna 추가</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div class="container p-3 my-3 border">
	<form id="insertQnaForm" method="post" action="<%=request.getContextPath() %>/insertQnaAction.jsp">
		<table class="table table-borderless table-hover">
			<tr class="border-bottom font-weight-bold">
				<td class="text-right">QnA Categroy</td>
				<td class="text-right">
					<select name="qnaCategroy">
						<option value="전자책관련">전자책관련</option>
						<option value="개인정보관련">개인정보관련</option>
						<option value="기타">기타</option>
					</select>
				</td>
			</tr>
			<tr class="border-bottom font-weight-bold">
				<td class="text-right">QnA Title</td>
				<td class="text-right"><input id="qnaTitle" type="text" name="qnaTitle"></td>
			</tr>
			<tr class="border-bottom font-weight-bold">
				<td class="text-right">QnA content</td>
				<td class="text-right"><textarea id="qnaContent" name="qnaContent" rows="5" cols="50"></textarea></td>
			</tr>
			<tr class="border-bottom font-weight-bold">
				<td>QnA secret</td>
				<td class="text-right">
					<select name="qnaSecret">
						<option value="Y">YES</option>
						<option value="N">NO</option>
					</select>
				</td>
			</tr>
			<tr class="border-bottom font-weight-bold">
				<td class="text-right">memberNo</td>
				<td class="text-right"><input type="text" name="memberNo" value="<%=memberNo%>" readonly="readonly"></td>
			</tr>
		</table>
		<button id="NoticeBtn" type="button" class="btn btn-outline-info">Qna게시글 추가</button>
	</form>
	<script>
	$('#NoticeBtn').click(function(){
        // 버턴을 click했을때
        if($('#qnaTitle').val() == '') { // qnaTitle 공백이면
           alert('qnaTitle를 입력하세요');
           return;
        } else if($('#qnaContent').val() == '') { // qnaContent 공백이면
           alert('qnaContent를 입력하세요');
           return;
        } else {
           $('#insertQnaForm').submit(); // <button type="button"> -> <button type="submit">
        }
     });
	</script>
	</div>
</div>
</body>
</html>