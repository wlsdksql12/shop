<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	// 방어코드
	if(request.getParameter("memberNo") == null) {
		response.sendRedirect("./selectMemberList.jsp?currentPage=1");
		return;
	}

	// encoding
	request.setCharacterEncoding("utf-8");

	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	// debug
	System.out.println("debug " + memberNo + " <-- memberNo");
	
	// dao
	MemberDao memberDao = new MemberDao();
	
	Member member = memberDao.selectMemberOne(memberNo);
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
<body>
<div class="container">
	<!-- start : 관리자 adminMenu include -->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include>
	</div>
	<!-- end : 관리자 adminMenu include -->
	
	<form id="updateMemberLevel" method="post" action="./updateMemberLevelAction.jsp">
		<div class="container p-3 my-3 border">
			<div class="jumbotron">
			  <h1>관리자 페이지 - 회원등급 수정</h1>
			</div>
		
				<table class="table table-borderless table-hover">
						<tr class="border-bottom font-weight-bold">
							<th class="text-right">memberNo</th>
							<td><input type="text" class="text-center" name="memberNo" value="<%=member.getMemberNo() %>" readonly="readonly"></td>					
						</tr>
						<tr class="border-bottom font-weight-bold">					
							<th class="text-right">memberId</th>
							<td><input type="text" class="text-center" name="memberId" value="<%=member.getMemberId() %>" readonly="readonly"></td>					
						</tr>
						<tr class="border-bottom font-weight-bold">					
							<th class="text-right">memberPw</th>
							<td><input type="text" class="text-center" name="memberPw" value="<%=member.getMemberPw() %>" readonly="readonly"></td>					
						</tr>
						<tr class="border-bottom font-weight-bold">					
							<th class="text-right">memberLevel</th>
								<%
									String memberLevel0 = null;
									String memberLevel1 = null;
									if(member.getMemberLevel() == 0) {
										memberLevel0 = "checked";
									} else if(member.getMemberLevel() == 1) {
										memberLevel1 = "checked";
									}
								%>
							<td>
								<select name="memberLevel">
									<option value="0" <%=memberLevel0 %>>0 (일반회원)</option>
									<option value="1" <%=memberLevel1 %>>1 (관리자)</option>
								</select>
							</td>					
						</tr>
						<tr class="border-bottom font-weight-bold">					
							<th class="text-right">memberName</th>
							<td><input type="text" class="text-center" name="memberName" value="<%=member.getMemberName() %>" readonly="readonly"></td>					
						</tr>
						<tr class="border-bottom font-weight-bold">					
							<th class="text-right">memberAge</th>
							<td><input type="text" class="text-center" name="memberAge" value="<%=member.getMemberAge() %>" readonly="readonly"></td>					
						</tr>
						<tr class="border-bottom font-weight-bold">					
							<th class="text-right">memberGender</th>
							<td><input type="text" class="text-center" name="memberGender" value="<%=member.getMemberGender() %>" readonly="readonly"></td>					
						</tr>
						<tr class="border-bottom font-weight-bold">					
							<th class="text-right">updateDate</th>
							<td><input type="text" class="text-center" name="updateDate" value="<%=member.getUpdateDate() %>" readonly="readonly"></td>				
						</tr>
						<tr class="border-bottom font-weight-bold">				
							<th class="text-right">createDate</th>
							<td><input type="text" class="text-center" name="createDate" value="<%=member.getCreateDate() %>" readonly="readonly"></td>
						</tr>
				</table>
		</div>
				
		<div class="text-center">
			<button type="submit" class="btn btn-outline-info">수정</button>
			<a class="btn btn-outline-info" href="<%=request.getContextPath() %>/admin/selctMemberOne.jsp??memberNo=<%=member.getMemberNo() %>">취소</a>
		</div>
	</form>
</div>
</body>
</body>
</html>