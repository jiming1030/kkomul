package com.kkomul.project;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kkomul.project.member.domain.MemberDTO;
import com.kkomul.project.member.persistence.IMemberDAO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
@WebAppConfiguration
@Log4j
public class IMemberDAOTest {

	@Autowired
	private IMemberDAO mDao;
	
	// 회원가입 테스트
//	@Test
//	public void testInsertMember() throws Exception {
//		MemberDTO mDto = new MemberDTO();
//		
//		mDto.setUserid("user03");
//		mDto.setUserpwd("1234");
//		mDto.setUsername("eunjin");
//		mDto.setEmail("user03@aaa.com");
//		mDto.setBirthday("2022-01-09");
//		mDto.setFileName("default.jpg");
//		
//		mDao.insertMember(mDto);
//	}
	
	// 회원정보 조회 테스트 (아이디)
//	@Test
//	public void testSelMember() throws Exception {
//		
//		MemberDTO mDto = mDao.selMember("user01");
//		
//		log.info("testSelMember : " + mDto.toString());
//	}
	
	// 이메일체크 테스트
//	@Test
//	public void testSelEmail() throws Exception {
//		
//		MemberDTO mDto = mDao.selEmailChk("user01@aaa.com");
//		
//		log.info("testSelEmail : " + mDto.toString());
//	}

	// 회원정보 조회 테스트 (아이디,비번)
//	@Test
//	public void testSelLoginInfo() throws Exception {
//		
//		MemberDTO mDto = mDao.selLoginInfo("user03", "1234");
//		
//		log.info("testSelLoginInfo : " + mDto.toString());
//	}
	
	// 회원정보 수정 테스트
//	@Test
//	public void testModifyMember() throws Exception {
//		
//		MemberDTO mDto = new MemberDTO();
//		
//		mDto.setUserid("user01");
//		mDto.setUserpwd("1234");
//		mDto.setUsername("jimin");
//		mDto.setEmail("user01@aaa.com");
//		mDto.setBirthday("1995-10-30");
//		
//		int result = mDao.modifyMember(mDto);
//
//		log.info("testModifyMember : " + result);
//	}
	
	// 회원 탈퇴 테스트
	@Test
	public void testDeleteMember() throws Exception {
	
		int result = mDao.deleteMember("user03", "1234");
		
		log.info("testDeleteMember : " + result);
	}
	
}
