package kr.co.hivesys.bill.service;

import java.util.List;

import kr.co.hivesys.bill.vo.BillVo;
import kr.co.hivesys.comm.file.vo.FileVo;


public interface BillService {
	List<BillVo> selectList(BillVo inputVo);

	String createId(BillVo inputVo);
	
	int insert(BillVo inputVo);

	BillVo selectOne(BillVo inputVo);

	int update(BillVo inputVo);

	int delete(List<String> inputList);

	int firstNumber(BillVo inputVo);
	
	//#####################수동청구서#####################//
	
	List<BillVo> manualList(BillVo inputVo);
	String createMnId(BillVo inputVo);
	int manualInsert(BillVo inputVo);
	
	FileVo firstFile();
}
