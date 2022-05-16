package com.kkomul.project.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kkomul.project.board.domain.Criteria;
import com.kkomul.project.board.domain.ReplyDTO;
import com.kkomul.project.board.service.IReplyService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/reply")
public class ReplyController {

	@Autowired
	private IReplyService service;
	
	@PostMapping(value = "/register")
	public String register(ReplyDTO rDto, @RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri) {
		
		log.info("replyRegister....................... rDto : " + rDto);
		
		int result = service.register(rDto);
		log.info("댓글작성 결과 : " + result);
		
		return "redirect:/board/single?bno=" + bno;
	}
	
//	@GetMapping(value = "/read")
//	@ResponseBody
//	public List<ReplyDTO> read(int bno, Model model) {
//		
//		log.info("replyRead....................... bno : " + bno);
//		
//		List<ReplyDTO> replyList = service.readReply(bno);
//		
//		for (ReplyDTO replyDto : replyList) {
//			
//			log.info(replyDto.getRegdate());
//			
//			SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//			String realRegdate = date.format(replyDto.getRegdate());
//			
//			log.info("작성일자!!!" + realRegdate);
//		}
//		
//		return replyList;
//	}
}
