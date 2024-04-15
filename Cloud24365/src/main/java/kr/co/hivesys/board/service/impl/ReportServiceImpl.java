package kr.co.hivesys.board.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.board.mapper.ReportMapper;
import kr.co.hivesys.board.service.ReportService;
import kr.co.hivesys.board.vo.ReportVo;

@Service("reportService")
public class ReportServiceImpl implements ReportService{

	@Resource(name="reportMapper")
	private ReportMapper reportMapper;
	
	@Override
	public List<ReportVo> selectList(ReportVo inputVo) {
		return reportMapper.selectList(inputVo);
	}
	
	@Override
	public String creReportId(ReportVo inputVo) {
		return reportMapper.creReportId(inputVo);
	}

	@Override
	public int insert(ReportVo inputVo) {
		return reportMapper.insert(inputVo);
	}

	@Override
	public ReportVo selectOne(ReportVo inputVo) {
		return reportMapper.selectOne(inputVo);
	}

	@Override
	public int update(ReportVo inputVo) {
		return reportMapper.update(inputVo);
	}

	@Override
	public int delete(List<String> inputList) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("chkList",inputList);
		return reportMapper.delete(map);	
	}


	
}
