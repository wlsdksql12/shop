<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");

	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	System.out.println(ebookNo + "<--selectEbookOne.jsp.ebookNo");
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
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<form id="updateEbookPrice" action="<%=request.getContextPath()%>/admin/updateEbookPriceAction.jsp">
		<input type="hidden" name="ebookNo" value=<%=ebookNo%>>
		<table class="table table-borderless table-hover">
			<tr class="border-bottom font-weight-bold">
				<td class="text-center">수정할 가격을 입력해주세요. : </td>
				<td class="text-center"><input id="newEbookPrice" type="text" name="newEbookPrice"></td>
			</tr>
		</table>
		<button class="btn btn-outline-info" id="updateEbookPriceBtn" type="button">가격 수정하기</button>
	</form>
	<script>
	$('#updateEbookPriceBtn').click(function(){
        // 버턴을 click했을때
        if($('#newEbookPrice').val() == '') { // newEbookPrice 공백이면
           alert('newEbookPrice를 입력하세요');
           return;
        } else {
           $('#updateEbookPrice').submit(); // <button type="button"> -> <button type="submit">
        }
     });
	</script>
	</div>
</div>
</body>
</html>