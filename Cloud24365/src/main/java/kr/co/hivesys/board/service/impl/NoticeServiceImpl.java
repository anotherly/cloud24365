package kr.co.hivesys.board.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.board.mapper.NoticeMapper;
import kr.co.hivesys.board.service.NoticeService;
import kr.co.hivesys.board.vo.NoticeVo;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{

	@Resource(name="noticeMapper")
	private NoticeMapper noticeMapper;
	
	@Override
	public List<NoticeVo> selectList(NoticeVo inputVo) {
		return noticeMapper.selectList(inputVo);
	}
	
	@Override
	public String creNoticeId(NoticeVo inputVo) {
		return noticeMapper.creNoticeId(inputVo);
	}

	@Override
	public int insert(NoticeVo inputVo) {
		return noticeMapper.insert(inputVo);
	}

	@Override
	public NoticeVo selectOne(NoticeVo inputVo) {
		return noticeMapper.selectOne(inputVo);
	}

	@Override
	public int update(NoticeVo inputVo) {
		return noticeMapper.update(inputVo);
	}

	@Override
	public int delete(List<String> inputList) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("chkList",inputList);
		return noticeMapper.delete(map);	
	}


	
}
