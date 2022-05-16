package com.kkomul.project;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.kkomul.project.board.domain.BoardDTO;
import com.kkomul.project.board.domain.Criteria;
import com.kkomul.project.board.persistence.IBoardDAO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/**/root-context.xml")
@WebAppConfiguration
@Log4j
public class IBoardDAOTest {

	@Autowired
	private IBoardDAO bDao;
	
	@Test
	public void testCreateBoard() throws Exception {
		BoardDTO bDto = new BoardDTO();

		bDto.setSubject("글제목3");
		bDto.setContent("글내용3");
		bDto.setUserid("qkrwlals1030");
		
		bDao.createBoard(bDto);
	}

//	@Test
//	public void testReadBoard() throws Exception {
//		
//		log.info("testReadBoard : " + bDao.readBoard(1));
//	}

//	@Test
//	public void testUpdateBoard() throws Exception {	
//		BoardDTO bDto = new BoardDTO();
//		
//		bDto.setBno(1);
//		bDto.setSubject("글제목 수정");
//		bDto.setContent("글내용 수정");
//
//		bDao.updateBoard(bDto);
//	}
	
//	@Test
//	public void testDeleteBoard() throws Exception {
//		
//		bDao.deleteBoard(1);
//	}
	
	@Test
	public void testListCriteria() throws Exception {
		Criteria cri = new Criteria();
		
		cri.setPageNum(1);
		cri.setAmount(10);
		
		List<BoardDTO> list = bDao.getListWithPaging(cri);
		list.forEach(board -> log.info(board.getBno() + " : " + board.getContent()));
	}

}
