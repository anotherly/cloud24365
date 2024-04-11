package kr.co.hivesys.admin.auth.mapper;

import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.hivesys.admin.auth.vo.AuthVo;

@Mapper("authMapper")
public interface AuthMapper {

	List<AuthVo> selectAuthType(AuthVo thvo);

	List<AuthVo> selectAuth1(AuthVo thvo);

	List<AuthVo> selectAuth2(AuthVo thvo);

	List<AuthVo> selectAuth3(AuthVo thvo);
	
	int updateAuth(List<AuthVo> alist);

	List<AuthVo> selectAuthUrl(AuthVo thvo);

	List<AuthVo> authUrlList();

	List<AuthVo> selectAuthList(AuthVo thvo);

	
}
