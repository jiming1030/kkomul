package com.kkomul.project.board.service;

import java.util.List;

import com.kkomul.project.board.domain.BoardDTO;
import com.kkomul.project.board.domain.Criteria;
import com.kkomul.project.file.domain.BoardAttachDTO;

public interface IBoardService {

	public void register(BoardDTO bDto) throws Exception;
	public BoardDTO read(int bno) throws Exception;
	public boolean modify(BoardDTO bDto) throws Exception;
	public boolean remove(int bno) throws Exception;
	
	public List<BoardDTO> listAll(Criteria cri) throws Exception;
	public int getTotalCnt(Criteria cri) throws Exception;
	public void updateReadcount(int bno) throws Exception;
	
	public List<BoardAttachDTO> getAttachList(int bno);
	
	public List<BoardDTO> getNewList() throws Exception;
	public List<BoardDTO> getBestList() throws Exception;

}
