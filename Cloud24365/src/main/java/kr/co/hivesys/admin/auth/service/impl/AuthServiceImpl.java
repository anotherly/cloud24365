package kr.co.hivesys.admin.auth.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.admin.auth.mapper.AuthMapper;
import kr.co.hivesys.admin.auth.service.AuthService;
import kr.co.hivesys.admin.auth.vo.AuthVo;

@Service("authService")
public class AuthServiceImpl implements AuthService{
	@Resource(name="authMapper")
	private AuthMapper authMapper;

	@Override
	public List<kr.co.hivesys.admin.auth.vo.AuthVo> selectAuthType(AuthVo thvo) throws Exception{
		return authMapper.selectAuthType(thvo);
	}
	
	@Override
	public List<AuthVo> selectAuthList(AuthVo thvo){
		return authMapper.selectAuthList(thvo);
	}
	
	
	@Override
	public List<AuthVo> selectAuth1(AuthVo thvo)  throws Exception{
		return authMapper.selectAuth1(thvo);
	}

	@Override
	public List<AuthVo> selectAuth2(AuthVo thvo)  throws Exception{
		return authMapper.selectAuth2(thvo);
	}
	
	//소분류 권한 조회
	@Override
	public List<AuthVo> selectAuth3(AuthVo thvo) throws Exception{
		return authMapper.selectAuth3(thvo);
	}

	@Override
	public int updateAuth(List<AuthVo> atList)  throws Exception{
		return authMapper.updateAuth(atList);
	}

	@Override
	public List<AuthVo> selectAuthUrl(AuthVo thvo) throws Exception {
		return authMapper.selectAuthUrl(thvo);
	}
	
	@Override
	public List<AuthVo> authUrlList() throws Exception {
		return authMapper.authUrlList();
	}
	
}
