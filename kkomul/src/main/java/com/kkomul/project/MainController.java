package com.kkomul.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kkomul.project.board.service.IBoardService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/main")
public class MainController {

	@Autowired
	private IBoardService service;
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public void indexGet(Model model) throws Exception {
		
		log.info("main Get............................");
		
		model.addAttribute("newBoard", service.getNewList());
		model.addAttribute("bestBoard", service.getBestList());
		
	}

	@RequestMapping(value = "/index", method = RequestMethod.POST)
	public void indexPost() throws Exception {
		
		log.info("main Post............................");
	}

}
