package com.spring.springBoard.board.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.springBoard.board.service.BoardService;
import com.spring.springBoard.board.vo.BoardVo;
import com.spring.springBoard.board.vo.PageVo;
import com.spring.springBoard.board.vo.ReplyVo;





/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/board/*")
public class BoardController {
	
	@Autowired
	BoardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@RequestMapping(value = "boardList.do")
	public ModelAndView listBoard(@ModelAttribute("info") BoardVo boardVo,
			HttpServletRequest request) throws Exception {
		logger.info("requestMapping : '/listBoard.do'");
		String str = getViewName(request);
		
		int pageNum = 1;
		int amount = 5;
		
		if(request.getParameter("pageNum") != null && request.getParameter("amount") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
			amount = Integer.parseInt(request.getParameter("amount"));
		}
		
		Map map = new HashMap<Object, Object>();
		map.put("articleType", boardVo.getArticleType());
		map.put("title", boardVo.getTitle());
		map.put("content", boardVo.getContent());
		map.put("id", boardVo.getId());
		map.put("param1", (pageNum-1)*amount);
		map.put("param2", pageNum*amount);
		
		PageVo pageVo = boardService.makePageBlock(map, pageNum, amount);
		
		List<BoardVo> boardList = boardService.boardList(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName(str);
		mav.addObject("pageVo", pageVo);
		mav.addObject("stitle", boardVo.getTitle());
		mav.addObject("scontent", boardVo.getContent());
		mav.addObject("sid", boardVo.getId());
		mav.addObject("articleType", boardVo.getArticleType());
		mav.addObject("boardList", boardList);
		
		return mav;
	}
	
	@RequestMapping(value = "viewArticle.do", method = RequestMethod.GET)
	public ModelAndView viewArticle(HttpServletRequest request,
			@ModelAttribute("info") BoardVo boardVo,
			@RequestParam(value = "stitle", required = false) String stitle,
			@RequestParam(value = "sid", required = false) String  sid,
			@RequestParam(value = "scontent", required = false) String scontent
			) throws Exception {
		String url = getViewName(request);
		logger.info(""+url+"호출");
		BoardVo article = boardService.getArticle(boardVo.getArticleNO());
		
		// List<ReplyVo> replyList = boardService.replyList(boardVo.getArticleNO());
		ModelAndView mav = new ModelAndView();
		mav.addObject("article", article);
		// mav.addObject("replyList", replyList);
		mav.addObject("stitle", stitle);
		mav.addObject("sid", sid);
		mav.addObject("scontent", scontent);
		mav.setViewName(url);
		
		return mav;
		
	}
	
	@RequestMapping(value = "articleForm.do", method = RequestMethod.GET)
	public ModelAndView articleForm(HttpServletRequest request,
			@RequestParam("articleType")String articleType,
			@RequestParam("stitle") String stitle,
			@RequestParam("scontent") String scontent,
			@RequestParam("sid") String sid) throws Exception {
		String url = getViewName(request);
		logger.info(""+url+"호출");
		ModelAndView mav = new ModelAndView();
		HttpSession session = request.getSession();
		String userId = (String)session.getAttribute("userId");
		
		if(userId!=null) {
			mav.addObject("articleType", articleType);
			mav.addObject("stitle", stitle);
			mav.addObject("scontent", scontent);
			mav.addObject("sid", sid);
			mav.setViewName(url);
			
			return mav;
		} else {
			mav.addObject("articleType", articleType);
			mav.addObject("backToArticleForm", "backToArticleForm");
			mav.addObject("stitle", stitle);
			mav.addObject("scontent", scontent);
			mav.addObject("sid", sid);
			
			mav.setViewName("/member/loginForm");
			
			return mav;
		}
		
	}
	
	
	
	@RequestMapping(value = "removeArticle.do", method = RequestMethod.POST)
	public ModelAndView removeArticle (HttpServletRequest request,
			@ModelAttribute("info") BoardVo boardVo,
			@RequestParam("stitle") String stitle,
			@RequestParam("sid") String  sid,
			@RequestParam("scontent") String scontent) throws Exception {
		System.out.println("뭐지");
		String realPath = request.getSession().getServletContext().getRealPath("/");
		String url = getViewName(request);
		logger.info(""+url+"실행");
		int articleNO = boardVo.getArticleNO();
		String fileName_1 = boardVo.getFileName_1();
		String fileName_2 = boardVo.getFileName_2();
		boardService.removeArticle(articleNO);
		
		
		File file1 = new File(realPath +fileName_1);
		File file2 = new File(realPath +fileName_2);
		
		if(file1.exists()) {
			file1.delete();
		}
		
		if(file2.exists()) {
			file2.delete();
		}
		
		ModelAndView mav = new ModelAndView();

			mav.setViewName("redirect:/board/boardList.do?articleType="+boardVo.getArticleType()+""
					+ "&title="+stitle+""
					+ "&content="+scontent+""
					+ "&id="+sid+"");
			return mav;		
		
	}
	
	@RequestMapping(value = "addArticle.do", method = RequestMethod.POST)
	public ModelAndView addArtice (HttpServletRequest request, MultipartHttpServletRequest multipartRequest,
			@RequestParam("stitle") String stitle,
			@RequestParam("scontent") String scontent,
			@RequestParam("sid") String sid) throws Exception {
		String url = getViewName(multipartRequest);
		logger.info(""+url+"호출");
		boolean result = boardService.modValidation(multipartRequest);
		ModelAndView mav = new ModelAndView();
		if(result==false) {
			mav.addObject("articleType",multipartRequest.getParameter("articleType"));
			mav.addObject("stitle",stitle);
			mav.addObject("scontent",scontent);
			mav.addObject("sid",sid);
			mav.addObject("msg", "글 작성 시 제목 또는 글 내용의 글자수가 초과했습니다.");
			mav.setViewName("/board/articleForm");
			return mav;
		}
		BoardVo boardVo = boardService.addarticle(multipartRequest, request);
		
		
		mav.setViewName("redirect:/board/boardList.do?articleType="+boardVo.getArticleType()+""
				+ "&title="+stitle+""
				+ "&content="+scontent+""
				+ "&id="+sid+"");
		
		return mav;
	}
	
	@RequestMapping(value = "modArticle.do", method = RequestMethod.POST)
	public ModelAndView modArticle(HttpServletRequest request, MultipartHttpServletRequest multipartRequest,
			@RequestParam("stitle") String stitle,
			@RequestParam("scontent") String scontent,
			@RequestParam("sid") String sid) throws Exception {
		String url = getViewName(multipartRequest);
		logger.info(""+url+"호출");
		ModelAndView mav = new ModelAndView();
		boolean result = boardService.modValidation(multipartRequest);
		if(result==false) {
			int articleNO = Integer.parseInt(multipartRequest.getParameter("articleNO"));
			BoardVo article = boardService.getArticle(articleNO);
			mav.addObject("msg", "글 수정 시 제목 또는 글 내용의 글자수가 초과했습니다.");
			mav.addObject("article", article);
			mav.setViewName("/board/viewArticle");
			return mav;
		}
		
		BoardVo boardVo = boardService.modArticle(request, multipartRequest);
		
		mav.addObject("article", boardVo);
		mav.addObject("stitle", stitle);
		mav.addObject("scontent", scontent);
		mav.addObject("sid", sid);
		mav.setViewName("/board/viewArticle");
		
		return mav;
	}
	
	private String getViewName(HttpServletRequest request) throws Exception {
		String contextPath = request.getContextPath();
		String uri = (String) request.getAttribute("javax.servlet.include.request_uri");
		if (uri == null || uri.trim().equals("")) {
			uri = request.getRequestURI();
		}

		int begin = 0;
		if (!((contextPath == null) || ("".equals(contextPath)))) {
			begin = contextPath.length();
		}

		int end;
		if (uri.indexOf(";") != -1) {
			end = uri.indexOf(";");
		} else if (uri.indexOf("?") != -1) {
			end = uri.indexOf("?");
		} else {
			end = uri.length();
		}

		String viewName = uri.substring(begin, end);
		if (viewName.indexOf(".") != -1) {
			viewName = viewName.substring(0, viewName.lastIndexOf("."));
		}
		if (viewName.lastIndexOf("/") != -1) {
			viewName = viewName.substring(viewName.lastIndexOf("/", 1), viewName.length());
		}
		return viewName;
	}
	
	
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/*
	 * @RequestMapping(value = "replyForm.do", method = RequestMethod.POST) public
	 * ModelAndView replyForm(HttpServletRequest request,
	 * 
	 * @ModelAttribute("article") BoardVo boardVo,
	 * 
	 * @RequestParam(value = "stitle", required = false) String stitle,
	 * 
	 * @RequestParam(value = "scontent", required = false) String scontent,
	 * 
	 * @RequestParam(value = "sid", required = false) String sid,
	 * 
	 * @RequestParam(value = "originalFileName_1", required = false) String
	 * fileName_1,
	 * 
	 * @RequestParam(value = "originalFileName_2", required = false) String
	 * fileName_2 ) throws Exception { String url = getViewName(request);
	 * logger.info(""+url+"호출"); ModelAndView mav = new ModelAndView();
	 * mav.addObject("stitle", stitle); mav.addObject("scontent", scontent);
	 * mav.addObject("sid", sid); mav.addObject("fileName_1", fileName_1);
	 * mav.addObject("fileName_2", fileName_2); mav.setViewName("/board/replyForm");
	 * 
	 * 
	 * return mav; }
	 * 
	 * @RequestMapping(value = "addReply.do", method = RequestMethod.POST) public
	 * ModelAndView addReply(HttpServletRequest request,
	 * 
	 * @ModelAttribute("reply")ReplyVo replyVo,
	 * 
	 * @ModelAttribute("article") BoardVo boardVo,
	 * 
	 * @RequestParam(value = "articleId") String articleId,
	 * 
	 * @RequestParam(value = "stitle") String stitle,
	 * 
	 * @RequestParam(value = "scontent") String scontent,
	 * 
	 * @RequestParam(value = "sid") String sid) throws Exception { String url =
	 * getViewName(request); logger.info(""+url+"호출");
	 * 
	 * boardService.addreply(replyVo); ModelAndView mav = new ModelAndView();
	 * 
	 * mav.setViewName("/board/viewArticle"); mav.addObject("title",
	 * boardVo.getTitle()); mav.addObject("content", boardVo.getContent());
	 * mav.addObject("fileName_1", boardVo.getFileName_1());
	 * mav.addObject("fileName_2", boardVo.getFileName_2());
	 * mav.addObject("articleNO", boardVo.getArticleNO());
	 * mav.addObject("writeDate", boardVo.getWriteDate()); mav.addObject("stitle",
	 * stitle); mav.addObject("scontent", scontent); mav.addObject("sid", sid);
	 * mav.addObject("articleType", boardVo.getArticleType()); List<ReplyVo>
	 * replyList = boardService.replyList(boardVo.getArticleNO());
	 * mav.addObject("replyList", replyList);
	 * 
	 * 
	 * 
	 * return mav; }
	 * 
	 * 
	 * @RequestMapping(value = "modReply.do", method = RequestMethod.POST) public
	 * ModelAndView modReply(HttpServletRequest request,
	 * 
	 * @ModelAttribute("reply")ReplyVo replyVo,
	 * 
	 * @ModelAttribute("article") BoardVo boardVo,
	 * 
	 * @RequestParam(value = "articleId", required = false) String articleId,
	 * 
	 * @RequestParam(value = "stitle", required = false) String stitle,
	 * 
	 * @RequestParam(value = "scontent", required = false) String scontent,
	 * 
	 * @RequestParam(value = "sid", required = false) String sid) throws Exception {
	 * String url = getViewName(request); logger.info(""+url+"호출");
	 * boardService.modReply(replyVo); ModelAndView mav = new ModelAndView();
	 * 
	 * mav.setViewName("/board/viewArticle"); mav.addObject("title",
	 * boardVo.getTitle()); mav.addObject("content", boardVo.getContent());
	 * mav.addObject("fileName_1", boardVo.getFileName_1());
	 * mav.addObject("fileName_2", boardVo.getFileName_2());
	 * mav.addObject("articleNO", boardVo.getArticleNO());
	 * mav.addObject("writeDate", boardVo.getWriteDate()); mav.addObject("stitle",
	 * stitle); mav.addObject("scontent", scontent); mav.addObject("sid", sid);
	 * mav.addObject("articleType", boardVo.getArticleType()); List<ReplyVo>
	 * replyList = boardService.replyList(boardVo.getArticleNO());
	 * mav.addObject("replyList", replyList);
	 * 
	 * return mav; }
	 * 
	 * @RequestMapping(value = "deleteReply.do", method = RequestMethod.POST) public
	 * ModelAndView deleteReply(HttpServletRequest request,
	 * 
	 * @ModelAttribute("reply")ReplyVo replyVo,
	 * 
	 * @ModelAttribute("article") BoardVo boardVo,
	 * 
	 * @RequestParam(value = "articleId", required = false) String articleId,
	 * 
	 * @RequestParam(value = "stitle", required = false) String stitle,
	 * 
	 * @RequestParam(value = "scontent", required = false) String scontent,
	 * 
	 * @RequestParam(value = "sid", required = false) String sid) throws Exception {
	 * String url = getViewName(request); logger.info(""+url+"호출"); ModelAndView mav
	 * = new ModelAndView();
	 * 
	 * boardService.deleteReply(replyVo);
	 * 
	 * mav.setViewName("/board/viewArticle"); mav.addObject("title",
	 * boardVo.getTitle()); mav.addObject("content", boardVo.getContent());
	 * mav.addObject("fileName_1", boardVo.getFileName_1());
	 * mav.addObject("fileName_2", boardVo.getFileName_2());
	 * mav.addObject("articleNO", boardVo.getArticleNO());
	 * mav.addObject("writeDate", boardVo.getWriteDate()); mav.addObject("stitle",
	 * stitle); mav.addObject("scontent", scontent); mav.addObject("sid", sid);
	 * mav.addObject("articleType", boardVo.getArticleType()); List<ReplyVo>
	 * replyList = boardService.replyList(boardVo.getArticleNO());
	 * mav.addObject("replyList", replyList);
	 * 
	 * 
	 * return mav; }
	 */
	
	
	
	

