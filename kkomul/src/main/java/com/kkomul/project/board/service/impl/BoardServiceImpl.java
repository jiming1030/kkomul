package com.kkomul.project.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kkomul.project.board.domain.BoardDTO;
import com.kkomul.project.board.domain.Criteria;
import com.kkomul.project.board.persistence.IBoardDAO;
import com.kkomul.project.board.service.IBoardService;
import com.kkomul.project.file.domain.BoardAttachDTO;
import com.kkomul.project.file.mapper.BoardAttachMapper;

@Service
public class BoardServiceImpl implements IBoardService{

	@Autowired
	private IBoardDAO bDao;
	
	@Autowired
	private BoardAttachMapper attachMapper;
	
	@Transactional
	@Override
	public void register(BoardDTO bDto) throws Exception {
		
		bDao.createBoard(bDto);
		
		if (bDto.getAttachList() == null || bDto.getAttachList().size() < 0) {
			return;
		}
		
		bDto.getAttachList().forEach(attach -> {
			attach.setBno(bDto.getBno());
			attachMapper.insert(attach);
		});
	}

	@Override
	public BoardDTO read(int bno) throws Exception {
		
		return bDao.readBoard(bno);
	}

	@Transactional
	@Override
	public boolean modify(BoardDTO bDto) throws Exception {
		
		attachMapper.deleteAll(bDto.getBno());
		
		boolean modifyResult = bDao.updateBoard(bDto) == 1;
		
		if (modifyResult && bDto.getAttachList() != null && bDto.getAttachList().size() > 0) {
			
			bDto.getAttachList().forEach(attach -> {
				
				attach.setBno(bDto.getBno());
				attachMapper.insert(attach);
			});
		}
		
		return modifyResult;
	}

	@Transactional
	@Override
	public boolean remove(int bno) throws Exception {
		
		attachMapper.deleteAll(bno); // 첨부파일 삭제
		
		return bDao.deleteBoard(bno) == 1;
	}

	@Override
	public List<BoardDTO> listAll(Criteria cri) throws Exception {
		
		return bDao.getListWithPaging(cri);
	}

	@Override
	public int getTotalCnt(Criteria cri) throws Exception {
		
		return bDao.getTotalCnt(cri);
	}

	@Override
	public void updateReadcount(int bno) throws Exception {
		
		bDao.updateReadcount(bno);
	}

	@Override
	public List<BoardAttachDTO> getAttachList(int bno) {
		
		return attachMapper.findByBno(bno);
	}

	@Override
	public List<BoardDTO> getNewList() throws Exception {
		
		return bDao.getNewList();
	}

	@Override
	public List<BoardDTO> getBestList() throws Exception {
		
		return bDao.getBestList();
	}

}
