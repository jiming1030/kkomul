package com.kkomul.project.board;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kkomul.project.board.domain.BoardDTO;
import com.kkomul.project.board.domain.Criteria;
import com.kkomul.project.board.domain.PageDTO;
import com.kkomul.project.board.service.IBoardService;
import com.kkomul.project.board.service.IReplyService;
import com.kkomul.project.file.domain.BoardAttachDTO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private IBoardService service;
	@Autowired
	private IReplyService rService;
	
	private String uploadPathBoard = "D:\\sts-4.10.0.RELEASE\\kkomul\\src\\main\\webapp\\resources\\images\\boardFile";

	@RequestMapping(value = "/boardList")
	public void listAll(Criteria cri, Model model) throws Exception {

		log.info("listAll........................ cri : " + cri);
		
		model.addAttribute("boardInfo", service.listAll(cri));
		
		int total = service.getTotalCnt(cri);
		log.info("listAll ........................ total : " + total);
		
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}

	@RequestMapping(value = "/boardForm", method = RequestMethod.GET)
	public void registerGet(BoardDTO bDto, Model model) throws Exception { 

		log.info("boardForm get............................");

	}

	@RequestMapping(value = "/boardAdd", method = RequestMethod.POST)
	public String boardFormPost(BoardDTO bDto) throws Exception { 
		log.info("boardAdd post...........................");
		log.info(bDto.toString());
		
		if (bDto.getAttachList() != null) {
			bDto.getAttachList().forEach(attach -> log.info("" + attach));
		}
		
		service.register(bDto);
		
		return "redirect:/board/boardList";
	}

//	@RequestMapping(value = "/boardView", method = RequestMethod.GET)
//	public void read(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) throws Exception {
//		
//		log.info("read......................................" + bno);
//		
//		service.updateReadcount(bno);
//		model.addAttribute("boardInfo", service.read(bno));	
//	}

	@RequestMapping(value = "/single", method = RequestMethod.GET)
	public void singleGet(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) throws Exception { 

		log.info("single get............................");

		model.addAttribute("boardInfo", service.read(bno));	
		model.addAttribute("replies", rService.readReply(bno));
	}

	@RequestMapping(value = "/boardModify_form", method = RequestMethod.POST)
	public void modifyGet(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		
		log.info("modify_form...............................");
		
		model.addAttribute("boardInfo", service.read(bno)); // modify 로 페이지 전환되면서 service.read(bno)의 결과물이 전달됨
	}

	@RequestMapping(value = "/boardModify", method = RequestMethod.POST)
	public String modifyPost(BoardDTO bDto, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception { // 위의 get 방식으로 넘어온 페이지에서 수정이 이루어진 것들을 받아옴
		
		log.info("modify post........................");
		
		service.modify(bDto);
		
		return "redirect:/board/boardList" + cri.getListLink();
	}

	// 첨부파일 삭제
	private void deleteFiles(List<BoardAttachDTO> attachList) {
		
		if (attachList == null || attachList.size() == 0) {
			return;
		}
		
		log.info("delete attach files......................");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try {
				Path file = Paths.get(uploadPathBoard + "\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
				
				Files.deleteIfExists(file);
				
				if (Files.probeContentType(file).startsWith("image")) {
					Path thumbNail = Paths.get(uploadPathBoard + "\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_" + attach.getFileName());
					
					Files.delete(thumbNail);
				}
			} catch (Exception e) {
				log.error("delete file error : " + e.getMessage());
			}
		});
	}

	@RequestMapping(value = "/remove", method = RequestMethod.POST)
	public String remove(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) throws Exception {
		
		log.info("remove................................" + bno);
		
		List<BoardAttachDTO> attachList = service.getAttachList(bno);
		
		if (service.remove(bno)) {
			
			// 첨부파일 삭제
			deleteFiles(attachList);
		}
		
		return "redirect:/board/boardList" + cri.getListLink();
	}
	
	@GetMapping(value = "/getAttachList",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<BoardAttachDTO>> getAttachList(int bno) {
		
		log.info("getAttachList : " + bno);
		
		return new ResponseEntity<List<BoardAttachDTO>>(service.getAttachList(bno), HttpStatus.OK);
	}
}
