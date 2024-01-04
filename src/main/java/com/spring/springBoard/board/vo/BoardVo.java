package com.spring.springBoard.board.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component
public class BoardVo {
	private int articleNO;
	private String title;
	private String content;
	private Date writeDate;
	private String id;
	private String articleType;
	private String fileName_1;
	private String fileName_2;
	
	public BoardVo() {
		
	}

	
	
	public BoardVo(int articleNO, String title, String content, Date writeDate, String id, String articleType,
			String fileName_1, String fileName_2) {
		this.articleNO = articleNO;
		this.title = title;
		this.content = content;
		this.writeDate = writeDate;
		this.id = id;
		this.articleType = articleType;
		this.fileName_1 = fileName_1;
		this.fileName_2 = fileName_2;
	}



	public int getArticleNO() {
		return articleNO;
	}



	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
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



	public Date getWriteDate() {
		return writeDate;
	}



	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}



	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}



	public String getArticleType() {
		return articleType;
	}



	public void setArticleType(String articleType) {
		this.articleType = articleType;
	}



	public String getFileName_1() {
		return fileName_1;
	}



	public void setFileName_1(String fileName_1) {
		this.fileName_1 = fileName_1;
	}



	public String getFileName_2() {
		return fileName_2;
	}



	public void setFileName_2(String fileName_2) {
		this.fileName_2 = fileName_2;
	}
	
	



	
	
	
	
	
	
	
}
