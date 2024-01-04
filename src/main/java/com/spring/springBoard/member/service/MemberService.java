package com.spring.springBoard.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.spring.springBoard.member.dao.MemberDao;
import com.spring.springBoard.member.vo.MemberVo;

@Service
public class MemberService {
	
	@Autowired
	MemberDao memberDao;
	
	public void login(MemberVo memberVo) {
		
	}

	public MemberVo getLoginMember(MemberVo memberVo) {
		MemberVo _memberVo = memberDao.getLoginMember(memberVo);
		return _memberVo;
	}

	public String signUp(MemberVo memberVo) {
		MemberVo _memberVo = memberDao.checkIsMember(memberVo);
		
		if(_memberVo!=null) {
			String msg = "다른 사용자와 같은 아이디를 사용할 수 없습니다.";
			return msg;
			
		} else {
			BCryptPasswordEncoder pwEncoder =  new BCryptPasswordEncoder();
			String encodingPwd = pwEncoder.encode(memberVo.getPwd());
			memberVo.setPwd(encodingPwd);
			
			memberDao.addMemberToDB(memberVo);
			return null;
		}
		
		
		
	}

	public boolean signUpVaildate(MemberVo memberVo) {
		
		int idLenth = memberVo.getId().getBytes().length;
		int pwdLenth = memberVo.getPwd().getBytes().length;
		int nameLenth = memberVo.getName().getBytes().length;
		int emailLenth = memberVo.getEmail().getBytes().length;
		if(idLenth<=20 && pwdLenth <=60 && nameLenth <=50 && emailLenth <=50) {
			return true;
		} else {
			return false;
		}
		
	}

	public boolean loginVaildate(MemberVo memberVo) {
		int idLenth = memberVo.getId().getBytes().length;
		int pwdLenth = memberVo.getPwd().getBytes().length;
		if(idLenth<=20 && pwdLenth <=60) {
			return true;
		} else {
			return false;
		}
		
	}
	
}
