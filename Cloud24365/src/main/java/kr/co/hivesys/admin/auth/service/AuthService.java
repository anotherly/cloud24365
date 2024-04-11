package kr.co.hivesys.admin.auth.service;

import java.util.List;

import kr.co.hivesys.admin.auth.vo.AuthVo;

public interface AuthService {
	//전체 권한 종류만
	public List<AuthVo> selectAuthType(AuthVo thvo) throws Exception;
	
	public List<AuthVo> selectAuthList(AuthVo thvo) throws Exception;
	
	//대분류 권한 조회
	public List<AuthVo> selectAuth1(AuthVo thvo) throws Exception;
	
	//중분류 권한 조회
	public List<AuthVo> selectAuth2(AuthVo thvo) throws Exception;
	
	//소분류 권한 조회
	public List<AuthVo> selectAuth3(AuthVo thvo) throws Exception;
	
	//권한 사용여부 수정
	public int updateAuth(List<AuthVo> atList) throws Exception;
	
	//url관련 권한처리
	public List<AuthVo> selectAuthUrl(AuthVo thvo) throws Exception;

	//모든 url 리스트 조회
	public List<AuthVo> authUrlList() throws Exception;

}
