package com.spring.springBoard.member.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.springBoard.member.vo.MemberVo;

@Repository
public class MemberDao {
	
	@Autowired
	SqlSession sqlSession;

	public MemberVo getLoginMember(MemberVo memberVo) {
		
		MemberVo _memberVo = sqlSession.selectOne("mapper.member.getLoginMember", memberVo);
		
		return _memberVo;
		
	}

	public void addMemberToDB(MemberVo memberVo) {
		sqlSession.insert("mapper.member.insertMember", memberVo);
	}

	public MemberVo checkIsMember(MemberVo memberVo) {
		MemberVo _memberVo = sqlSession.selectOne("mapper.member.checkIsMember", memberVo);
		return _memberVo;
	}
}
