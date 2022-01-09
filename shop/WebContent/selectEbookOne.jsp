<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
   int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상품상세보기(주문가능)</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div class="container p-3 my-3 border">
   <div class="jumbotron">
		<h1>상품상세보기</h1>
	</div>
   <div>
      <!-- 상품상세출력 -->
      <%
         EbookDao ebookDao = new EbookDao();
      Ebook ebook = ebookDao.selectEbookOne(ebookNo);
      %>
      <div class="border-bottom font-weight-bold"><img src="<%=request.getContextPath()%>/image/<%=ebook.getEbookImg() %>" width="200" height="200"></div>
	<div class="border-bottom font-weight-bold"><%=ebook.getEbookTitle()%></div>
   </div>
   <div>
      <!-- 주문 입력하는 폼 -->
      <div class="jumbotron">
		<h2>전자책 주문</h2>
	  </div>
      <%
      Member loginMember = (Member)session.getAttribute("loginMember");
      //로그인이 안되어있다면
      if(loginMember == null){
         %>
            <div class="border-bottom font-weight-bold">로그인 후에 주문이 가능합니다<a href="<%=request.getContextPath()%>/loginForm.jsp">로그인페이지로</a></div>
         <%
      }else{//로그인이 되어있따면
      %>
      <!-- type="hidden"을 하면 안보임 -->
      <form method = "post" action="<%=request.getContextPath()%>/insertOrderAction.jsp">
         <input type="hidden" name="ebookNo" value="<%=ebookNo %>">
         <input type="hidden" name="memberNo" value="<%=loginMember.getMemberNo() %>">
         <input type="hidden" name="orderPrice" value="<%=ebook.getEbookPrice()%>">
         <button  class="btn btn-outline-info" type="submit">주문하기</button>
      </form>
      <%
      }
      %>
   </div>
   
   <div>
   <div class="jumbotron">
		<h2>상품 후기</h2>
	  </div>
      <!-- 이 상품의 별점의 평균 점수 -->
      <!-- select avg(order_score) from order_comment where ebook_no =? order by ebook_no-->
      <div>
         <%
         OrderDao orderDao = new OrderDao();
         double avgScore = orderDao.selectOrderScoreAvg(ebookNo);
         %>
         <div class="border-bottom font-weight-bold">별점 평균 : <%=avgScore%></div>
      </div>
      <!-- 이 상품의 후기(페이징) -->
      <!-- select * from order_comment where ebook_no=? limit ?,? -->
      <div class="jumbotron">
		<h2>후기목록(페이징)<h2>
	  </div>
      <%
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
		
		ArrayList<OrderComment> commentList = new ArrayList<OrderComment>();
		commentList = orderDao.selectCommentList(beginRow, ROW_PER_PAGE, ebookNo);
		
		// 마지막 페이지(lastPage)를 구하는 orderCommentDao의 메서드 호출
		// int 타입의 lastPage에 저장
		// 전체 행을 COUNT 하는 selectCommentListLastPage메서드 호출
		int lastPage = orderDao.selectCommentListLastPage(ROW_PER_PAGE, ebookNo);
		
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
				<th class="text-right">별점</th>
				<th class="text-right">후기</th>
				<th class="text-right">시간</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(OrderComment c : commentList) {
		%>
			<tr class="border-bottom font-weight-bold">
				<td class="text-right"><%=c.getOrderScore()%></td>
				<td class="text-right"><%=c.getOrderCommentContent()%></td>
				<td class="text-right"><%=c.getCreateDate()%></td>
			</tr>
		</tbody>
		<%
			}
		%>
	</table>
	
		<%
			if(currentPage > 1){
		%>
				<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=currentPage-1%>&ebookNo=<%=ebookNo%>">이전</a>
		<%
			}
		%>
		
		<%
			if(currentPage < lastPage){
		%>
				<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/selectEbookOne.jsp?currentPage=<%=currentPage+1%>&ebookNo=<%=ebookNo%>">다음</a>
		<%
			}
		%>
   </div>
   </div>
</div>
</body>
</html>