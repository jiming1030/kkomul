package com.kkomul.project;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml", 
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@WebAppConfiguration
@Log4j
public class BoardControllerTest {

	@Autowired
	private WebApplicationContext ctx;
	private MockMvc mockMvc;

	@Before // 선행작업
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}

//	@Test
//	public void testList() throws Exception {
//		log.info("" + mockMvc.perform(MockMvcRequestBuilders.get("/board/boardList")
//								.param("pageNum", "1")
//								.param("amount", "10"))
//								.andReturn()
//								.getModelAndView()
//								.getModelMap());
//	}
	
//	@Test
//	public void testRegister() throws Exception {
//		
//		String resultPage = mockMvc
//							.perform(MockMvcRequestBuilders.post("/board/boardForm")
//							.param("subject", "테스트 글제목")
//							.param("content", "테스트 글내용")
//							.param("userid", "qkrwlals1030"))
//							.andReturn().getModelAndView().getViewName();
//		
//		log.info(resultPage);
//
//	}
	
//	@Test
//	public void testRead() throws Exception {
//		log.info("" + mockMvc.perform(MockMvcRequestBuilders.get("/board/boardView").param("bno", "2"))
//								.andReturn()
//								.getModelAndView()
//								.getModelMap());
//	}
	
//	@Test
//	public void testModify() throws Exception {
//		
//		String resultPage = mockMvc
//							.perform(MockMvcRequestBuilders.post("/board/boardModify")
//							.param("bno", "2")
//							.param("subject", "수정 테스트 글제목1")
//							.param("content", "수정 테스트 글내용1"))
//							.andReturn().getModelAndView().getViewName();
//		
//		log.info("testModify resultPage : " + resultPage);
//	}
	
	@Test
	public void testRemove() throws Exception {
		log.info("" + mockMvc.perform(MockMvcRequestBuilders.post("/board/remove").param("bno", "6"))
							 	.andReturn()
								.getModelAndView()
								.getModelMap());
	}
	
}
