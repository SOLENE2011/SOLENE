package kh.board;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
// �ѹ��� import java.util.*;

import org.eclipse.jdt.internal.compiler.ast.ThrowStatement;

// ��ɵ��� ���� BoardDBBean

public class BoardDBBean {
	private static BoardDBBean instance = new BoardDBBean();

	// BoardDBBean�� ��ü�� �����ϴµ� �Ժη� ������� ���ϵ��� private�� ���δ�. �׸����� static �޸𸮿� �ø���.
	public static BoardDBBean getInstance() { // static�޸𸮿� �Լ��� ����� BoardDBBean�� ��ҵ��� �ִ´�.
		return instance;
	}

	private BoardDBBean() {
	}

	private Connection getConnection() throws Exception {
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}

	// ���۾��� �۾�
	public void insertArticle(BoardDataBean article) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// �亯������ �Ϲݱ����� �����ؼ� �Է½����ִ� ����

		// int num = 0, ref = 1, re_step = 0, re_level = 0;
		int num = article.getNum();
		int ref = article.getRef();
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();
		int number = 0;
		String sql = "";

		try {
			conn = getConnection();
			// DB�� ������

			pstmt = conn.prepareStatement("select max(num) from PKSUN_B");
			// ������ �غ�
			// ���̺��� ���� ū ���ڸ� �����´�

			rs = pstmt.executeQuery();
			// �����Ų ����� ����

			if (rs.next())
				// rs ������� ������
				number = rs.getInt(1) + 1;
			// rs.getInt column value�� retern��! rs ������� ù��°! �׸��� 1�� ����
			else
				number = 1;
			// ������ 1�̴ϱ�!!!

			if (num != 0)
			// 0�� �ƴϸ� �亯��
			{
				sql = "update PKSUN_B set re_step=re_step+1 where ref = ? and re_step > ?";
				// ������ 0���� ����̸� 1 2 3 4 �̷��� �ö�
				// ref�� ���ٴ°� �Խù��� �װͿ� ���� �亯���϶� ����!
				// ���� �Էµ� ����� �ش� �Խù��� ����̸鼭
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step + 1;
				re_level = re_level + 1;
			} else {
				// ���α��̸�
				ref = number;
				re_step = 0;
				re_level = 0;
			}

			// ������ �ۼ�
			sql = "insert into PKSUN_B(num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip) values(PKSUN_S.NEXTVAL,?,?,?,?,?,?,?,?,?,?)";
			// sequence�� ��������! �ڵ�����1�� ����
			// PKSUN_S.NEXTVAL

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			// article�� boardDataBean Ÿ��
			pstmt.setString(2, article.getEmail());
			pstmt.setString(3, article.getSubject());
			pstmt.setString(4, article.getPasswd());
			pstmt.setTimestamp(5, article.getReg_date());
			pstmt.setInt(6, ref);
			pstmt.setInt(7, re_step);
			pstmt.setInt(8, re_level);
			pstmt.setString(9, article.getContent());
			pstmt.setString(10, article.getIp());

			pstmt.executeUpdate();

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
	}

	// �Խ��� list�� �����۾�
	// list.jsp : ����¡�� ���� ��ü DB�� �Էµ� ���Ǽ��� �ʿ���
	public int getArticleCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(*) from PKSUN_B");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				x = rs.getInt(1);
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
		return x;
	}

	public int getArticleCount(int n, String searchKeyword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String[] column_name = { "writer", "subject", "content" };

		int x = 0;

		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(
					"select count(*) from PKSUN_B where " + column_name[n] + " like '%" + searchKeyword + "%'");

			rs = pstmt.executeQuery();

			if (rs.next())
				x = rs.getInt(1);

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

		return x;

	}

	// �Խ��� ���
	// list.jsp ==> Paging!!! DB�κ��� �������� ����� �޴´�.
	public List getArticles(int start, int end) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;
		try {
			conn = getConnection();
			
			pstmt = conn.prepareStatement(
			"select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r " +
			"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r " +
																	//rownum r( r�� �̸�, rownum�� ��Ų ��ȣ�� ���Ӱ� �ٽ� �ο��Ѵ�
			"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount " + //
			"from PKSUN_B order by ref desc, re_step asc) order by ref desc, re_step asc) where r>=? and r <= ?"); //
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articleList = new ArrayList(end);
				//10��¥����  ArrayList
				do {
					BoardDataBean article = new BoardDataBean();
			article.setNum(rs.getInt("num"));
			article.setWriter(rs.getString("writer"));
			article.setEmail(rs.getString("email"));
			article.setSubject(rs.getString("subject"));
			article.setPasswd(rs.getString("passwd"));
			article.setReg_date(rs.getTimestamp("reg_date"));
			article.setReadcount(rs.getInt("readcount"));
			article.setRef(rs.getInt("ref"));
			article.setRe_step(rs.getInt("re_step"));
			article.setRe_level(rs.getInt("re_level"));
			article.setContent(rs.getString("content"));
			article.setIp(rs.getString("ip"));
			articleList.add(article);
			
		}while(rs.next());
			}
					
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs != null) try { rs.close(); } catch(SQLException ex) {}
			if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
			if ( conn != null) try { conn.close(); } catch(SQLException ex) {}			
		}
		return articleList;	
	}
		public List getArticles(int start, int end, int n , String searchKeyword) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List articleList = null;
		
		String[] column_name = {"writer","subject","content"};
		
		try
		{
		conn = getConnection();
		
		String sql = "select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,r " 
				+ "from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount,rownum r " 
				+ "from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount "
				+ "from PKSUN_B order by ref desc, re_step asc) where "+column_name[n]+" like '%"+searchKeyword+"%' order by ref desc, re_step asc ) where r >= ? and r <= ?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,  start);
		pstmt.setInt(2, end);
		
		rs = pstmt.executeQuery();
		
		if(rs.next())
		{
			articleList = new ArrayList(end);
			
			do {
				BoardDataBean article = new BoardDataBean();
				
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));
				
				articleList.add(article);
				
			}while(rs.next());
		}
		}catch(Exception ex) {
			ex.printStackTrace();
			
		}finally {
			if(rs != null) try {rs.close();} catch(SQLException ex){}
			if(pstmt != null) try {pstmt.close();} catch(SQLException ex){}
			if(conn != null) try {conn.close();} catch(SQLException ex){}		
		}
		return articleList;
		
		
}

	// content.jsp���� �����!!!
	public BoardDataBean getArticle(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDataBean article = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("update PKSUN_B set readcount=readcount+1 where num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

			pstmt = conn.prepareStatement("select * from PKSUN_B where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));

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
		return article;
	}

	public BoardDataBean updateGetArticle(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDataBean article = null;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select * from PKSUN_B where num=?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp("ip");

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
		return article;
	}

	// updatePro.jsp : ���� �����͸� �����ϴ� �޼ҵ�

	public int updateArticle(BoardDataBean article) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		String sql = "";
		int x = -1;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select passwd from PKSUN_B where num = ?");
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpasswd = rs.getString("passwd");
				if (dbpasswd.equals(article.getPasswd())) {
					sql = "update PKSUN_B set writer=?,email=?,subject=?,passwd=?,content=? where num=?";

					pstmt = conn.prepareStatement(sql);

					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getEmail());
					pstmt.setString(3, article.getSubject());
					pstmt.setString(4, article.getPasswd());
					pstmt.setString(5, article.getContent());
					pstmt.setInt(6, article.getNum());
					pstmt.executeUpdate();

					x = 1; // ������Ʈ ����

				} else {

					x = 0; // ������Ʈ ����

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
		return x;
	}

	// deletePro.jsp : ���� �����͸� �����ϴ� �޼ҵ�...
	public int deleteArticle(int num, String passwd) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String dbpasswd = "";
		int x = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select passwd from PKSUN_B where num=?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpasswd = rs.getString("passwd");
				if (dbpasswd.equals(passwd)) {
					pstmt = conn.prepareStatement("delete from PKSUN_B where num=?");
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					x = 1; // �� ���� ����

				} else
					x = 0; // ��й�ȣ Ʋ��
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
		return x;
	}
}
