package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import commons.DBUtil;
import vo.Member;

public class MemberDao {
	public void insertMember(Member member) throws ClassNotFoundException, SQLException {
		
		System.out.println(member.getMemberId()+"<-- MemberId");
		System.out.println(member.getMemberPw()+"<-- MemberPw");
		System.out.println(member.getMemberName()+"<-- MemberName");
		System.out.println(member.getMemberAge()+"<-- MemberAge");
		System.out.println(member.getMemberGender()+"<-- MemberGender");
		
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		System.out.println(conn);
		
		String sql = "INSERT INTO member ( member_id, member_pw, member_level, member_name, member_age, member_gender, create_date, update_date) VALUES (?, PASSWORD(?), 0, ?, ?, ?, NOW(), NOW())";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		stmt.setString(3, member.getMemberName());
		stmt.setInt(4, member.getMemberAge());
		stmt.setString(5, member.getMemberGender());
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			
			member = new Member();
			
			// 정보은닉되어있는 필드값을 직접 쓰기 불가
			// 캡슐화된 메서드(setter)를 통해 쓰기
			member.setMemberId(rs.getString("member_id"));
			member.setMemberPw(rs.getString("member_pw"));
			member.setMemberName(rs.getString("member_name"));
			member.setMemberAge(rs.getInt("member_age"));
			member.setMemberGender(rs.getString("member_gender"));

		}
		 rs.close();
			stmt.close();
			conn.close();
		/*
		 * INSERT INTO member (
		 * member_id, 
		 * member_pw, 
		 * member_level,
		 *  member_name, 
		 *  member_age, 
		 *  member_gender, 
		 *  update_date
		 * ) VALUES (
		 * ?, PASSWORD(?), 0, ?, ?, NOW(), NOW()
		 * ) 
		 */
	}
	public Member login(Member member) throws ClassNotFoundException, SQLException {
		Member nullmember = null;
		
		// 디버깅
		System.out.println(member.getMemberId()+"<-- 로그인할때 입력한 MemberId");
		System.out.println(member.getMemberPw()+"<-- 로그인할때 입력한 MemberPw");
		
		DBUtil dbUtil = new DBUtil(); // 마리아db 연결
		Connection conn = dbUtil.getConnection(); // 마리아 db 접속
		System.out.println(conn);
		
		String sql = "SELECT member_no AS memberNo, member_id  AS memberId, member_level  AS memberLevel, member_name AS memberName FROM member WHere member_id=? AND member_pw=PASSWORD(?)";
		
		// sql문 실행
		PreparedStatement stmt = conn.prepareStatement(sql);
		System.out.println(stmt);
		
		stmt.setString(1, member.getMemberId());
		stmt.setString(2, member.getMemberPw());
		ResultSet rs = stmt.executeQuery();
		/*
		 * SELECT 
		 * 	member_no AS memberNo,
		 *  member_id  AS memberId,
		 *  member_level  AS memberLevel
		 *  FROM
		 *  member
		 *  WHere member_id=? AND member_pw=PASSWORD(?)
		 */
		if(rs.next()) {
		 	Member member1 = new Member();
		 	member1.setMemberId(rs.getString("memberId"));
		 	member1.setMemberName(rs.getString("memberName"));
		 	
		 	System.out.println(member1.getMemberId() + "<-- 아이디");
		 	System.out.println(member1.getMemberName() + "<-- 이름");
		 	return member1;
		 	}
		return nullmember;
	}
}
