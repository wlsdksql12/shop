<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*"%>
<%
	Member loginMember = (Member)session.getAttribute("loginMember");
	if(loginMember == null) {
		response.sendRedirect(request.getContextPath()+"/index.jsp");
		return;
	} 
	System.out.println(loginMember.getMemberNo() + "<-- loginMember.getMemberNo()");

	OrderDao orderDao = new OrderDao();
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의 주문 목록</title>
</head>
<body>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<!-- 관리자 메뉴 include -->
	<div class="container">
	<div class="container p-3 my-3 border">
	<div>
		<!-- ./같은위치/partial폴더/submenu.jsp(webContent,상대주소) , /shop/partial/submenu.jsp(프로젝트기준,절대주소),/partial/submenu.jsp(절대주소)-->
		<jsp:include page="/partial/mainMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<div class="jumbotron">
		<h1>나의 주문 목록</h1>
	</div>
	
		<%
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
		
		ArrayList<OrderEbookMember> orderList = new ArrayList<>();
		ArrayList<OrderEbookMember> list = orderDao.selectOrderListByMember(beginRow, ROW_PER_PAGE, memberNo);
		
		System.out.println(memberNo +"<-- memberNo");
		
		// 마지막 페이지(lastPage)를 구하는 orderCommentDao의 메서드 호출
		// int 타입의 lastPage에 저장
		// 전체 행을 COUNT 하는 selectCommentListLastPage메서드 호출
		int lastPage = orderDao.selectOrderListPage(ROW_PER_PAGE, memberNo);
		
		// 화면에 보여질 페이지 번호의 갯수
		int displayPage = 10;
		
		// 화면에 보여질 시작 페이지 번호
		// ((현재페이지번호 - 1) / 화면에 보여질 페이지 번호) * 화면에 보여질 페이지 번호 + 1
		// (currentPage - 1)을 하는 이유는 현재페이지가 10일시에도 startPage가 1이기 위해서
		int startPage = ((currentPage - 1) / displayPage) * displayPage + 1;
			
		// 화면에 보여질 마지막 페이지 번호
		// 만약에 마지막 페이지 번호(lastPage)가 화면에 보여질 페이지 번호(displayPage)보다 작다면 화면에 보여질 마지막 페이지번호(endPage)를 조정한다
		// 화면에 보여질 시작 페이지 번호 + 화면에 보여질 페이지 번호 - 1
		// -1을 하는 이유는 페이지 번호의 갯수가 10개이기 때문에 statPage에서 더한 1을 빼준다
		int endPage = 0;
		if(lastPage<displayPage){
			endPage = lastPage;
		} else if (lastPage>=displayPage){
			endPage = startPage + displayPage - 1;
		}
		%>
	<table class="table table-borderless table-hover">
		<thead>
			<tr class="border-bottom font-weight-bold">
				<th class="text-right">orderNo</th>
				<th class="text-right">ebookTItle</th>
				<th class="text-right">orderPeice</th>
				<th class="text-right">createDate</th>
				<th class="text-right">memberId</th>
				<th class="text-right">상세주문내역</th>
				<th class="text-right">ebook후기</th>
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
					<td class="text-right"><a href="<%=request.getContextPath()%>/selectEbookOne.jsp?ebookNo=<%=oem.getEbook().getEbookNo()%>">상세주문내역</a></td>
					<%
						if(orderDao.selectOrderCommentCheck(oem.getOrder().getOrderNo(), oem.getEbook().getEbookNo()) == 0) {
					%>
					<td class="text-right"><a href="<%=request.getContextPath()%>/insertOrderCommentForm.jsp?orderNo=<%=oem.getOrder().getOrderNo()%>&ebookNo=<%=oem.getEbook().getEbookNo()%>">ebook후기작성</a></td>
					<%
						} else {
					%>
					<td class="text-right">ebook후기작성완료</td>
					<%
						}
					%>
				</tr>
		<%
			}	
		%>
		</tbody>
	</table>
		<%
			if(currentPage > 1){
		%>
				<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/selectOrderListByMember.jsp?currentPage=<%=currentPage-1%>&memberNo=<%=memberNo%>">이전</a>
		<%
			}
		%>
		
		<%
			if(currentPage < lastPage){
		%>
				<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/selectOrderListByMember.jsp?currentPage=<%=currentPage+1%>&memberNo=<%=memberNo%>">다음</a>
		<%
			}
		%>
</div>
</div>
</body>
</html>