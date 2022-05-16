package com.kkomul.project.member.persistence.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kkomul.project.member.domain.MemberDTO;
import com.kkomul.project.member.persistence.IMemberDAO;

@Repository
public class MemberDAOImpl implements IMemberDAO {

	@Autowired
	private SqlSession sqlsession;
	
	@Override
	public MemberDTO selMember(String userid) throws Exception {
		
		return sqlsession.selectOne("MemberMapper.selMember", userid);
	}

	@Override
	public MemberDTO selEmailChk(String email) throws Exception {

		return sqlsession.selectOne("MemberMapper.selEmailChk", email);
	}

	@Override
	public void insertMember(MemberDTO mDto) throws Exception {
		
		sqlsession.insert("MemberMapper.insertMember", mDto);
	}

	@Override
	public MemberDTO selLoginInfo(String userid, String userpwd) throws Exception {
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("userid", userid);
		paramMap.put("userpwd", userpwd);
		
		return sqlsession.selectOne("MemberMapper.selLoginInfo", paramMap);
	}

	@Override
	public int modifyMember(MemberDTO mDto) throws Exception {
		
		return sqlsession.update("MemberMapper.modifyMember", mDto);
	}

	@Override
	public int deleteMember(String userid, String userpwd) throws Exception {
		
		Map<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("userid", userid);
		paramMap.put("userpwd", userpwd);

		return sqlsession.delete("MemberMapper.deleteMember", paramMap);
	}

	@Override
	public MemberDTO selPwd(String userpwd) throws Exception {
		
		return sqlsession.selectOne("MemberMapper.selPwd", userpwd);
	}

	@Override
	public void profileUpload(MemberDTO mDto) throws Exception {
		
		sqlsession.update("MemberMapper.profileUpload", mDto);
	}

}
