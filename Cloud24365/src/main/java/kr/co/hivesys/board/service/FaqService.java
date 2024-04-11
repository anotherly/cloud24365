package kr.co.hivesys.board.service;

import java.util.HashMap;
import java.util.List;

import kr.co.hivesys.board.vo.FaqVo;


public interface FaqService {

	List<FaqVo> selectList(FaqVo inputVo);

	String creFaqId(FaqVo inputVo);
	
	int insert(FaqVo inputVo);

	FaqVo selectOne(FaqVo inputVo);

	int update(FaqVo inputVo);

	int delete(List<String> inputList);
}
