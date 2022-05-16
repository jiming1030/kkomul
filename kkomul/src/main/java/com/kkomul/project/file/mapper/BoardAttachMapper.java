package com.kkomul.project.file.mapper;

import java.util.List;

import com.kkomul.project.file.domain.BoardAttachDTO;

public interface BoardAttachMapper {

	public void insert(BoardAttachDTO boardAttachDto);
	public void delete(String uuid);
	public List<BoardAttachDTO> findByBno(int bno);
	public void deleteAll(int bno);
	
}
