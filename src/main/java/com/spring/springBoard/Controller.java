package com.spring.springBoard;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


@org.springframework.stereotype.Controller
@RequestMapping
public class Controller {
	
	private static final Logger logger = LoggerFactory.getLogger(Controller.class);

	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public void home3(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		logger.info("requestMapping : '/'");
//		request.setAttribute("articleType", "board1");
		RequestDispatcher dispatcher = request.getRequestDispatcher("board/boardList.do?articleType=board1"); 
        dispatcher.forward(request, response); 
		
		
	}
}
