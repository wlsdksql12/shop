<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<%
	//한글인코딩
	request.setCharacterEncoding("utf-8");
	//사용자(일반 회원)들 리스트는 관리자만 출입
	//방어코드
	Member loginMember = (Member) session.getAttribute("loginMember");
	//로그인 멤버값이 없거나 memberLevel이 1미만(일반 사용자)일때는 접근 불가. 순서를 바꾸면안됨(바꾸면 null포인트 인셉션이 일어남).
	if (loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}

	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();

	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("[Debug] currentPage : " + currentPage);

	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수

	int beginRow = (currentPage - 1) * ROW_PER_PAGE;

	String categoryName = "";

	if (request.getParameter("categoryName") != null) {
		categoryName = request.getParameter("categoryName");
	}

	// 카테고리별 목록 받아오기
	EbookDao ebookDao = new EbookDao();
	ArrayList<Ebook> ebookList = null;

	if (categoryName.equals("") == true) {
		ebookList = ebookDao.selectEbookList(beginRow, ROW_PER_PAGE);
	} else {
		ebookList = ebookDao.selectEbookListByCategory(beginRow, ROW_PER_PAGE, categoryName);
	}
	%>
<div class="container">
	<div class="container p-3 my-3 border">
	<!-- 관리자 메뉴 인클루드(include)시작 ,페이지 형태만 인클루드 하는 것이 좋음(코드 형태는 비추천).-->
	<div>
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<div class="jumbotron">
		<h1>[전자책 관리]</h1>
	</div>
	<form action="<%=request.getContextPath()%>/admin/selectEbookList.jsp">
		<select class="text-right" name="categoryName">
			<option value="">전체목록</option>
			<%
			for (Category c : categoryList) {
			%>
				<option value="<%=c.getCategoryName()%>"><%=c.getCategoryName()%></option>
			<%
			}
			%>
		</select>
		<button class="btn btn-outline-info" type="submit">전자책목록</button>
	</form>

	<!-- 전자책 목록 출력 : 카테고리별 출력 -->
	<!-- 전자책 목록 출력 : 카테고리별 출력 -->
	<div>
		<table class="table table-borderless table-hover">
			<thead>
				<tr class="border-bottom font-weight-bold">
					<th class="text-right">ebookNo</th>
					<th class="text-right">ebookTitle</th>
					<th class="text-right">categoryName</th>
					<th class="text-right">ebookState</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (Ebook e : ebookList) {
				%>
				<tr class="border-bottom font-weight-bold">
					<td class="text-right"><%=e.getEbookNo()%></td>
					<td class="text-right"><a href="<%=request.getContextPath()%>/admin/selectEbookOne.jsp?ebookNo=<%=e.getEbookNo()%>"><%=e.getEbookTitle()%></a></td>
					<td class="text-right"><%=e.getCategoryName()%></td>
					<td class="text-right"><%=e.getEbookState()%></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>

		<!-- 하단 네비게이션 바 -->
		<div>
			<a class="btn btn-outline-info"
				href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=1&category=<%=categoryName%>">처음으로</a>
			<%
			if (currentPage != 1) {
			%>
			<a class="btn btn-outline-info"
				href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=currentPage - 1%>&category=<%=categoryName%>">이전</a>
			<%
			}

			int lastPage = ebookDao.selectEbookLastPage(10, categoryName);

			int displayPage = 10;

			int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
			int endPage = startPage + displayPage - 1;

			for (int i = startPage; i <= endPage; i++) {
				if (endPage <= lastPage) {
				%>
					<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=i%>&category=<%=categoryName%>"><%=i%></a>
				<%
				} else if (endPage > lastPage) {
				%>
					<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=i%>&category=<%=categoryName%>"><%=i%></a>
				<%
				}
				
				if (i == lastPage) {
					break;
				}
			}
			if (currentPage != lastPage) {
			%>
				<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=currentPage + 1%>&category=<%=categoryName%>">다음</a>
			<%
			}
			%>
			<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/admin/selectEbookList.jsp?currentPage=<%=lastPage%>&category=<%=categoryName%>">끝으로</a>
		</div>
	</div>
	</div>
</div>
</body>
</html>
