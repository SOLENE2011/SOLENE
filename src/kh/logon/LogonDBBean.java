package kh.logon;


import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Vector;

public class LogonDBBean {
	
//웹 페이지에서 실행될 기능들의 집합!!!
	
	// SingleTon Pattern
	private static LogonDBBean instance = new LogonDBBean();
	//static속성 먼저 실행되기때문에 아래 	private LogonDBBean() {} 랑 자리 바꿔도 상관이 없음 나의분신!!!!!
	
	public static LogonDBBean getInstance() {
		return instance;
		// LogonDBBean를 instance로 만들고 getInstance를 사용해서 LogonDBBean을 사용한다.
	}
	
	private LogonDBBean() {}
	// 남들이 함부로 접근하지 못하게 하기위해
	//private로 객체생성을 하면 아무것도 못하기때문에
	//static을 이용해서 static메모리에 올리고 static에 메서드를 올려 사용함



	private Connection getConnection() throws Exception {
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}
	//회원가입창
	// inputPro.jsp 에서 회원가입을 할 때 사용
	public void insertMember(LogonDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("insert into MEMBERS values (?,?,?,?,?,?,?,?,?,?)");
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getJumin1());
			pstmt.setString(5, member.getJumin2());
			pstmt.setString(6, member.getEmail());
			pstmt.setString(7, member.getBlog());
			pstmt.setTimestamp(8, member.getReg_date());
			pstmt.setString(9, member.getZipcode());
			pstmt.setString(10, member.getAddress());
			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
	}
	//우편번호 찾기 창
	public Vector<ZipcodeBean> zipcodeRead(String area3) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Vector<ZipcodeBean> vecList = new Vector<ZipcodeBean>();
		try {
			con = getConnection();
			String strQuery = "select * from zipcode where area3 like '" + area3 + "%'";
			pstmt = con.prepareStatement(strQuery);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ZipcodeBean tempZipcode = new ZipcodeBean();
				tempZipcode.setZipcode(rs.getString("zipcode")); //우편번호
				tempZipcode.setArea1(rs.getString("area1")); // 인천시
				tempZipcode.setArea2(rs.getString("area2")); //부평구
				tempZipcode.setArea3(rs.getString("area3")); //부평동
				tempZipcode.setArea4(rs.getString("area4")); //0번지
				vecList.addElement(tempZipcode);
			}
		} catch (Exception ex) {
			System.out.println("Exception" + ex);
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException ex) {
				}

		}
		return vecList;

	}
	//아이디랑 비밀번호 맞는지 확인하는 작업
	// LoginPro.jsp 에서 로그인을 시도 할대 호출
	public int userCheck(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from MEMBERS where id =? ");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				//쿼리실행한 값이 있다면
				dbpasswd = rs.getString("passwd");
				if (dbpasswd.equals(passwd))
					return 1; // 인증 성공
				else
					return 0; // 비밀번호 틀림
			} else
				return -1; // 해당 아이디 없음
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return -1;
	}
	
	// ID 중복확인 ConfirmId.jsp
	public int confirmId(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select id from MEMBERS where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next())
				return 1; // 해당 아이디 있음
			else
				return -1; // 해당 아이디 없음
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return -1; //데이터베이스오류 날때를 대비해서
	}

	// 회원정보변경할때 정보 가져오기!!!!!!!!!!!!!!!!!!!!
	//modifyPro.jsp
	public LogonDataBean getMember(String id) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		LogonDataBean member = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from MEMBERS where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				member = new LogonDataBean();
				member.setId(rs.getString("id"));
				member.setPasswd(rs.getString("passwd"));
				member.setName(rs.getString("name"));
				member.setJumin1(rs.getString("jumin1"));
				member.setJumin2(rs.getString("jumin2"));
				member.setEmail(rs.getString("email"));
				member.setBlog(rs.getString("blog"));
				member.setZipcode(rs.getString("zipcode"));
				member.setAddress(rs.getString("address"));
				member.setReg_date(rs.getTimestamp("reg_date"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return member;
	}

	//가져온 정보를 새로 변경하기!
	public void updateMember(LogonDataBean member) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update MEMBERS set passwd=?,name=?,email=?,blog=?, zipcode=?, address=? where id=?");
			pstmt.setString(1, member.getPasswd());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getBlog());
			pstmt.setString(5, member.getZipcode());
			pstmt.setString(6, member.getAddress());
			pstmt.setString(7, member.getId());

			pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
	}
	//회원탈퇴
	public int deleteMember(String id, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from MEMBERS where id = ?");
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpasswd = rs.getString("passwd");
				if (dbpasswd.equals(passwd)) {
					pstmt = conn.prepareStatement("delete from MEMBERS where id =?");
					pstmt.setString(1, id);
					pstmt.executeUpdate();
					return 1; // 회원 탈퇴 성공
				} else {
					return 0; // 비밀번호 틀림
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return -1;
	}
	
	public LogonDataBean findId(String name,String email) throws Exception {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      LogonDataBean member = null;
	      try {
	         conn = getConnection();
	         
	         pstmt = conn.prepareStatement("select id from MEMBERS where name=? and email = ?");
	         pstmt.setString(1, name);
	         pstmt.setString(2, email);
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()) {
	            member = new LogonDataBean();
	            member.setId(rs.getString("id"));
	         }
	      } catch (Exception ex) {
	         ex.printStackTrace();
	      } finally {
	         if(rs!=null)   try {rs.close();}    catch(SQLException ex) {}
	         if(pstmt!=null)   try {pstmt.close();} catch(SQLException ex) {}
	         if(conn!=null)   try {conn.close();}    catch(SQLException ex) {}
	      }
	      return member;
	   }
	   
	   public LogonDataBean findPw(String id,String name,String email) throws Exception {
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      LogonDataBean member = null;
	      try {
	         conn = getConnection();
	         
	         pstmt = conn.prepareStatement("select * from MEMBERS where id=? and name=? and email = ?");
	         pstmt.setString(1, id);
	         pstmt.setString(2, name);
	         pstmt.setString(3, email);
	         rs = pstmt.executeQuery();
	         
	         if(rs.next()) {
	            member = new LogonDataBean();
	            member.setId(rs.getString("id"));
	            member.setPasswd(rs.getString("passwd"));
	            member.setName(rs.getString("name"));
	            member.setJumin1(rs.getString("jumin1"));
	            member.setJumin2(rs.getString("jumin2"));
	            member.setEmail(rs.getString("email"));
	            member.setBlog(rs.getString("blog"));
	            member.setReg_date(rs.getTimestamp("reg_date"));
	            member.setZipcode(rs.getString("zipcode"));
	            member.setAddress(rs.getString("address"));
	         }
	      } catch (Exception ex) {
	         ex.printStackTrace();
	      } finally {
	         if(rs!=null)   try {rs.close();}    catch(SQLException ex) {}
	         if(pstmt!=null)   try {pstmt.close();} catch(SQLException ex) {}
	         if(conn!=null)   try {conn.close();}    catch(SQLException ex) {}
	      }
	      return member;
	   }
	   
	   
	    public int selectCount() throws Exception {
	    	Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;
			try {
				conn = getConnection();
				stmt = conn.createStatement();
				rs = stmt.executeQuery("select count(*) from members");
				rs.next();
				return rs.getInt(1);
			} finally {
	            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (stmt != null) try { stmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }
		}
	    
	    
	    public List<LogonDataBean> getMemberList(int startRow, int endRow)
				throws Exception {
	    	Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			List<LogonDataBean>  messageList = null;
			LogonDataBean member = null;
			try {
				conn = getConnection();
				pstmt = conn.prepareStatement(
					"select id, name, passwd, jumin1, jumin2, email, blog, reg_date, zipcode, address from ( "
					+ "    select rownum rnum, id, name, passwd, jumin1, jumin2, email, blog, reg_date, zipcode, address from ( "
					+ "        select * from members m order by m.id desc "
					+ "    ) where rownum <= ? "
					+ ") where rnum >= ?");

				pstmt.setInt(1, endRow);
				pstmt.setInt(2, startRow);
				rs = pstmt.executeQuery();
				if (rs.next()) {
					messageList = new ArrayList<LogonDataBean>();
					do {
						member = new LogonDataBean();
		                member.setId(rs.getString("id"));
		                member.setPasswd(rs.getString("passwd"));
		                member.setName(rs.getString("name"));
		                member.setJumin1(rs.getString("jumin1"));
		                member.setJumin2(rs.getString("jumin2"));
		                member.setEmail(rs.getString("email"));
		                member.setBlog(rs.getString("blog"));
		                member.setReg_date(rs.getTimestamp("reg_date"));    
		                member.setZipcode(rs.getString("zipcode"));
		                member.setAddress(rs.getString("address"));
						messageList.add(member);
					} while (rs.next());
					return messageList;
				} else {
					return Collections.emptyList();
				}
			} finally {
	            if (rs != null) try { rs.close(); } catch(SQLException ex) {}
	            if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
	            if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	        }	
		}
	
}
