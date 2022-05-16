package com.kkomul.project.board.service;

import java.util.List;

import com.kkomul.project.board.domain.ReplyDTO;

public interface IReplyService {

	public int register(ReplyDTO rDto);
	public List<ReplyDTO> readReply(int bno);
}
