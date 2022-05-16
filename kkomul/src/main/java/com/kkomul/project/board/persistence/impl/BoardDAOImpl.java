package com.kkomul.project.board.persistence.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kkomul.project.board.domain.BoardDTO;
import com.kkomul.project.board.domain.Criteria;
import com.kkomul.project.board.persistence.IBoardDAO;

@Repository
public class BoardDAOImpl implements IBoardDAO{

	@Autowired
	private SqlSession sqlsession;

	@Override
	public void createBoard(BoardDTO bDto) throws Exception {
		
		sqlsession.insert("BoardMapper.createBoard", bDto);
	}

	@Override
	public BoardDTO readBoard(int bno) throws Exception {
		
		return sqlsession.selectOne("BoardMapper.readBoard", bno);
	}

	@Override
	public int updateBoard(BoardDTO bDto) throws Exception {
		
		return sqlsession.update("BoardMapper.updateBoard", bDto);
	}

	@Override
	public int deleteBoard(int bno) throws Exception {
		
		return sqlsession.delete("BoardMapper.deleteBoard", bno);
	}

	@Override
	public List<BoardDTO> getListWithPaging(Criteria cri) throws Exception {
		
		return sqlsession.selectList("BoardMapper.getListWithPaging", cri);
	}

	@Override
	public int getTotalCnt(Criteria cri) throws Exception {
		
		return sqlsession.selectOne("BoardMapper.getTotalCnt", cri);
	}

	@Override
	public void updateReadcount(int bno) throws Exception {
		
		sqlsession.update("BoardMapper.updateReadcount", bno);
	}

	@Override
	public List<BoardDTO> getNewList() throws Exception {
		
		return sqlsession.selectList("BoardMapper.getNewList");
	}

	@Override
	public List<BoardDTO> getBestList() throws Exception {
		
		return sqlsession.selectList("BoardMapper.getBestList");
	}

}
