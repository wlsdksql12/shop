<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<div class="container">
	<div class="container p-3 my-3 border">
	<!-- 관리자 메뉴 include -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<div class="jumbotron">
		<h1>관리자페이지</h1>
	</div>
	<div><%=loginMember.getMemberId()%>님 반갑습니다.</div>
	
	<div class="jumbotron">
		<h2>최신 공지사항</h2>
	</div>
	<%
		//최신 공지사항 5개
		NoticeDao noticeDao = new NoticeDao();
		ArrayList<Notice> newNoticeList = noticeDao.newNoticeList();
	%>
	
	<tr class="border-bottom font-weight-bold">
	<%
	for(Notice n : newNoticeList) {
	%>
	<td class="text-right">
		<div><a href="<%=request.getContextPath()%>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></div>
	</td>
	<%
	}
	%>
	</tr>
	
	<div class="jumbotron">
		<h2>답변 미등록 QnA게시글</h2>
	</div>
	<%
		QnaDao qnaDao = new QnaDao();
	ArrayList<Qna> newQnaList = qnaDao.newQnaList();
	
	for(Qna q : newQnaList) {
	%>
	<div><a href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>"><%=q.getQnaTitle()%></a></div>
	<%
	}
	%>
	</div>
</div>
</body>
</html>