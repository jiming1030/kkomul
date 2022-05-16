package com.kkomul.project.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.NoHandlerFoundException;

@ControllerAdvice // 컨트롤러에서 예외가 발생하면 얘와 결합, 감지!
public class CommonExceptionAdvice {

	private static final Logger logger = 
			LoggerFactory.getLogger(CommonExceptionAdvice.class);
	
	@ExceptionHandler(Exception.class) // 감지 후 어떤 동작이 일어나도록 핸들링
	public String except(Exception ex, Model model) {
		logger.error("Exception....................{}", ex); // ex가 {} 안으로 들어감		

		model.addAttribute("exception", ex);
		
		logger.error("Model....................{}", model); // model이 {} 안으로 들어감		

		return "error_page";
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
	@ResponseStatus(HttpStatus.NOT_FOUND)
	public String handle404(NoHandlerFoundException ex) {
		return "custom404";
	}
}
