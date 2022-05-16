package com.kkomul.project.board.mapper;

import java.util.List;

import com.kkomul.project.board.domain.ReplyDTO;

public interface ReplyMapper {

	public int insertReply(ReplyDTO rDto);
	public List<ReplyDTO> readReply(int bno);
}
