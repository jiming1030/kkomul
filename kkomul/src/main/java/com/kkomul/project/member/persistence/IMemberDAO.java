package com.kkomul.project.member.persistence;

import com.kkomul.project.member.domain.MemberDTO;

public interface IMemberDAO {

	public MemberDTO selMember(String userid) throws Exception;
	public MemberDTO selEmailChk(String email) throws Exception;
	public void insertMember(MemberDTO mDto) throws Exception;
	public MemberDTO selLoginInfo(String userid, String userpwd) throws Exception;
	public int modifyMember(MemberDTO mDto) throws Exception;
	public int deleteMember(String userid, String userpwd) throws Exception;
	public MemberDTO selPwd(String userpwd) throws Exception;
	public void profileUpload(MemberDTO mDto) throws Exception;
}
