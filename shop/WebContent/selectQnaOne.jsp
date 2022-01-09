<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	Member loginMember = (Member)session.getAttribute("loginMember");
	Member m = new Member();
	if(loginMember == null) {
		m.setMemberNo(0);
	} else {
		m.setMemberNo(loginMember.getMemberNo());
	}
	
	int QnaNo = Integer.parseInt(request.getParameter("qnaNo"));

	QnaDao qnaDao = new QnaDao();
	Qna qna = new Qna();
	qna =  qnaDao.selectQnaOne(QnaNo);
	System.out.println(qna.getMemberNo() + "qna.getMemberNo()");
	QnaComment qnaComment = new QnaComment();
	qnaComment = qnaDao.selectQnaComment(qna);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 상세보기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div class="container p-3 my-3 border">
	<div class="jumbotron">
		<h2>QnA 상세보기</h2>
	</div>
	<table class="table table-borderless table-hover">
		<tr class="border-bottom font-weight-bold">
			<td class="text-right">qnaNo</td>
			<td class="text-right"><%=qna.getQnaNo()%></td>
		</tr>
		<tr class="border-bottom font-weight-bold">
			<td class="text-right">qnaCategroy</td>
			<td class="text-right"><%=qna.getQnaCategroy()%></td>
		</tr>
		<tr class="border-bottom font-weight-bold">
			<td class="text-right">qnaTitle</td>
			<td class="text-right"><%=qna.getQnaTitle()%></td>
			<%
			if(qna.getMemberNo() == m.getMemberNo() || m.getMemberNo() == 1) {
			%>
			<td class="text-right"><a class="btn btn-outline-info" href="<%=request.getContextPath()%>/updateQnaForm.jsp?memberNo=<%=qna.getMemberNo()%>&qnaNo=<%=qna.getQnaNo()%>">수정</a></td>
			<td class="text-right"><a class="btn btn-outline-info" href="<%=request.getContextPath()%>/deleteQna.jsp?memberNo=<%=qna.getMemberNo()%>&qnaNo=<%=qna.getQnaNo()%>">삭제</a></td>
			<%
			}
			%>
			
			
		</tr>
		<tr class="border-bottom font-weight-bold">
			<td class="text-right">qnaContent</td>
			<td class="text-right"><%=qna.getQnaContent()%></td>
		</tr>
		<tr class="border-bottom font-weight-bold">
			<td class="text-right">qnaSecret</td>
			<td class="text-right"><%=qna.getQnaSecret()%></td>
		</tr>
		<tr class="border-bottom font-weight-bold">
			<td class="text-right">createDate</td>
			<td class="text-right"><%=qna.getCreateDate()%></td>
		</tr>
	</table>
		<div class="text-right"><a class="btn btn-outline-info" href="<%=request.getContextPath()%>/admin/insertQnaCommentForm.jsp?qnaNo=<%=qna.getQnaNo()%>&memberNo=<%=qna.getMemberNo()%>">답변글 작성</a></div>
	<div class="jumbotron">
		<h2>답변글</h2>
	</div>
	<%
		if(qnaComment == null) {
	%>
		<div class="border-bottom font-weight-bold">답변글을 작성해주세요.</div>	
	<%
		} else {
	%>
		<div class="border-bottom font-weight-bold"><%=qnaComment.getQnaCommentContent()%></div>
	<%
		}
	%>
	</div>
</div>
</body>
</html>