package com.spring.springBoard.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.springBoard.board.vo.BoardVo;
import com.spring.springBoard.board.vo.ReplyVo;

@Repository
public class BoardDao {
	
	@Autowired
	SqlSession sqlSession;
	
	public List<BoardVo> getBoardList(Map map) {
		
		List<BoardVo> boardList = sqlSession.selectList("mapper.board.selectAllBoardList", map);
		
		return boardList;
		
	}

	public void deleteArticle(int articleNO) {
		
		sqlSession.delete("mapper.board.deleteArticle", articleNO);
	}

	public void insertArticle(BoardVo boardVo) {
		sqlSession.insert("mapper.board.insertArticle", boardVo);
		
	}

	public void updateArticle(BoardVo boardVo) {
		sqlSession.update("mapper.board.updateArticle", boardVo);
		
	}

	public List<BoardVo> searchList(BoardVo boardVo) {
		List<BoardVo> boardList = sqlSession.selectList("mapper.board.searchList", boardVo);
		return null;
	}

	public void insertReply(ReplyVo replyVo) {
		sqlSession.insert("mapper.board.insertReply",replyVo);
		
	}

	public List<ReplyVo> getReplyList(int articleNO) {
		List<ReplyVo> replyList = sqlSession.selectList("mapper.board.selectAllReplyList", articleNO);
		return replyList;
	}

	public void updateReply(ReplyVo replyVo) {
		sqlSession.update("mapper.board.updateReply", replyVo);
		
	}

	public void deleteReply(ReplyVo replyVo) {
		sqlSession.delete("mapper.board.deleteReply", replyVo);
		
	}

	public BoardVo selectArticle(int articleNO) {
		BoardVo article = sqlSession.selectOne("mapper.board.selectArticle", articleNO);
		return article;
	}

	public int getTotal(Map map) {
		int total = sqlSession.selectOne("mapper.board.getTotal",map);
		return total;
	}

}
