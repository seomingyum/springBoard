package com.spring.springBoard.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.springBoard.board.service.BoardService;
import com.spring.springBoard.member.service.MemberService;
import com.spring.springBoard.member.vo.MemberVo;
	
	

@Controller
@RequestMapping(value = "/member/*")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@RequestMapping(value = "loginForm.do", method = RequestMethod.GET)
	public ModelAndView loginForm(HttpServletRequest request) throws Exception {
		String url = getViewName(request);
		logger.info(""+url+" 함수 호출");
		String prePage = request.getHeader("Referer");
		System.out.println(prePage);
	    request.setAttribute("prePage", prePage);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/member/loginForm");
		return mav;
	}
	
	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public ModelAndView login(HttpServletRequest request,
			@ModelAttribute("articleType") String articleType,
			@ModelAttribute("info") MemberVo memberVo,
			@RequestParam(value = "prePage") String prePage
			) throws Exception {
		String url = getViewName(request);
		logger.info(""+url+" 함수 호출");
		ModelAndView mav = new ModelAndView();
		System.out.println(prePage);
		// 입력한 아이디, 비밀번호 길이 체크
		boolean result = memberService.loginVaildate(memberVo);
		if(result==false) {
			mav.addObject("msg", "아이디 또는 비밀번호의 글자수가 초과 해습니다.");
			mav.addObject("prePage", prePage);
			mav.setViewName("/member/loginForm");
			return mav;
		}
		
		BCryptPasswordEncoder pwEncoder =  new BCryptPasswordEncoder();
		// 일치하는 아이디 로그인 정보 가져오기
		MemberVo _memberVo = memberService.getLoginMember(memberVo);
		
		
		// 아이디 존재확인 및 비밀번호 확인 
		if(_memberVo!=null && pwEncoder.matches(memberVo.getPwd(), _memberVo.getPwd())) {
			if(request.getParameter("backToArticleForm").equals("backToArticleForm")) {
				HttpSession session = request.getSession();
				session.setAttribute("userId", _memberVo.getId());
				mav.setViewName("/board/articleForm");
				return mav;
			}
				HttpSession session = request.getSession();
				session.setAttribute("userId", _memberVo.getId());
				mav.setViewName("redirect:" + prePage);
				return mav;
		} else {
			mav.addObject("msg", "비밀번호 및 아이디가 일치하지 않습니다.");
			mav.addObject("prePage", prePage);
			mav.setViewName("/member/loginForm");
			return mav;
		}
	}
		
		
		
	
	@RequestMapping(value = "logout.do", method = RequestMethod.GET)
	public String login(HttpServletRequest request) throws Exception {
		String url = getViewName(request);
		logger.info(""+url+" 함수 호출");
		HttpSession session = request.getSession();
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value = "signUpForm.do", method = RequestMethod.GET)
	public ModelAndView signUpForm(HttpServletRequest request) throws Exception {
		String url = getViewName(request);
		logger.info(""+url+" 함수 호출");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName(url);
		
		return mav;
	}
	
	@RequestMapping(value = "signUp.do", method = RequestMethod.POST)
	public ModelAndView signUp(HttpServletRequest request, 
			@ModelAttribute("info") MemberVo memberVo) throws Exception {
		String url = getViewName(request);
		logger.info(""+url+" 함수 호출");
		ModelAndView mav = new ModelAndView();
		
		// 회원가입 글자 수 체크
		boolean result = memberService.signUpVaildate(memberVo);
		if(result==false) {
			mav.addObject("msg", "아이디 또는 비밀번호 또는 이름 또는 이메일의 글자 수가 초과 했습니다.");
			mav.setViewName("/member/signUpForm");
			return mav;
		}
		
		//회원가입 요청
		String msg = memberService.signUp(memberVo);
		if(msg!=null) {
			mav.setViewName("/member/signUpForm");
			mav.addObject("msg", msg);
			return mav;
		} else {
			HttpSession session = request.getSession();
			session.setAttribute("userId", memberVo.getId());
			mav.setViewName("main");
			return mav;
		}
		
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
