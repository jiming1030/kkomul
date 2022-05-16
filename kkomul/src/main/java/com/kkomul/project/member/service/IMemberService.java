package com.kkomul.project.member.service;

import com.kkomul.project.member.domain.MemberDTO;

public interface IMemberService {

	public MemberDTO checkID(String userid) throws Exception;
	public MemberDTO checkEmail(String email) throws Exception;
	public void join(MemberDTO mDto) throws Exception;
	public MemberDTO login(String userid, String userpwd) throws Exception;
	public boolean modify(MemberDTO mDto) throws Exception;
	public boolean remove(String userid, String userpwd) throws Exception;
	public MemberDTO checkPwd(String userpwd) throws Exception;
	public void profileUpload(MemberDTO mDto) throws Exception;
}
