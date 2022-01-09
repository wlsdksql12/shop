<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답변글 작성</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div class="container p-3 my-3 border">
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
	<form id="insertQnaCommentForm" action="<%=request.getContextPath() %>/admin/insertQnaCommentAction.jsp">
	<td><input type="hidden" name="qnaNo" value="<%=qnaNo%>"></td>
	<td><input type="hidden" name="memberNo" value="<%=memberNo%>"></td>
		<table class="table table-borderless table-hover" meyhod="post">
			<tr class="border-bottom font-weight-bold">
				<td class="text-right">QnaCommentContent</td>
				<td class="text-right"><textarea id="qnaCommentContent" name="qnaCommentContent" rows="5" cols="50"></textarea></td>
			</tr>
		</table>
		<button class="btn btn-outline-info" id="CommentBtn" type="submit">답변글 작성</button>
	</form>
	<script>
	$('#CommentBtn').click(function(){
        // 버턴을 click했을때
        if($('#qnaCommentContent').val() == '') { // qnaCommentContent 공백이면
           alert('qnaCommentContent를 입력하세요');
           return;
        } else {
           $('#insertQnaCommentForm').submit(); // <button type="button"> -> <button type="submit">
        }
     });
	</script>
	</div>
</div>
</body>
</html>