package kr.co.hivesys.board.mapper;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.hivesys.board.vo.ReportVo;

@Mapper("reportMapper")
public interface ReportMapper {

	List<ReportVo> selectList(ReportVo inputVo);

	String creReportId(ReportVo inputVo);
	
	int insert(ReportVo inputVo);

	ReportVo selectOne(ReportVo inputVo);

	int update(ReportVo inputVo);

	int delete(HashMap<String, Object> map);
	
}
