package kr.co.hivesys.board.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.board.mapper.FaqMapper;
import kr.co.hivesys.board.service.FaqService;
import kr.co.hivesys.board.vo.FaqVo;

@Service("faqService")
public class FaqServiceImpl implements FaqService{

	@Resource(name="faqMapper")
	private FaqMapper faqMapper;
	
	@Override
	public List<FaqVo> selectList(FaqVo inputVo) {
		return faqMapper.selectList(inputVo);
	}
	
	@Override
	public String creFaqId(FaqVo inputVo) {
		return faqMapper.creFaqId(inputVo);
	}

	@Override
	public int insert(FaqVo inputVo) {
		return faqMapper.insert(inputVo);
	}

	@Override
	public FaqVo selectOne(FaqVo inputVo) {
		return faqMapper.selectOne(inputVo);
	}

	@Override
	public int update(FaqVo inputVo) {
		return faqMapper.update(inputVo);
	}

	@Override
	public int delete(List<String> inputList) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("chkList",inputList);
		return faqMapper.delete(map);	
	}


	
}
