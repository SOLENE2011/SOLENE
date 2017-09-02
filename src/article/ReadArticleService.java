package article;

import java.sql.Connection;
import java.sql.SQLException;

import kh.jdbc.ConnectionProvider;
import kh.jdbc.JdbcUtil;

//게시글 읽기 기능을 제공한다.
public class ReadArticleService {

	private static ReadArticleService instance = new ReadArticleService();
	public static ReadArticleService getInstance() {
		return instance;
	}
	
	private ReadArticleService() {}
	
	//상세보기
	public Article readArticle(int articleId) throws ArticleNotFoundException {
		return selectArticle(articleId, true);
		
	}
	// 먼저 보기!!! 조회수를 증가시킬거면true 아니면 false! 수정하기할땐 증가안시킬거임.
	public Article selectArticle(int articleId, boolean increaseCount) 
	throws ArticleNotFoundException {
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			ArticleDao articleDao = ArticleDao.getInstance();
			Article article = articleDao.selectById(conn, articleId);
			if(article == null) {
				throw new ArticleNotFoundException(
						"게시글이 존재하지 않습니다 : " + articleId);
				
			}
			if(increaseCount) {
				articleDao.increaseReadCount(conn, articleId);
				article.setReadCount(article.getReadCount()+1);
			}
			return article;
			
		}catch (SQLException e) {
			throw new RuntimeException("DB 에러 발생: " + e.getMessage(), e);
		}finally {
			JdbcUtil.close(conn);
		}
	}
	//조회수 증가 안할거임.
	public Article getArticle(int articleId) throws ArticleNotFoundException {
		return selectArticle(articleId, false);
				
	}
	
}
