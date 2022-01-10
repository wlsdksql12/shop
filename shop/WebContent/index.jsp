<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class = "container_fluid p-3 my-3  bg-dark text-white">
	<!-- submenu 인클루드(include) 시작 -->
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- submenu 인클루드 끝 -->
	<div>
	<div class="jumbotron">
		<h1 style="color: black">index</h1>
	</div>
	
		<!-- 로그인 작업 -->
			<%
				if(session.getAttribute("loginMember") == null) {
			%>
					<div><a href="<%=request.getContextPath() %>/loginForm.jsp" class="btn btn-outline-info">로그인</a></div>
					<div><a href="<%=request.getContextPath() %>/insertMemberForm.jsp" class="btn btn-outline-info">회원가입</a></div>
			<%		
				} else {
					Member loginMember = (Member)session.getAttribute("loginMember");
			%>
				<!-- 로그인 -->
				<div><%=loginMember.getMemberId()%>님 반갑습니다.</div>
				<div><a href="<%=request.getContextPath() %>/logout.jsp">로그아웃</a></div>
				<div><a href="<%=request.getContextPath() %>">회원정보</a></div>
				<div><a href="<%=request.getContextPath() %>/selectOrderListByMember.jsp?memberNo=<%=loginMember.getMemberNo()%>">나의 주문</a></div>
				<!-- 관리자 페이지로 가는 링크 -->
			<%
					if(loginMember.getMemberLevel() > 0) {
			%>
						<div><a href="<%=request.getContextPath()%>/admin/adminIndex.jsp">관리자 페이지</a></div>
			<%
					}
				}
			%>
	</div>
	<!-- 상품 목록 -->
	<%
		// 페이징
		int currentPage = 1;
		if (request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
		
		final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수
	
		int beginRow = (currentPage - 1) * ROW_PER_PAGE;	
		
		EbookDao ebookDao = new EbookDao();
		NoticeDao noticeDao = new NoticeDao();
		ArrayList<Ebook> ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);
	
		// 인기 상품 목록 5개
		ArrayList<Ebook> popularebookList = ebookDao.selectpopularebookList();
		
		// 신상품 목록 5개
		ArrayList<Ebook> newebookList = ebookDao.selectnewebookList();
		
		//최신 공지사항 5개
		ArrayList<Notice> newNoticeList = noticeDao.newNoticeList();
	%>
	
	<h2>최신 공지사항</h2>
		<tr>
		<%
		for(Notice n : newNoticeList) {
		%>
		<td>
			<div><a href="<%=request.getContextPath()%>/selectNoticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></div>
		</td>
		<%
		}
		%>
		</tr>
	<h2>신상품 목록</h2>
	<table border="1">
		<tr>
		<%
		for(Ebook e: newebookList) {
		%>
			<td>
				<div>
				<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>">
				<img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a>
				</div>
				<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
				<div>₩ <%=e.getEbookPrice()%></div>
			</td>
		<%
		}
		%>
		</tr>
	</table>
	
	<h2>인기 상품 목록</h2>
	<table border="1">
		<tr>
		<%
		for(Ebook e: popularebookList) {
		%>
			<td>
				<a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>">
				<div><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a></div>
				<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
				<div>₩ <%=e.getEbookPrice()%></div>
			</td>
		<%
		}
		%>
		</tr>
	</table>
	
	<h2>전체 상품 목록</h2>
	<table border="1">
	<tr>
		<%
			int i = 0;
			for(Ebook e : ebookList) {
		%>

					<td>
						<div><a href="<%=request.getContextPath()%>/se
						lectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><img src="<%=request.getContextPath()%>/image/<%=e.getEbookImg()%>" width="200" height="200"></a></div>
						<div><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></div>
						<div>₩ <%=e.getEbookPrice()%></div>
					</td>
		<%	
					i+=1; //for문이 끝날때마다 i는 1씩 증가
					if(i%5 == 0) {
		%>
						<tr></tr>
		<%
					}
			}
		%>
	</tr>
	</table>
</div>
</body>
</html>
