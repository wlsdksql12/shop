<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%	
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	//사용자(일반 회원)들 리스트는 관리자만 출입
	//방어코드
	Member loginMember = (Member)session.getAttribute("loginMember");
	//로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가. 순서를 바꾸면안됨(바꾸면 null포인트 인셉션이 일어남).
	if(loginMember==null || loginMember.getMemberLevel() < 1){
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	}
	
	NoticeDao noticeDao = new NoticeDao();
	ArrayList<Notice> NoticeList = noticeDao.selectNoticeList();
	
	int memberNo = loginMember.getMemberNo();
	// 페이징
	// 페이지번호 = 전달 받은 값이 없으면 currentPage를 1로 디폴트
	int currentPage = 1;
	// current가 null이 아니라면 값을 int 타입으로로 바꾸어서 페이지 번호로 사용
	if(request.getParameter("currentPage") != null) { 
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	// 디버깅
	System.out.println("currentPage(현재 페이지 번호) : "+currentPage);
	
	// limit 값 설정 beginRow부터 rowPerPage만큼 보여주세요
	// ROW_PER_PAGE 변수를 상수로 설정하여서 10으로 초기화하면 끝까지 10이다.
	final int ROW_PER_PAGE = 10;
	int beginRow = (currentPage-1) * ROW_PER_PAGE;
	
	ArrayList<Notice> noticeList = new ArrayList<Notice>();
	noticeList = noticeDao.selectNoticeListByPage(beginRow, ROW_PER_PAGE);
	
	// 마지막 페이지(lastPage)를 구하는 orderCommentDao의 메서드 호출
	// int 타입의 lastPage에 저장
	// 전체 행을 COUNT 하는 selectCommentListLastPage메서드 호출
	int lastPage = noticeDao.selectNoticeListByLastPage(ROW_PER_PAGE, memberNo);
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
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<div class="jumbotron">
		<h1>[QnA게시판 관리]</h1>
	</div>
	<a class="btn btn-outline-info" href="insertNoticeForm.jsp">공지사항 추가</a>
	<table class="table table-borderless table-hover">
		<thead>
			<tr class="border-bottom font-weight-bold">
			 	<th class="text-right">noticeNo</th>
			 	<th class="text-right">noticeTitle</th>
			 	<th class="text-right">noticeContent</th>
			 	<th class="text-right">memberNo</th>
			 	<th class="text-right">createDate</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Notice n : noticeList) {
			%>
				<tr class="border-bottom font-weight-bold">
				 	<td class="text-right"><%=n.getNoticeNo()%></td>
				 	<td class="text-right"><%=n.getNoticeTitle()%></td>
				 	<td class="text-right"><%=n.getNoticeContent()%></td>
				 	<td class="text-right"><%=n.getMemberNo()%></td>
				 	<td class="text-right"><%=n.getCreateDate()%></td>
				 	<td class="text-right">
					<!-- 공지 게시글 수정 -->
					<a href="<%=request.getContextPath()%>/admin/updateNoticeForm.jsp?memberNo=<%=n.getMemberNo()%>&noticeNo=<%=n.getNoticeNo()%>">수정</a>
					</td>
					<td class="text-right">
					<!-- 공지 게시글 삭제 -->
					<a  href="<%=request.getContextPath()%>/admin/deleteNotice.jsp?memberNo=<%=n.getMemberNo()%>&noticeNo=<%=n.getNoticeNo()%>">삭제</a>
					</td>
				</tr>
			<%
				}
			%>
		</tbody>
		</table>
		<%
			
			if(currentPage > 1){
		%>
				<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
		%>
		
		<%
			if(currentPage < lastPage){
		%>
				<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/admin/selectNoticeList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}
		%>
	</div>
</div>
</body>
</html>