<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
	int orderNo =  Integer.parseInt(request.getParameter("orderNo"));
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	
	
	System.out.println(orderNo+ "<-- orderNo");
	System.out.println(ebookNo+ "<-- ebookNo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ebook 후기</title>
</head>
<body>
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
		<!-- submenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
	<h1>Ebook 후기 작성</h1>
	
	<form id="CommentForm" action="<%=request.getContextPath() %>/insertOrderCommentAction.jsp" meyhod="post">
	<td><input type="hidden" name="orderNo" value="<%=orderNo%>" readonly="readonly"></td>
	<td><input type="hidden" name="ebookNo" value="<%=ebookNo%>" readonly="readonly"></td>
		<table border="1">
			<tr>
				<td>10점 만점에 몇점?</td>
				
				<td><select id="orderScore" class="orderScore" name="orderScore">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
					<option value="6">6</option>
					<option value="7">7</option>
					<option value="8">8</option>
					<option value="9">9</option>
					<option value="10">10</option>
				</select></td>
			</tr>
			<tr>
				<td>후기 내용</td>
				<td><textarea id="orderCommentContent" name="orderCommentContent" rows="5" cols="50"></textarea></td>
			</tr>
		</table>
		<button id="CommentBtn" type="button">작성하기</button>
	</form>

	<script>
	$('#CommentBtn').click(function() {
		if($('#orderCommentContent').val() == '') { // orderCommentContent가 공백이면
			alert('orderCommentContent를 입력하세요');
            return;
		} else{
			$('#CommentForm').submit();
		}
	});
	</script>
</body>
</html>