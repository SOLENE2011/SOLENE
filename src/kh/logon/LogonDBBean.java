package kh.logon;


import java.sql.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Vector;

public class LogonDBBean {
	
//�� ���������� ����� ��ɵ��� ����!!!
	
	// SingleTon Pattern
	private static LogonDBBean instance = new LogonDBBean();
	//static�Ӽ� ���� ����Ǳ⶧���� �Ʒ� 	private LogonDBBean() {} �� �ڸ� �ٲ㵵 ����� ���� ���Ǻн�!!!!!
	
	public static LogonDBBean getInstance() {
		return instance;
		// LogonDBBean�� instance�� ����� getInstance�� ����ؼ� LogonDBBean�� ����Ѵ�.
	}
	
	private LogonDBBean() {}
	// ������ �Ժη� �������� ���ϰ� �ϱ�����
	//private�� ��ü������ �ϸ� �ƹ��͵� ���ϱ⶧����
	//static�� �̿��ؼ� static�޸𸮿� �ø��� static�� �޼��带 �÷� �����



	private Connection getConnection() throws Exception {
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}
	//ȸ������â
	// inputPro.jsp ���� ȸ�������� �� �� ���
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
	//�����ȣ ã�� â
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
				tempZipcode.setZipcode(rs.getString("zipcode")); //�����ȣ
				tempZipcode.setArea1(rs.getString("area1")); // ��õ��
				tempZipcode.setArea2(rs.getString("area2")); //����
				tempZipcode.setArea3(rs.getString("area3")); //����
				tempZipcode.setArea4(rs.getString("area4")); //0����
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
	//���̵�� ��й�ȣ �´��� Ȯ���ϴ� �۾�
	// LoginPro.jsp ���� �α����� �õ� �Ҵ� ȣ��
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
				//���������� ���� �ִٸ�
				dbpasswd = rs.getString("passwd");
				if (dbpasswd.equals(passwd))
					return 1; // ���� ����
				else
					return 0; // ��й�ȣ Ʋ��
			} else
				return -1; // �ش� ���̵� ����
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
	
	// ID �ߺ�Ȯ�� ConfirmId.jsp
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
				return 1; // �ش� ���̵� ����
			else
				return -1; // �ش� ���̵� ����
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
		return -1; //�����ͺ��̽����� ������ ����ؼ�
	}

	// ȸ�����������Ҷ� ���� ��������!!!!!!!!!!!!!!!!!!!!
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

	//������ ������ ���� �����ϱ�!
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
	//ȸ��Ż��
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
					return 1; // ȸ�� Ż�� ����
				} else {
					return 0; // ��й�ȣ Ʋ��
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
