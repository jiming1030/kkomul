package com.kkomul.project.board.persistence;

import java.util.List;

import com.kkomul.project.board.domain.BoardDTO;
import com.kkomul.project.board.domain.Criteria;

public interface IBoardDAO {

	public void createBoard(BoardDTO bDto) throws Exception;
	public BoardDTO readBoard(int bno) throws Exception;
	public int updateBoard(BoardDTO bDto) throws Exception;
	public int deleteBoard(int bno) throws Exception;
	
	public List<BoardDTO> getListWithPaging(Criteria cri) throws Exception;
	public int getTotalCnt(Criteria cri) throws Exception;
	public void updateReadcount(int bno) throws Exception;
	
	public List<BoardDTO> getNewList() throws Exception;
	public List<BoardDTO> getBestList() throws Exception;
}
