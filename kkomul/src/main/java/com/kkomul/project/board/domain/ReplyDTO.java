package com.kkomul.project.board.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class ReplyDTO {

	public int rno;
	public int bno;
	public String replytext;
	public String replyer;
	private Date regdate;
}
