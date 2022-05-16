package com.kkomul.project.board.domain;

import lombok.Data;

@Data
public class PageDTO {
	
	private int startPage;
	private int endPage;
	
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10; // ceil > 반환타입 double, 10 곱해줄때도 10.0 으로 써야함, 소수점 이하 자동 올림, 입력받은 숫자보다 크거나 같은 정수 중 가장 작은 정수를 리턴
		this.startPage = this.endPage - 9;
		
		int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));
		
		if (realEnd <= this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	}

}
