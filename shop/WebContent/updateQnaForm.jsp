<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
	System.out.println(qnaNo + "<-- qnaNo");
	System.out.println(memberNo + "<-- memberNo");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div class="container p-3 my-3 border">
	<form id="updateQnaForm" action="<%=request.getContextPath()%>/updateQnaAction.jsp">
		<div><input type="hidden" name="qnaNo" value=<%=qnaNo%>></div>
		<div><input type="hidden" name="memberNo" value=<%=memberNo%>></div>
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
				<td class="text-right">QnA secret</td>
				<td class="text-right">
					<select name="qnaSecret">
						<option value="Y">YES</option>
						<option value="N">NO</option>
					</select>
				</td>
			</tr>
		</table>
		<button class="btn btn-outline-info" id="updateQna" type="button">Qna 수정</button>
	</form>
	<script>
		$('#updateQna').click(function() {
			//버튼을 click했을때
			if($('#qnaTitle').val() == '') { // qnaTitle 공백이면
				alert('qnaTitle를 입력하세요');
				return;
			} else if($('#qnaContent').val() == '') { // qnaContent 공백이면
				alert('qnaContent를 입력하세요');
				return;
			} else {
				$('#updateQnaForm').submit(); // <button type="button"> -> <button type="submit">
			}
		});
	</script>
	</div>
</div>
</body>
</html>