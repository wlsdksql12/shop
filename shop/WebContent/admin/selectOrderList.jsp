<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null || loginMember.getMemberLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
	
	System.out.println(loginMember.getMemberNo() + "<-- loginMember.getMemberNo()");
	
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	final int ROW_PER_PAGE = 10; // rowPerPage변수 10으로 초기화되면 끝까지 10을 써야 한다. --> 상수

	int beginRow = (currentPage - 1) * ROW_PER_PAGE;	
	
	OrderDao orderDao = new OrderDao();
	ArrayList<OrderEbookMember> list = orderDao.selectOrderList(beginRow, ROW_PER_PAGE);
	
	// 마지막 페이지(lastPage)를 구하는 orderCommentDao의 메서드 호출
	// int 타입의 lastPage에 저장
	// 전체 행을 COUNT 하는 selectCommentListLastPage메서드 호출
	int lastPage = orderDao.selectOrderListLastPage(ROW_PER_PAGE);
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
	<table class="table table-borderless table-hover">
		<thead>
			<tr class="border-bottom font-weight-bold">
				<th class="text-right">orderNo</th>
				<th class="text-right">ebookTItle</th>
				<th class="text-right">orderPeice</th>
				<th class="text-right">createDate</th>
				<th class="text-right">memberId</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(OrderEbookMember oem : list) {
		%>
				<tr class="border-bottom font-weight-bold">
					<td class="text-right"><%=oem.getOrder().getOrderNo()%></td>
					<td class="text-right"><%=oem.getEbook().getEbookTitle()%></td>
					<td class="text-right"><%=oem.getOrder().getOrderPrice()%></td>
					<td class="text-right"><%=oem.getOrder().getCreateDate()%></td>
					<td class="text-right"><%=oem.getMember().getMemberId()%></td>
				</tr>
		<%
			}	
		%>
		</tbody>
	</table>
		<%
			if(currentPage > 1){
		%>
				<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=currentPage-1%>">이전</a>
		<%
			}
		%>
		
		<%
			if(currentPage < lastPage){
		%>
				<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/admin/selectOrderList.jsp?currentPage=<%=currentPage+1%>">다음</a>
		<%
			}
		%>
	</div>
</div>
</body>
</html>