<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<!-- submenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
	<div class="container">
	<div class="container p-3 my-3 border">
	<div class="jumbotron">
		<h1>회원가입</h1>
	</div>
	
		<%
			String memberIdCheck = "";
			if(request.getParameter("memberIdCheck") != null) {
				memberIdCheck = request.getParameter("memberIdCheck");
			}
		%>
		
		<div><%=request.getParameter("idCheckResult") %></div> <!-- null or 이미사용중인아이디입니다 -->
			
		<!-- 멤버아이디가 사용가능한지 확인 폼 -->
		<form action="<%=request.getContextPath()%>/selectMemberIdCheckAction.jsp" method="post">
			<div class="border-bottom font-weight-bold">
				회원아이디 :
				<input  type="text" name="memberIdCheck">
				<button class="btn btn-outline-info" type="submit">아이디 중복 검사</button>
			</div>
		</form>
		
		<!-- 회원가입 폼 -->
		<form id="joinForm" action="<%=request.getContextPath()%>/insertMemberAction.jsp" method="post">
			<table class="table table-borderless table-hover">
				<tr class="border-bottom font-weight-bold">
					<td class="text-right">회원아이디</td>
					<td><input class="text-center" type="text" id="memberId" name="memberId" readonly="readonly" value="<%=memberIdCheck%>"></td>
				</tr>
				<tr class="border-bottom font-weight-bold">
					<td class="text-right">회원비밀번호</td>
					<td><input class="text-center" type="password" id="memberPw" name="memberPw"></td>
				</tr>
				<tr class="border-bottom font-weight-bold">
					<td class="text-right">회원이름</td>
					<td><input class="text-center" type="text" id="memberName" name="memberName"></td>
				</tr>
				<tr class="border-bottom font-weight-bold">
					<td class="text-right">회원나이</td>
					<td><input class="text-center" type="text" id="memberAge" name="memberAge"></td>
				</tr>
				<tr class="border-bottom font-weight-bold">
					<td class="text-right">성별</td>
					<td>
						<input class="text-center" type="radio" class="memberGender" name="memberGender" value="남">남
						<input class="text-center" type="radio" class="memberGender" name="memberGender" value="여">여
					</td>
				</tr>
			</table>
			</div>
			<div class="text-center">
				<button class="btn btn-outline-info" id="btn" type="button">입력</button>
			</div>
		</form>
	</div>
	<script>
		$('#btn').click(function(){
		if($('#memberId').val() == ''){
			alert('memberId를 입력하세요');
			return;
			}
		if($('#memberPw').val() == ''){
			alert('memberPw를 입력하세요');
			return;
			}
		if($('#memberName').val() == ''){
			alert('memberName를 입력하세요');
			return;
			}
		if($('#memberAge').val() == ''){
			alert('memberAge를 입력하세요');
			return;
			}
			
			let memberGender = $('.memberGender:checked'); // . 클래스속성으로 부르면 리턴값은 배열
			if(memberGender.length == 0) {
				alert('memberGender를 선택히세요');
				return;
			}
			
			$('#joinForm').submit();
		});
	</script>
</body>
</html>