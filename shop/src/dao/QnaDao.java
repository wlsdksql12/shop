package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import commons.DBUtil;
import vo.Notice;
import vo.Qna;
import vo.QnaComment;

public class QnaDao {
	public void insertQnaList(Qna qna) throws ClassNotFoundException, SQLException {
		System.out.println(qna.getQnaCategroy() + "<-- qna.getQnaCategroy()");
		System.out.println(qna.getQnaTitle() + "<-- qna.getQnaTitle()");
		System.out.println(qna.getQnaContent() + "<-- qna.getQnaContent()");
		System.out.println(qna.getQnaSecret() + "<-- qna.getQnaSecret()");
		System.out.println(qna.getMemberNo() + "<-- qna.getMemberNo()");
		
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO qna(qna_categroy, qna_title, qna_content, qna_secret, member_no, create_date, update_date) VALUES(?, ?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, qna.getQnaCategroy());
		stmt.setString(2, qna.getQnaTitle());
		stmt.setString(3, qna.getQnaContent());
		stmt.setString(4, qna.getQnaSecret());
		stmt.setInt(5, qna.getMemberNo());
		stmt.executeQuery();
		
		stmt.close();
		conn.close();
	}
	
	public ArrayList<Qna> selectQnaList() throws ClassNotFoundException, SQLException {
		ArrayList<Qna> list = new ArrayList<>();
		
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT qna_no qnaNo, qna_categroy qnaCategroy, qna_title qnaTitle, qna_content qnaContent, qna_secret qnaSecret, member_no MemberNo, create_date createDate, update_date updateDate FROM Qna ORDER BY create_date DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		// 리스트에 값 넣기
		while(rs.next()) {
			Qna qna = new Qna();
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaCategroy(rs.getString("qnaCategroy"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			qna.setQnaContent(rs.getString("qnaContent"));
			qna.setQnaSecret(rs.getString("qnaSecret"));
			qna.setMemberNo(rs.getInt("MemberNo"));
			qna.setCreateDate(rs.getString("createDate"));
			qna.setUpdateDate(rs.getString("updateDate"));
			list.add(qna);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		
		// 값 리턴
		return list;
		
	}
	
	public Qna selectQnaOne(int QnaNo) throws ClassNotFoundException, SQLException {
		Qna Qna = null;
		
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT qna_no qnaNo, qna_categroy qnaCategroy, qna_title qnaTitle, qna_content qnaContent, qna_secret qnaSecret, member_no MemberNo, create_date createDate, update_date updateDate FROM Qna WHERE qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, QnaNo);
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			Qna = new Qna();
			Qna.setQnaNo(rs.getInt("qnaNo"));
			Qna.setQnaCategroy(rs.getString("qnaCategroy"));
			Qna.setQnaTitle(rs.getString("qnaTitle"));
			Qna.setQnaContent(rs.getString("qnaContent"));
			Qna.setQnaSecret(rs.getString("qnaSecret"));
			Qna.setMemberNo(rs.getInt("MemberNo"));
			Qna.setCreateDate(rs.getString("createDate"));
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
				
		// 값 리턴
		return Qna;
		
	}
	
	public void updateQna(Qna qna) throws ClassNotFoundException, SQLException {
		
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE qna SET qna_categroy=?, qna_title=?, qna_Content=?, qna_secret=?, update_date=NOW() WHERE qna_no=? AND member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, qna.getQnaCategroy());
		stmt.setString(2, qna.getQnaTitle());
		stmt.setString(3, qna.getQnaContent());
		stmt.setString(4, qna.getQnaSecret());
		stmt.setInt(5, qna.getQnaNo());
		stmt.setInt(6, qna.getMemberNo());
		stmt.executeQuery();
		
		stmt.close();
		conn.close();
	}
	
	public void deleteQna(Qna qna) throws ClassNotFoundException, SQLException {
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM qna WHERE member_no=? AND qna_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qna.getMemberNo());
		stmt.setInt(2, qna.getQnaNo());
		stmt.executeQuery();
		
		stmt.close();
		conn.close();
	}
	
	public ArrayList selectQnaByPage(int beginRow,int ROW_PER_PAGE) throws ClassNotFoundException, SQLException {
		ArrayList<Qna> list = new ArrayList<>();
		
		System.out.println(beginRow + "<-- beginRow");
		System.out.println(ROW_PER_PAGE + "<-- ROW_PER_PAGE");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT qna_no qnaNo, qna_categroy qnaCategroy, qna_title qnaTitle, qna_content qnaContent, qna_secret qnaSecret, member_no MemberNo, create_date createDate, update_date updateDate FROM Qna ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, ROW_PER_PAGE);
		System.out.println(stmt + "<-- stmt");
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Qna qna = new Qna();
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaCategroy(rs.getString("qnaCategroy"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			qna.setQnaContent(rs.getString("qnaContent"));
			qna.setQnaSecret(rs.getString("qnaSecret"));
			qna.setMemberNo(rs.getInt("MemberNo"));
			qna.setCreateDate(rs.getString("createDate"));
			qna.setUpdateDate(rs.getString("updateDate"));
			list.add(qna);
		}
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	public int selectQnaByLastPage(int ROW_PER_PAGE, int memberNo) throws ClassNotFoundException, SQLException {
		int totalCount = 0;
		int lastPage = 0;
		
		// 매개변수 값을 디버깅
		System.out.println(ROW_PER_PAGE + "<--- ROW_PER_PAGE");
		System.out.println(memberNo + "<--- memberNo");
		
		// dbUtil 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT count(*) FROM qna";
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		ResultSet rs = stmt.executeQuery();
		// 디버깅 : 쿼리내용과 표현식의 파라미터값 확인가능
		System.out.println("총 행의 개수 stmt : "+stmt);
		
		// totalCount 저장
		if(rs.next()) {
			totalCount = rs.getInt("count(*)");
		}
		System.out.println("totalCounnt(총 행의 개수) : "+totalCount);
				
		// 마지막 페이지
		// lastPage를 전체 행의 수와 한 페이지에 보여질 행의 수(rowPerPage)를 이용하여 구한다
		lastPage = totalCount / ROW_PER_PAGE;
		if(totalCount % ROW_PER_PAGE != 0) {
			lastPage+=1;
			}
		System.out.println("lastPage(마지막 페이지 번호) : "+lastPage);
				
		rs.close();
		stmt.close();
		conn.close();
				
		return lastPage;
		
	}
	
	public void insertQnaComment(QnaComment qnaComment) throws ClassNotFoundException, SQLException {
		System.out.println(qnaComment.getQnaNo() + "<-- qnaComment.getQnaNo()");
		System.out.println(qnaComment.getMemberNo() + "<-- qnaComment.getMemberNo()");
		System.out.println(qnaComment.getQnaCommentContent() + "<-- qnaComment.getQnaCommentContent()");
		
		// dbUtil 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO qna_comment(qna_no, qna_comment_content, member_no, create_date, update_date) VALUES (?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qnaComment.getQnaNo());
		stmt.setString(2, qnaComment.getQnaCommentContent());
		stmt.setInt(3, qnaComment.getMemberNo());
		
		stmt.executeQuery();
		
		stmt.close();
		conn.close();
	}
	
	public QnaComment selectQnaComment(Qna qna) throws ClassNotFoundException, SQLException {
		QnaComment qnaComment = null;
		System.out.println(qna.getQnaNo() + "<-- qna.getQnaNo()");
		System.out.println(qna.getMemberNo() + "<-- qna.getMemberNo()");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT qna_no qnaNo, qna_comment_content qnaCommentContent, member_no memberNo, create_date createDate, update_date updateDate FROM qna_comment WHERE qna_no=? AND member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, qna.getQnaNo());
		stmt.setInt(2, qna.getMemberNo());
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			qnaComment = new QnaComment();
			qnaComment.setQnaNo(rs.getInt("qnaNo"));
			qnaComment.setQnaCommentContent(rs.getString("qnaCommentContent"));
			qnaComment.setMemberNo(rs.getInt("memberNo"));
			qnaComment.setCreateDate(rs.getString("createDate"));
			qnaComment.setUpdateDate(rs.getString("updateDate"));
		}
		return qnaComment;
		
	}
	
	public ArrayList<Qna> newQnaList() throws ClassNotFoundException, SQLException {
		ArrayList<Qna> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT q.qna_no qnaNo, q.qna_categroy qnaCategroy, q.qna_title qnaTitle FROM qna q LEFT JOIN qna_comment qc ON q.qna_no = qc.qna_no WHERE qc.qna_no IS NULL ORDER BY q.create_date DESC LIMIT 0, 5";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Qna qna = new Qna();
			qna.setQnaNo(rs.getInt("qnaNo"));
			qna.setQnaCategroy(rs.getString("qnaCategroy"));
			qna.setQnaTitle(rs.getString("qnaTitle"));
			list.add(qna);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
	}
}
