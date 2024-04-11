package kr.co.hivesys.board.service;

import java.util.List;

import kr.co.hivesys.board.vo.NoticeVo;


public interface NoticeService {

	List<NoticeVo> selectList(NoticeVo inputVo);

	String creNoticeId(NoticeVo inputVo);
	
	int insert(NoticeVo inputVo);

	NoticeVo selectOne(NoticeVo inputVo);

	int update(NoticeVo inputVo);

	int delete(List<String> inputList);
}
