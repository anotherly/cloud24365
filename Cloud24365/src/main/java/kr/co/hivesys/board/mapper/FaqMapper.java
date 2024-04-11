package kr.co.hivesys.board.mapper;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.hivesys.board.vo.FaqVo;

@Mapper("faqMapper")
public interface FaqMapper {

	List<FaqVo> selectList(FaqVo inputVo);

	String creFaqId(FaqVo inputVo);
	
	int insert(FaqVo inputVo);

	FaqVo selectOne(FaqVo inputVo);

	int update(FaqVo inputVo);

	int delete(HashMap<String, Object> map);
	
}
