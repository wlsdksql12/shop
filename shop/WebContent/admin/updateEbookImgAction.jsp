<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*"%>
<%@ page import="dao.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%> <!-- request 대신 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%> <!-- 파일이름중복을 피할수 있도록 -->
<%@ page import="java.io.File" %>

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
	
	Ebook ebook = new Ebook();
	
	// multipart/form-data로 넘겼기 때문에 request.getParameter("ebookNo")형태 사용불가
	File temp = new File("");
	String path = temp.getAbsolutePath();
	MultipartRequest mr = new MultipartRequest(
			request, path+"/webapps/shop/image", 1024*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	int ebookNo = Integer.parseInt(mr.getParameter("ebookNo"));
	String ebookImg = mr.getParameter("ebookImg");
	String newebookImg = mr.getFilesystemName("newebookImg");
	System.out.println(newebookImg + "<-- newebookImg");
	System.out.println(ebookImg + "<-- ebookImg");
	ebook.setEbookNo(ebookNo);
	ebook.setEbookImg(newebookImg);
	
	// 이전 사진명을 통해 실제로 삭제될 사진을 가져온다
	String deleteImgName = path+"/webapps/shop/image" + ebookImg;
	File deleteImg = new File (deleteImgName);

	// 이전 사진이 경로에 존재한다면 삭제한다
	if (deleteImg.exists() && deleteImg.isFile()){
	    deleteImg.delete();// 사진 삭제
	    System.out.println("삭제된 이전 사진 : "+ebookImg);
	}
	EbookDao ebookDao = new EbookDao();
	ebookDao.updateEbookImg(ebook);
	response.sendRedirect(request.getContextPath()+"/admin/selectEbookOne.jsp?ebookNo="+ebookNo);
%>


