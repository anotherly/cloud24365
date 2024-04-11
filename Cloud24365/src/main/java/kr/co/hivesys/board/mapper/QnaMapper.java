package kr.co.hivesys.board.mapper;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.hivesys.board.vo.QnaVo;
import kr.co.hivesys.comm.file.vo.FileVo;

@Mapper("qnaMapper")
public interface QnaMapper {

	List<QnaVo> selectReqList(QnaVo inputVo);

	int insertReq(QnaVo inputVo);

	int reqAnsUser(QnaVo inputVo);
	
	int reqUpdate(QnaVo inputVo);

	QnaVo selectReqOne(QnaVo inputVo);

	String creReqId(QnaVo inputVo);

	int ansInsert(QnaVo inputVo);

	String creAnsId(QnaVo inputVo);

	List<QnaVo> selectAnsList(QnaVo inputVo);
	
	List<QnaVo> qnaHistory(QnaVo inputVo);
	
	public List<FileVo> ansFileList(QnaVo inputVo);
}
