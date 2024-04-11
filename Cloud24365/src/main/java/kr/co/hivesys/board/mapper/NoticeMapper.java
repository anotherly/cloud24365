package kr.co.hivesys.board.mapper;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.hivesys.board.vo.NoticeVo;
import kr.co.hivesys.board.vo.QnaVo;

@Mapper("noticeMapper")
public interface NoticeMapper {

	List<NoticeVo> selectList(NoticeVo inputVo);

	String creNoticeId(NoticeVo inputVo);
	
	int insert(NoticeVo inputVo);

	NoticeVo selectOne(NoticeVo inputVo);

	int update(NoticeVo inputVo);

	int delete(HashMap<String, Object> map);
	
}
