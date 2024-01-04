package com.spring.springBoard.board.service;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.springBoard.board.dao.BoardDao;
import com.spring.springBoard.board.vo.BoardVo;
import com.spring.springBoard.board.vo.PageVo;
import com.spring.springBoard.board.vo.ReplyVo;

@Service
public class BoardService {
	
	@Autowired
	BoardDao boardDao;
	
	public List<BoardVo> boardList(Map map) {
		List<BoardVo> boardList = boardDao.getBoardList(map);
		return boardList;
	}

	public void removeArticle(int articeNO) {
		boardDao.deleteArticle(articeNO);
		
	}

	public void modArticle(BoardVo boardVo) {
		boardDao.updateArticle(boardVo);
		
	}

	public List<BoardVo> searchList(BoardVo boardVo) {
		List<BoardVo> boardList = boardDao.searchList(boardVo);
		return boardList;
		
	}

	public BoardVo addarticle(MultipartHttpServletRequest multipartRequest, HttpServletRequest request ) throws IllegalStateException, IOException {
		// DB저장
		BoardVo boardVo = new BoardVo();
		
		String realPath = request.getSession().getServletContext().getRealPath("/");
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		String FormatTimestamp = new SimpleDateFormat("yyMMdd_HHmmss").format(timestamp);
		String stamp = FormatTimestamp+"_";
		UUID uuid_1 = UUID.randomUUID();
		UUID uuid_2 = UUID.randomUUID();
		
		String title = multipartRequest.getParameter("title");
		String content = multipartRequest.getParameter("content");
		String articleType = multipartRequest.getParameter("articleType");
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		
		boardVo.setTitle(title);
		boardVo.setContent(content);
		boardVo.setArticleType(articleType);
		boardVo.setId(userId);
		
		
		MultipartFile file1 = multipartRequest.getFile("fileName_1");
		MultipartFile file2 = multipartRequest.getFile("fileName_2");
		String file1Name = file1.getOriginalFilename();
		String file2Name = file2.getOriginalFilename();
		
		if(!(file1.isEmpty())) {
			file1.transferTo(new File(realPath+uuid_1+"_"+file1Name));
			boardVo.setFileName_1(uuid_1+"_"+file1Name);
		}
		
		if(!(file2.isEmpty())) {
			file2.transferTo(new File(realPath+uuid_2+"_"+file2Name));
			boardVo.setFileName_2(uuid_2+"_"+file2Name);
		}
		boardDao.insertArticle(boardVo);
		
		return boardVo;
		
		
	}

	public BoardVo modArticle(HttpServletRequest request, MultipartHttpServletRequest multipartRequest) throws IllegalStateException, IOException {
		
		String realPath = request.getSession().getServletContext().getRealPath("/");
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		String FormatTimestamp = new SimpleDateFormat("yyMMdd_HHmmss").format(timestamp);
		String stamp = FormatTimestamp+"_";
		
		UUID uuid_1 = UUID.randomUUID();
		UUID uuid_2 = UUID.randomUUID();
		BoardVo boardVo = new BoardVo();
		
		int articleNO = Integer.parseInt(multipartRequest.getParameter("articleNO"));
		String title = multipartRequest.getParameter("title");
		String content = multipartRequest.getParameter("content");
		String originalFileName_1 = multipartRequest.getParameter("originalFileName_1");
		String originalFileName_2 = multipartRequest.getParameter("originalFileName_2");
		String articleType = multipartRequest.getParameter("articleType");
		String writeDate = multipartRequest.getParameter("writeDate");
		java.sql.Date date = java.sql.Date.valueOf(writeDate);
		
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		boardVo.setFileName_1(originalFileName_1);
		boardVo.setFileName_2(originalFileName_2);
		boardVo.setArticleNO(articleNO);
		boardVo.setTitle(title);
		boardVo.setContent(content);
		boardVo.setArticleType(articleType);
		boardVo.setId(userId);
		boardVo.setWriteDate(date);
		
		
		MultipartFile file1 = multipartRequest.getFile("fileName_1");
		MultipartFile file2 = multipartRequest.getFile("fileName_2");
		
		if(file1!=null&&!(file1.isEmpty())) {
			String file1Name = file1.getOriginalFilename();
			File originalFile1 = new File(realPath+originalFileName_1);
			if(originalFile1.exists()) {
				originalFile1.delete();
			}
			file1.transferTo(new File(realPath+uuid_1+"_"+file1Name));
			boardVo.setFileName_1(uuid_1+"_"+file1Name);
		}
		
		if(file2!=null&&!(file2.isEmpty())) {
			String file2Name = file2.getOriginalFilename();
			File originalFile2 = new File(realPath+originalFileName_2);
			if(originalFile2.exists()) {
				originalFile2.delete();
			}
			file2.transferTo(new File(realPath+uuid_2+"_"+file2Name));
			boardVo.setFileName_2(uuid_1+"_"+file2Name);
		}
		
		boardDao.updateArticle(boardVo);
		return boardVo;
	}

	public void addreply(ReplyVo replyVo) {
		boardDao.insertReply(replyVo);
		
	}

	public List<ReplyVo> replyList(int articleNO) {
		List<ReplyVo> replyList = boardDao.getReplyList(articleNO);
		return replyList;
	}

	public void modReply(ReplyVo replyVo) {
		boardDao.updateReply(replyVo);
		
	}

	public void deleteReply(ReplyVo replyVo) {
		boardDao.deleteReply(replyVo);
		
	}

	public BoardVo getArticle(int articleNO) {
		BoardVo article = boardDao.selectArticle(articleNO);
		return article;
	}

	public PageVo makePageBlock(Map map, int pageNum, int amount) {
		int total = boardDao.getTotal(map);
		PageVo pageVo = new PageVo(pageNum, amount, total); 
		return pageVo;
	}

	public boolean modValidation(MultipartHttpServletRequest multipartRequest) {
		int titleLenth = multipartRequest.getParameter("title").getBytes().length;
		int contentLenth = multipartRequest.getParameter("content").getBytes().length;
		if(titleLenth<=500 && contentLenth <=4000) {
			return true;
		} else {
			return false;
		}
	}

	

	
	
}
