package com.kkomul.project.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkomul.project.board.domain.Criteria;
import com.kkomul.project.board.domain.ReplyDTO;
import com.kkomul.project.board.mapper.ReplyMapper;
import com.kkomul.project.board.service.IReplyService;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements IReplyService{

	@Autowired
	private ReplyMapper replyMapper;

	@Override
	public int register(ReplyDTO rDto) {
		
		return replyMapper.insertReply(rDto);
	}

	@Override
	public List<ReplyDTO> readReply(int bno) {
		log.info("댓글서비스 : " + bno);
		
		List<ReplyDTO> rDto = replyMapper.readReply(bno);
		
		return rDto;
	}

}
