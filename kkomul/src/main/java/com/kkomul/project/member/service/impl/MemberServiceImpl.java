package com.kkomul.project.member.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kkomul.project.member.domain.MemberDTO;
import com.kkomul.project.member.persistence.IMemberDAO;
import com.kkomul.project.member.service.IMemberService;

@Service
public class MemberServiceImpl implements IMemberService {

	@Autowired
	private IMemberDAO mDao;

	@Override
	public MemberDTO checkID(String userid) throws Exception {
		
		return mDao.selMember(userid);
	}

	@Override
	public MemberDTO checkEmail(String email) throws Exception {
		
		return mDao.selEmailChk(email);
	}

	@Override
	public void join(MemberDTO mDto) throws Exception {
		
		mDao.insertMember(mDto);
	}

	@Override
	public MemberDTO login(String userid, String userpwd) throws Exception {
		
		return mDao.selLoginInfo(userid, userpwd);
	}

	@Override
	public boolean modify(MemberDTO mDto) throws Exception {
		
		return mDao.modifyMember(mDto) == 1;
	}

	@Override
	public boolean remove(String userid, String userpwd) throws Exception {
		
		return mDao.deleteMember(userid, userpwd) == 1;
	}

	@Override
	public MemberDTO checkPwd(String userpwd) throws Exception {
		
		return mDao.selPwd(userpwd);
	}

	@Override
	public void profileUpload(MemberDTO mDto) throws Exception {
		
		mDao.profileUpload(mDto);
	}
	
}
