package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import vo.Ebook;
import vo.Member;
import vo.Notice;
import vo.Order;
import vo.OrderEbookMember;
import commons.DBUtil;

public class NoticeDao {
	public void insertNoticeList(Notice notice) throws ClassNotFoundException, SQLException {
		
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "INSERT INTO notice(notice_no, notice_title, notice_content, member_no, create_date, update_date) VALUES(?, ?, ?, ?, NOW(), NOW())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		stmt.setString(2, notice.getNoticeTitle());
		stmt.setString(3, notice.getNoticeContent());
		stmt.setString(4, notice.getMemberNo());
		stmt.executeQuery();
		
		stmt.close();
		conn.close();
	}
	public ArrayList<Notice> selectNoticeList() throws ClassNotFoundException, SQLException {
		ArrayList<Notice> list = new ArrayList<>();
		
		// db접속 메소드 호출
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no NoticeNo, notice_title NoticeTitle, notice_content NoticeContent, member_no MemberNo, create_date createDate, update_date updateDate FROM notice ORDER BY create_date DESC";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();

		// 리스트에 값 넣기
		while (rs.next()) {
			Notice notice = new Notice();
			notice.setNoticeNo(rs.getInt("NoticeNo"));
			notice.setNoticeTitle(rs.getString("NoticeTitle"));
			notice.setNoticeContent(rs.getString("NoticeContent"));
			notice.setMemberNo(rs.getString("MemberNo"));
			notice.setCreateDate(rs.getString("createDate"));
			notice.setUpdateDate(rs.getString("updateDate"));
			list.add(notice);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;
		
	}
	
	public void updateNoitce(Notice notice) throws ClassNotFoundException, SQLException {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "UPDATE notice SET notice_title=?, notice_content=?, update_date=NOW() WHERE notice_no=? AND member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, notice.getNoticeTitle());
		stmt.setString(2, notice.getNoticeContent());
		stmt.setInt(3, notice.getNoticeNo());
		stmt.setString(4, notice.getMemberNo());
		stmt.executeQuery();
		
		stmt.close();
		conn.close();
	}
	
	public void deleteNotice(Notice notice) throws ClassNotFoundException, SQLException {
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "DELETE FROM notice WHERE notice_no=? AND member_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, notice.getNoticeNo());
		stmt.setString(2, notice.getMemberNo());
		stmt.executeQuery();
		
		stmt.close();
		conn.close();
	}
	
	public ArrayList<Notice> newNoticeList() throws ClassNotFoundException, SQLException {
		ArrayList<Notice> list = new ArrayList<>();
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no NoticeNo, notice_title NoticeTitle, notice_content NoticeContent, create_date createDate FROM notice ORDER BY create_date DESC LIMIT 0, 5";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while (rs.next()) {
			Notice notice = new Notice();
			notice.setNoticeNo(rs.getInt("NoticeNo"));
			notice.setNoticeTitle(rs.getString("NoticeTitle"));
			notice.setNoticeContent(rs.getString("NoticeContent"));
			notice.setCreateDate(rs.getString("createDate"));
			list.add(notice);
		}
		// 접속 종료
		rs.close();
		stmt.close();
		conn.close();
		// 값 리턴
		return list;

	}
	
	public Notice selectNoticeOne(int noticeNo) throws ClassNotFoundException, SQLException {
		Notice notice = null;
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_title NoticeTitle, notice_content NoticeContent, create_date CreateDate FROM notice WHERE notice_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			notice = new Notice();
			notice.setNoticeTitle(rs.getString("NoticeTitle"));
			notice.setNoticeContent(rs.getString("NoticeContent"));
			notice.setCreateDate(rs.getString("CreateDate"));
		}
		rs.close();
		stmt.close();
		conn.close();
		return notice;
	}
	
	public ArrayList selectNoticeListByPage(int beginRow,int ROW_PER_PAGE) throws ClassNotFoundException, SQLException {
		ArrayList<Notice> list = new ArrayList<>();
		
		System.out.println(beginRow + "<-- beginRow");
		System.out.println(ROW_PER_PAGE + "<-- ROW_PER_PAGE");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT notice_no noticeNo, notice_title noticeTitle, notice_content noticeContent, member_no memberNo, create_date CreateDate, update_date updateDate FROM notice ORDER BY create_date DESC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, ROW_PER_PAGE);
		System.out.println(stmt + "<-- stmt");
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Notice n = new Notice();
			
			n.setNoticeNo(rs.getInt("noticeNo"));
			n.setNoticeTitle(rs.getString("noticeTitle"));
			n.setNoticeContent(rs.getString("noticeContent"));
			n.setMemberNo(rs.getString("memberNo"));
			n.setCreateDate(rs.getString("CreateDate"));
			n.setUpdateDate(rs.getString("updateDate"));
			list.add(n);
		}
		rs.close();
		stmt.close();
		conn.close();
		return list;
		
		
	}
	
	public int selectNoticeListByLastPage(int ROW_PER_PAGE, int memberNo) throws ClassNotFoundException, SQLException {
		int totalCount = 0;
		int lastPage = 0;
		
		// 매개변수 값을 디버깅
		System.out.println(ROW_PER_PAGE + "<--- ROW_PER_PAGE");
		System.out.println(memberNo + "<--- memberNo");
		
		// dbUtil 객체 생성
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String sql = "SELECT count(*) FROM notice WHERE member_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, memberNo);
		
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
}
