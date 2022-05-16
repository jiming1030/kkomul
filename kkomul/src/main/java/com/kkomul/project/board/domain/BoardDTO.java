package com.kkomul.project.board.domain;

import java.util.Date;
import java.util.List;

import com.kkomul.project.file.domain.BoardAttachDTO;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class BoardDTO {

	private int bno;
	private String subject;
	private String content;
	private Date regdate;
	private int readcount;
	private String userid;
	
	private List<BoardAttachDTO> attachList;
}
