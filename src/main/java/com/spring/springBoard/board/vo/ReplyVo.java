package com.spring.springBoard.board.vo;

import java.sql.Date;

public class ReplyVo {
	private int replyNO;
	private String replyContent;
	private Date replyDate;
	private String id;
	private int articleNO;
	public int getReplyNO() {
		return replyNO;
	}
	public void setReplyNO(int replyNO) {
		this.replyNO = replyNO;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public Date getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(Date replyDate) {
		this.replyDate = replyDate;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getArticleNO() {
		return articleNO;
	}
	public void setArticleNO(int articleNO) {
		this.articleNO = articleNO;
	}
	
	
	
	
}
