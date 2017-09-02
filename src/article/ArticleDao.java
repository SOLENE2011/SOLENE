package article;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import kh.jdbc.JdbcUtil;

//DB���̺� ���� CREATE, READ, UPDATE, DELETE
public class ArticleDao {

	 private static ArticleDao instance = new ArticleDao();
	 public static ArticleDao getInstance() {
		 return instance;
	 }
	 private ArticleDao() {
		 
	 }
	 
	
	 // �ڡڡڡڡڡڰԽñ� ��ϰ��� �޼���ڡڡڡڡڡ�  //
	
	 // DB PKSUNarticle ���̺��� ��ü ���� ���� ����
	 public int selectCount(Connection conn) throws SQLException {
		 Statement stmt = null;
		 ResultSet rs = null;
		 try {
			 stmt = conn.createStatement();
			 rs = stmt.executeQuery("select count(*) from PKSUNarticle");
			 rs.next();
			 return rs.getInt(1);
		 }finally {
			 JdbcUtil.close(rs);
			 JdbcUtil.close(stmt);
		 }
	 }
	 
	 public int selectCount(Connection conn,int searchn, String search) throws SQLException {
		 Statement stmt = null;
		 ResultSet rs = null;
		 String[] col_name = {"writer_name","title","content"};
		 try {
			 stmt = conn.createStatement();
			 rs = stmt.executeQuery("select count(*) from PKSUNarticle where "+col_name[searchn]+" like '%"+search+"%'");
			  /*
			   * 	 n = 0; select count(*) from PKSUNarticle where write_name like '%"+search+"%'
			   *	 n = 1; select count(*) from PKSUNarticle where title like '%"+search+"%'
			   *	 n = 2; select count(*) from PKSUNarticle where content like '%"+search+"%'
			   * */
			 rs.next();
			 return rs.getInt(1);
			 
		 }finally {
			 JdbcUtil.close(rs);
			 JdbcUtil.close(stmt);
		 }
		 
		 
	 }
	  
	 // ������� �� �࿡ �ش��ϴ� �ุ ���ϱ�!
	 // ��ü �Խñ� ����� �ҷ��� ��
	 public List<Article> select(Connection conn, int firstRow, int endRow) throws SQLException {
		 PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 try {
			pstmt = conn.prepareStatement("select article_id, group_id, sequence_no, posting_date, read_count, writer_name, password, title from ( " 
						+ " select rownum rnum, article_id, group_id, sequence_no, posting_date, read_count, writer_name, password, title from ( "
						+ " select * from PKSUNarticle m order by m.sequence_no desc"
						+ " )where rownum <= ?"
						+ ") where rnum >= ?");
			
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, firstRow);
			rs = pstmt.executeQuery();
			if(!rs.next()) {
				return Collections.emptyList();
					//�����Ͱ� �������� ������ �� List�� �����Ѵ�.
				
			}
			
			
			//�����Ͱ� �����Ѵٸ� list ��Ͽ� ��� �ڷ��.
			List<Article> articleList = new ArrayList<Article>();
			do {
				Article article = makeArticleFromResultSet(rs, false);
				//�Խñ� ����� �ҷ��ö��� �Խñ��� ������ �ʿ����� �ʾƼ� false�� ���� �ִ� ����.
				articleList.add(article);
			}while (rs.next());
			return articleList;
		 }finally {
			 JdbcUtil.close(rs);
			 JdbcUtil.close(pstmt);
		 }
	 }
	 
	// �˻���� ��ġ�ϴ� ����Ʈ�� �ҷ��ö�!
		 public List<Article> select(Connection conn, int firstRow, int endRow, int n, String search) throws SQLException {
			 PreparedStatement pstmt = null;
			 ResultSet rs = null;
			 String[] col_name = {"writer_name","title","content"};
			 /*<select name=" searchn ">
			 <option value="0">�ۼ���</option>
			 <option value="1">����</option>
			 <option value="2">����</option>
			 </select>*/
			 try {
				pstmt = conn.prepareStatement("select article_id, group_id, sequence_no, posting_date, read_count, writer_name, password, title from ( " 
							+ " select rownum rnum, article_id, group_id, sequence_no, posting_date, read_count, writer_name, password, title from ( "
							+ " select * from PKSUNarticle m order by m.sequence_no desc"
							+ " )where "+col_name[n]+" like '%"+search+"%' and rownum <= ?"
							+ ") where rnum >= ?");
				
				pstmt.setInt(1, endRow);
				pstmt.setInt(2, firstRow);
				rs = pstmt.executeQuery();
				if(!rs.next()) {
					return Collections.emptyList();
						//�����Ͱ� �������� ������ �� List�� �����Ѵ�.
					
				}
				//�����Ͱ� �����Ѵٸ� list ��Ͽ� ��� �ڷ��.
				List<Article> articleList = new ArrayList<Article>();
				do {
					Article article = makeArticleFromResultSet(rs, false);
					//�Խñ� ����� �ҷ��ö��� �Խñ��� ������ �ʿ����� �ʾƼ� false�� ���� �ִ� ����.
					articleList.add(article);
				}while (rs.next());
				return articleList;
			 }
			 finally {
				 JdbcUtil.close(rs);
				 JdbcUtil.close(pstmt);
			 }
		 }
	 	
	 private Article makeArticleFromResultSet(ResultSet rs, boolean readContent) throws SQLException {
		 Article article = new Article();
		 article.setId(rs.getInt("article_id"));
		 article.setGroupId(rs.getInt("group_Id"));
		 article.setSequenceNumber(rs.getString("sequence_no"));
		 article.setPostingDate(rs.getTimestamp("posting_date"));
		 article.setReadCount(rs.getInt("read_count"));
		 article.setWriterName(rs.getString("writer_name"));
		 article.setPassword(rs.getString("password"));
		 article.setTitle(rs.getString("title"));
		 if(readContent) {
			 article.setContent(rs.getString("content"));
		 }
	 return article;
	 }
	 
	// �ڡڡڡڡڡڱ۾��� ���� �޼���ڡڡڡڡڡ�  //
	 
	 public int insert(Connection conn, Article article) throws SQLException {
		 PreparedStatement pstmt = null;
		 Statement stmt = null;
		 ResultSet rs = null;
		 
		 try {
			 pstmt = conn.prepareStatement("insert into PKSUNarticle "
					 	+ "(article_id, group_id, sequence_no, posting_date, read_count, "
					 	+ "writer_name, password, title, content) "
					 	+ "values(PKSUNarticle_id_seq.NEXTVAL, ?,?,?,0,?,?,?,?)");
			 pstmt.setInt(1, article.getGroupId());
			 pstmt.setString(2, article.getSequenceNumber());
			 pstmt.setTimestamp(3, new Timestamp(article.getPostingDate().getTime()));
			 pstmt.setString(4, article.getWriterName());
			 pstmt.setString(5, article.getPassword());
			 pstmt.setString(6,  article.getTitle());
			 pstmt.setString(7, article.getContent());
			 int insertedCount = pstmt.executeUpdate();
			 
			 if(insertedCount > 0) {
				 stmt = conn.createStatement();
				 rs = stmt.executeQuery("select PKSUNarticle_id_seq.CURRVAL from dual");
				 if(rs.next()) {
					 return rs.getInt(1);
				 }
			 }
			 return -1;
		 }finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(stmt);
			JdbcUtil.close(pstmt);
		 }
	 }
	 
	 public Article selectById(Connection conn, int articleId) throws SQLException{
		 PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 try {
			 pstmt = conn.prepareStatement("select * from PKSUNarticle where article_id = ?");
			 pstmt.setInt(1, articleId);
			 rs = pstmt.executeQuery();
			 if(!rs.next()) {
				 return null;
			 }
			Article article = makeArticleFromResultSet(rs, true);
			return article;
		 }finally {
			 JdbcUtil.close(rs);
			 JdbcUtil.close(pstmt);
		 }
	 }
	 
	 public void increaseReadCount(Connection conn, int articleId) throws SQLException {
		 PreparedStatement pstmt = null;
		 try {
			 pstmt = conn.prepareStatement("update PKSUNarticle set read_count = read_count+1 where article_id = ?");
			 pstmt.setInt(1, articleId);
			 pstmt.executeUpdate();
		 }finally {
			 JdbcUtil.close(pstmt);
		 }
	 }
	 
	 
	 public String selectLastSequenceNumber(Connection conn, String searchMaxSeqNum, String searchMinSeqNum) throws SQLException {
		 PreparedStatement pstmt = null;
		 ResultSet rs = null;
		 try {
			 pstmt = conn.prepareStatement("select min(sequence_no) from PKSUNarticle " 
					 + "where sequence_no < ? and sequence_no >= ?");
			 pstmt.setString(1, searchMaxSeqNum);
			 pstmt.setString(2, searchMinSeqNum);
			 rs = pstmt.executeQuery();
			 if(!rs.next()) {
				 return null;
				 
			 }
			 return rs.getString(1);
		 }finally {
			 JdbcUtil.close(rs);
			 JdbcUtil.close(pstmt);
		 }
	 }
	 
	 public int update(Connection conn, Article article) throws SQLException {
		 PreparedStatement pstmt = null;
		 try {
			 pstmt = conn.prepareStatement("update PKSUNarticle "
					 	+ "set title = ?, content = ? where article_id = ?");
			 pstmt.setString(1, article.getTitle());
			 pstmt.setString(2, article.getContent());
			 pstmt.setInt(3, article.getId());
			 return pstmt.executeUpdate();
		 }finally {
			 JdbcUtil.close(pstmt);
		 }
	 }
	 
	 public void delete(Connection conn, int articleId) throws SQLException {
		 PreparedStatement pstmt = null;
		 try {
			 pstmt = conn.prepareStatement("delete from PKSUNarticle where article_id = ?");
			 pstmt.setInt(1, articleId);
			 pstmt.executeUpdate();
			 
		 }finally {
			 JdbcUtil.close(pstmt);
		 }
	 }
}
