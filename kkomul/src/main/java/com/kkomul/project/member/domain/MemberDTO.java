package com.kkomul.project.member.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class MemberDTO {

	private String userid;
	private String userpwd;
	private String username;
	private String email;
	private String birthday;
	private Date regdate;
	private String fileName;
	
}
