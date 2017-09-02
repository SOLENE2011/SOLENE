package article;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import kh.jdbc.ConnectionProvider;
import kh.jdbc.JdbcUtil;


//게시글 목록을 제공함

public class ListArticleService {

	private static ListArticleService instance = new ListArticleService();
	public static ListArticleService getInstance() {
		return instance;
	}
	
	public static final int COUNT_PER_PAGE = 10;
	
	//일반게시글 보여줄때!!!
	public ArticleListModel getArticleList(int requestPageNumber) {
		if (requestPageNumber < 0) {
			throw new IllegalArgumentException("page number < 0 : "
						+ requestPageNumber);
		}
		ArticleDao articleDao = ArticleDao.getInstance();
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			
			//전체 게시글 개수 구함
			int totalArticleCount = articleDao.selectCount(conn);
			
			if(totalArticleCount == 0) {
				return new ArticleListModel();
			}
			
			int totalPageCount = calculateTotalPageCount(totalArticleCount);
			
			int firstRow = (requestPageNumber -1) * COUNT_PER_PAGE +1;
			int endRow = firstRow + COUNT_PER_PAGE -1;
			
			if(endRow > totalArticleCount) {
				endRow = totalArticleCount;
			}
			List<Article> articleList = articleDao.select(conn, firstRow, endRow);
			ArticleListModel articleListView = new ArticleListModel(articleList, requestPageNumber, totalPageCount, firstRow, endRow);
			return articleListView;
			
		}catch(SQLException e) {
			throw new RuntimeException("DB 에러 발생:" + e.getMessage(), e);
		}finally {
			JdbcUtil.close(conn);
			
		}
	}
	
	public ArticleListModel getArticleList(int requestPageNumber,int searchn, String search) {
		if (requestPageNumber < 0) {
			//list에서 PageNumber 기본값 1로 설정함 0보다 작으면 예외발생!!!
			throw new IllegalArgumentException("page number < 0 : "
						+ requestPageNumber);
		}
		ArticleDao articleDao = ArticleDao.getInstance();
		Connection conn = null;
		try {
			conn = ConnectionProvider.getConnection();
			
			//전체 게시글 개수 구함
			int totalArticleCount = articleDao.selectCount(conn, searchn, search);
			
			if(totalArticleCount == 0) {
				return new ArticleListModel();
			}
			
			int totalPageCount = calculateTotalPageCount(totalArticleCount);
			
			int firstRow = (requestPageNumber -1) * COUNT_PER_PAGE +1;
			int endRow = firstRow + COUNT_PER_PAGE -1;
			
			if(endRow > totalArticleCount) {
				endRow = totalArticleCount;
			}
			List<Article> articleList = articleDao.select(conn, firstRow, endRow, searchn, search);
			ArticleListModel articleListView = new ArticleListModel(articleList, requestPageNumber, totalPageCount, firstRow, endRow);
			return articleListView;
			
		}catch(SQLException e) {
			throw new RuntimeException("DB 에러 발생:" + e.getMessage(), e);
		}finally {
			JdbcUtil.close(conn);
			
		}
	}
	
	private int calculateTotalPageCount(int totalArticleCount) {
		if(totalArticleCount == 0) {
			return 0;
		}
		
		int pageCount = totalArticleCount / COUNT_PER_PAGE;
		if(totalArticleCount % COUNT_PER_PAGE > 0) {
			pageCount++;
		}
	return pageCount;
	}
	
}
