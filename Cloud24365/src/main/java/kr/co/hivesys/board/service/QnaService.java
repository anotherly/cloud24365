package kr.co.hivesys.board.service;

import java.util.List;

import kr.co.hivesys.board.vo.QnaVo;
import kr.co.hivesys.comm.file.vo.FileVo;

public interface QnaService {

	List<QnaVo> selectReqList(QnaVo inputVo);
	
	int insertReq(QnaVo inputVo);
	
	int ansInsert(QnaVo inputVo);

	QnaVo selectReqOne(QnaVo inputVo);

	int reqAnsUser(QnaVo inputVo);
	
	int reqUpdate(QnaVo inputVo);

	String creReqId(QnaVo inputVo);

	String creAnsId(QnaVo inputVo);

	List<QnaVo> selectAnsList(QnaVo inputVo);

	List<FileVo> ansFileList(QnaVo inputVo);

}
