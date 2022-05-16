package com.kkomul.project.member;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kkomul.project.member.domain.MemberDTO;
import com.kkomul.project.member.service.IMemberService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private IMemberService service;
	
	@RequestMapping(value = "/contract", method = RequestMethod.GET)
	public void contract() throws Exception {
		
		log.info("contract..................................");
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public void joinGet(MemberDTO mDto, Model model) throws Exception {
		
		log.info("join get............................");
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String joinPost(MemberDTO mDto) throws Exception {
		
		log.info("join post............................");
		log.info(mDto.toString());
		
		service.join(mDto);
		
		return "redirect:/main/index";
	}
	
	@RequestMapping(value = "/id_check", method = RequestMethod.POST)
	public @ResponseBody String checkID(String userid) throws Exception {
		
		log.info("id_check.............................");
		
		String result = null;
		
		MemberDTO mDto = service.checkID(userid);
		
		if (mDto != null) {
			result = "1";
		} else {
			result = "-1";
		}
		
		log.info("result : " + result);
		
		return result;
	}

	@RequestMapping(value = "/email_check", method = RequestMethod.POST)
	public @ResponseBody String checkEmail(String email) throws Exception {
		
		log.info("email_check.............................");
		
		String result = null;
		
		MemberDTO mDto = service.checkEmail(email);
		
		if (mDto != null) {
			result = "1";
		} else {
			result = "-1";
		}
		
		log.info("result : " + result);
		
		return result;
	}
	
	@RequestMapping(value = "/login")
	public void loginGet() throws Exception {
		
		log.info("login get..................................");
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String loginPost(String userid, String userpwd, HttpSession session) throws Exception {
		
		log.info("login post............................");
		log.info("userid : " + userid + " / userpwd : " + userpwd);
		
		String url = null;
		
		MemberDTO mDto = service.login(userid, userpwd);

		if (mDto != null) {			
			log.info("login : " + mDto);
			session.setAttribute("loginUser", mDto);
			
			url =  "redirect:/main/index";
			
		} else if(mDto == null) {
			url =  "redirect:/member/login_fail";
		}
		
		return url;
	}
	
	@RequestMapping(value = "/login_fail")
	public void loginFail() throws Exception {
		
		log.info("login_fail.........................");
	}
	
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request) throws Exception {
		
		log.info("logout............................");

		request.getSession().invalidate();
		
		return "redirect:/main/index";
	}
	
	@RequestMapping(value = "/member_info")
	public void memberInfo(String userid, Model model) throws Exception {
		
		log.info("member_info.............................");
		
		model.addAttribute("member", service.checkID(userid));
	}
	
	@RequestMapping(value = "/member_modify_form", method = RequestMethod.POST)
	public void modifyForm(String userid, Model model) throws Exception {
		
		log.info("member_modify_form............................");
		
		model.addAttribute("member", service.checkID(userid));
	}
	
	@RequestMapping(value = "/member_modify", method = RequestMethod.POST)
	public String modify(MemberDTO mDto, Model model, 
			HttpServletRequest request, HttpSession session) throws Exception {
		
		log.info("member_modify............................");
		
		service.modify(mDto);
		
		request.getSession().invalidate();
		
		return "redirect:/main/index";
	}
	
	@RequestMapping(value = "/member_remove")
	public String remove(String userid, String userpwd, HttpServletRequest request) throws Exception {
		
		service.remove(userid, userpwd);
		request.getSession().invalidate();

		return "redirect:/main/index";		
	}
	
	@RequestMapping(value = "/profileUpload")
	public String profileUpload(@RequestParam("uploadFile")MultipartFile uploadFile, @RequestParam("userid")String userid, HttpServletRequest request, Model model) throws Exception {
		
		log.info("profileUpload.................................");
		
		String uploadPathMem = "D:\\sts-4.10.0.RELEASE\\kkomul\\src\\main\\webapp\\resources\\images\\memberFile";
		
		File uploadFolder = new File(uploadPathMem, userid);
		log.info("uploadFolder path : " + uploadFolder);
		
		if (uploadFolder.exists() == false) {
			uploadFolder.mkdirs();
		}
		
		String uploadFileName = uploadFile.getOriginalFilename();
		uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);

		MemberDTO mDto = new MemberDTO();
		mDto.setUserid(userid);
		mDto.setFileName(uploadFileName);
		
		try {
			File saveFile = new File(uploadFolder, uploadFileName);
			uploadFile.transferTo(saveFile);
			
			service.profileUpload(mDto);
			
			request.getSession().invalidate();
			
			mDto = service.checkID(userid);
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", mDto);

			model.addAttribute("msg", "프로필사진이 변경되었습니다.");
			model.addAttribute("url", "/member/profile_upload");

		} catch (IllegalStateException e) {
	        e.printStackTrace();
	    } catch (IOException e) {
	        e.printStackTrace();
	    }

		return "/member/profile_success";
	}
}

//ProfileDTO pDto = new ProfileDTO();
//String uploadFileName = uploadFile.getOriginalFilename();
//uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
//log.info("only file name : " + uploadFileName);
//
//pDto.setFileName(uploadFileName);
//
//try {
//	
//	File saveFile = new File(uploadFolder, uploadFileName);
//	uploadFile.transferTo(saveFile);
//
//} catch (IllegalStateException e) {
//    e.printStackTrace();
//} catch (IOException e) {
//    e.printStackTrace();
//}
