<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
    
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
	int ebookNo = Integer.parseInt(request.getParameter("ebookNo"));
	System.out.println(ebookNo + "<--selectEbookOne.jsp.ebookNo");
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
		<jsp:include page="/partial/adminMenu.jsp"></jsp:include><!-- jsp액션태그 -->
	</div>
	<!-- 관리자 메뉴 인클루드 끝 -->
	<%
		EbookDao ebookDao = new EbookDao();
		Ebook ebook = ebookDao.selectEbookOne(ebookNo);
	%>
	<table class="table table-borderless table-hover">
		<tr class="border-bottom font-weight-bold">
			<td class="text-center"><img src="<%=request.getContextPath()%>/image/<%=ebook.getEbookImg()%>"></td>
		</tr>
		<tr class="border-bottom font-weight-bold">
			<td class="text-center">EbookNo</td>
			<td class="text-center"><%=ebook.getEbookNo()%></td>
		</tr>
		<tr class="border-bottom font-weight-bold">
			<td class="text-center">EbookTitle</td>
			<td class="text-center"><%=ebook.getEbookTitle()%></td>
		</tr>
		<tr class="border-bottom font-weight-bold">
			<td class="text-center">EbookPrice</td>
			<td class="text-center"><%=ebook.getEbookPrice()%></td>
		</tr>
	</table>
	<div class="border-bottom font-weight-bold">
		<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/admin/deleteEbook.jsp?ebookNo=<%=ebook.getEbookNo()%>">삭제</a>
		<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/admin/updateEbookPriceForm.jsp?ebookNo=<%=ebook.getEbookNo()%>">가격수정</a>
		<a class="btn btn-outline-info" href="<%=request.getContextPath()%>/admin/updateEbookImgForm.jsp?ebookNo=<%=ebook.getEbookNo()%>&ebookImg=<%=ebook.getEbookImg()%>">이미지수정</a>
	</div>
	</div>
</div>
</body>
</html>











