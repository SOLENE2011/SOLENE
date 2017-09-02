package kh.board;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
// 한번에 import java.util.*;

import org.eclipse.jdt.internal.compiler.ast.ThrowStatement;

// 기능들의 집합 BoardDBBean

public class BoardDBBean {
	private static BoardDBBean instance = new BoardDBBean();

	// BoardDBBean에 객체를 생성하는데 함부로 사용하지 못하도록 private를 붙인다. 그리고나서 static 메모리에 올린다.
	public static BoardDBBean getInstance() { // static메모리에 함수를 사용해 BoardDBBean의 요소들을 넣는다.
		return instance;
	}

	private BoardDBBean() {
	}

	private Connection getConnection() throws Exception {
		String jdbcDriver = "jdbc:apache:commons:dbcp:/pool";
		return DriverManager.getConnection(jdbcDriver);
	}

	// 새글쓰기 작업
	public void insertArticle(BoardDataBean article) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		// 답변글인지 일반글인지 구분해서 입력시켜주는 로직

		// int num = 0, ref = 1, re_step = 0, re_level = 0;
		int num = article.getNum();
		int ref = article.getRef();
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();
		int number = 0;
		String sql = "";

		try {
			conn = getConnection();
			// DB랑 연결함

			pstmt = conn.prepareStatement("select max(num) from PKSUN_B");
			// 쿼리문 준비
			// 테이블에서 가장 큰 숫자를 가져온다

			rs = pstmt.executeQuery();
			// 실행시킨 결과를 저장

			if (rs.next())
				// rs 결과값이 있으면
				number = rs.getInt(1) + 1;
			// rs.getInt column value를 retern함! rs 결과값의 첫번째! 그리고 1을 더함
			else
				number = 1;
			// 시작은 1이니깐!!!

			if (num != 0)
			// 0이 아니면 답변글
			{
				sql = "update PKSUN_B set re_step=re_step+1 where ref = ? and re_step > ?";
				// 새글이 0번임 답글이면 1 2 3 4 이렇게 올라감
				// ref가 같다는건 게시물과 그것에 대한 답변글일때 같음!
				// 새로 입력된 답글이 해당 게시물의 답글이면서
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step + 1;
				re_level = re_level + 1;
			} else {
				// 메인글이면
				ref = number;
				re_step = 0;
				re_level = 0;
			}

			// 쿼리를 작성
			sql = "insert into PKSUN_B(num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip) values(PKSUN_S.NEXTVAL,?,?,?,?,?,?,?,?,?,?)";
			// sequence를 만든이유! 자동으로1씩 증가
			// PKSUN_S.NEXTVAL

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, article.getWriter());
			// article은 boardDataBean 타입
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

	// 게시판 list를 위한작업
	// list.jsp : 페이징을 위해 전체 DB에 입력된 행의수가 필요함
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

	// 게시판 목록
	// list.jsp ==> Paging!!! DB로부터 여러행을 결과로 받는다.
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
																	//rownum r( r은 이름, rownum은 엉킨 번호를 새롭게 다시 부여한다
			"from (select num,writer,email,subject,passwd,reg_date,ref,re_step,re_level,content,ip,readcount " + //
			"from PKSUN_B order by ref desc, re_step asc) order by ref desc, re_step asc) where r>=? and r <= ?"); //
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articleList = new ArrayList(end);
				//10개짜리의  ArrayList
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

	// content.jsp에서 사용함!!!
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

	// updatePro.jsp : 실제 데이터를 수정하는 메소드

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

					x = 1; // 업데이트 성공

				} else {

					x = 0; // 업데이트 실패

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

	// deletePro.jsp : 실제 데이터를 삭제하는 메소드...
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
					x = 1; // 글 삭제 성공

				} else
					x = 0; // 비밀번호 틀림
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
