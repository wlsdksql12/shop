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
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>여기에 제목을 입력하십시오</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<h1>카테고리 추가</h1>
	
	<%
		String categoryCheckResult = "";
		if(request.getParameter("categoryCheckResult") != null){
			categoryCheckResult = request.getParameter("categoryCheckResult");
		}
		String categoryNameCheck = "";
		if(request.getParameter("categoryNameCheck") != null){
			categoryNameCheck = request.getParameter("categoryNameCheck");
		}
	%>
	<form id="CategoryNameCheckForm" action="<%=request.getContextPath() %>/admin/selectCategoryNameCheckAction.jsp" method="post">
			<div>중복 검사</div>
			<div>
				<input id="categoryNameCheck" type="text" name="categoryNameCheck"> 
				<button id="NameCheck" type="button">중복 검사</button> 
			<%
				if(!categoryCheckResult.equals("")){
			%>
					<%=request.getParameter("categoryCheckResult") %>
			<%
				}
			%>
			</div>
		</form>
		<script>
		$('#NameCheck').click(function() {
			if($('#categoryNameCheck').val == '') { // categoryNameCheck가 공백이면
				 alert('categoryNameCheck를 입력하세요');
		         return;
			} else {
				$('#CategoryNameCheckForm').submit(); // <button type="button"> -> <button type="submit">
			}
		});
		</script>
	<form method="post" action="<%=request.getContextPath() %>/admin/insertCategoryAction.jsp">
		<div>추가할 카테고리</div>
		<div><input type="text" name="categoryName"  value="<%=categoryNameCheck%>" readonly></div>
		<div><button type="submit">추가</button></div>
	</form>
	
</body>
</html>