package article;

import java.util.Date;

//게시글 데이터를 표현할때 사용
public class Article {

	private int id;
	private int groupId;
	private String sequenceNumber;
	private Date postingDate;
	private int readCount;
	private String writerName;
	private String password;
	private String title;
	private String content;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getGroupId() {
		return groupId;
	}
	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}
	public String getSequenceNumber() {
		return sequenceNumber;
	}
	public void setSequenceNumber(String sequenceNumber) {
		this.sequenceNumber = sequenceNumber;
	}
	public Date getPostingDate() {
		return postingDate;
	}
	public void setPostingDate(Date postingDate) {
		this.postingDate = postingDate;
	}
	public int getReadCount() {
		return readCount;
	}
	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}
	public String getWriterName() {
		return writerName;
	}
	public void setWriterName(String writerName) {
		this.writerName = writerName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	//sequenceNumber를 이용해서 게시글의 중첩레벨을 구한다.
	public int getLevel() {
		if (sequenceNumber == null) {
			return -1;
		}
		
		if(sequenceNumber.length() != 16) {
			return -1;
		}
		if(sequenceNumber.endsWith("999999")) {
			return 0;
		}
		if(sequenceNumber.endsWith("9999")) {
			return 1;
		}
		if(sequenceNumber.endsWith("99")) {
			return 2;
		}
		return 3;
	}
	
	
	
}
