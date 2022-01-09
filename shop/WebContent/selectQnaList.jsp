<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	Member loginMember = (Member)session.getAttribute("loginMember");
	Member member = new Member();
	if(loginMember == null) {
		member.setMemberNo(0);
	} else {
		member.setMemberNo(loginMember.getMemberNo());
	}
	
	QnaDao qnaDao = new QnaDao();
	ArrayList<Qna> QnaList = qnaDao.selectQnaList();
	
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
	QnaList = qnaDao.selectQnaByPage(beginRow, ROW_PER_PAGE);
	
	// 마지막 페이지(lastPage)를 구하는 orderCommentDao의 메서드 호출
	// int 타입의 lastPage에 저장
	// 전체 행을 COUNT 하는 selectCommentListLastPage메서드 호출
	int lastPage = qnaDao.selectQnaByLastPage(ROW_PER_PAGE, member.getMemberNo());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div class="container p-3 my-3 border">
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<div class="jumbotron">
		<h1>[QnA게시판 관리]</h1>
	</div>
	<a class="btn btn-outline-info" href="<%=request.getContextPath() %>/insertQnaForm.jsp">QnA 추가</a>
	<table class="table table-borderless table-hover">
		<thead>
			<tr class="border-bottom font-weight-bold">
			 	<th class="text-right">QnA_No</th>
			 	<th class="text-right">member_No</th>
			 	<th class="text-right">QnA_Categroy</th>
			 	<th class="text-right">QnA_Title</th>
			 	<th class="text-right">QnA_Secret</th>
			 	<th class="text-right">createDate</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(Qna q : QnaList) {
		%>
			<tr class="border-bottom font-weight-bold">
			 	<td class="text-right"><%=q.getQnaNo()%></td>
			 	<td class="text-right"><%=q.getMemberNo()%></td>
		 		<td class="text-right"><%=q.getQnaCategroy()%></td>
		 		<%
					if(loginMember == null && q.getQnaSecret().equals("Y")) {
		 		%>
		 			<td class="text-right"><a href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>"><%=q.getQnaTitle()%></a></td>
		 		<%
					} else if(member.getMemberNo() == 1) {
				%>
					<td class="text-right"><a href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>"><%=q.getQnaTitle()%></a></td>
				<%
		 			} else if(member.getMemberNo() != q.getMemberNo() && q.getQnaSecret().equals("N")) {
		 		%>
		 			<td class="text-right"><%=q.getQnaTitle()%></td>
		 		<%
		 			} else {		
		 		%>
		 			<td class="text-right"><a href="<%=request.getContextPath()%>/selectQnaOne.jsp?qnaNo=<%=q.getQnaNo()%>"><%=q.getQnaTitle()%></a></td>
		 		<%
		 			}
		 		%>
		 		
		 		<td class="text-right"><%=q.getQnaSecret()%></td>
		 		<td class="text-right"><%=q.getCreateDate()%></td>
		 	</tr>
		<%
			}
		%>
		</tbody>
		</table>
		<%
			if(currentPage > 1){
		%>
				<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/selectQnaList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
		%>
		
		<%
			if(currentPage < lastPage){
		%>
				<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/selectQnaList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}
		%>
	</div>
</div>
</body>
</html>