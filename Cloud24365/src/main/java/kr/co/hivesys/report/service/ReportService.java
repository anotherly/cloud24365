package kr.co.hivesys.report.service;

import java.util.List;

import kr.co.hivesys.report.vo.ReportVo;


public interface ReportService {

	List<ReportVo> selectList(ReportVo inputVo);

	String creReportId(ReportVo inputVo);
	
	int insert(ReportVo inputVo);

	ReportVo selectOne(ReportVo inputVo);

	int update(ReportVo inputVo);

	int delete(List<String> inputList);
}
