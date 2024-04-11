package kr.co.hivesys.board.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.board.mapper.QnaMapper;
import kr.co.hivesys.board.service.QnaService;
import kr.co.hivesys.board.vo.QnaVo;
import kr.co.hivesys.comm.file.vo.FileVo;

@Service("qnaService")
public class QnaServiceImpl implements QnaService{

	@Resource(name="qnaMapper")
	private QnaMapper qnaMapper;
	
	@Override
	public List<QnaVo> selectReqList(QnaVo inputVo) {
		return qnaMapper.selectReqList(inputVo);
	}

	@Override
	public int insertReq(QnaVo inputVo) {
		return qnaMapper.insertReq(inputVo);
	}

	@Override
	public QnaVo selectReqOne(QnaVo inputVo) {
		return qnaMapper.selectReqOne(inputVo);
	}

	@Override
	public int reqUpdate(QnaVo inputVo) {
		return qnaMapper.reqUpdate(inputVo);
	}

	@Override
	public String creReqId(QnaVo inputVo) {
		return qnaMapper.creReqId(inputVo);
	}

	@Override
	public int ansInsert(QnaVo inputVo) {
		return qnaMapper.ansInsert(inputVo);
	}

	@Override
	public String creAnsId(QnaVo inputVo) {
		return qnaMapper.creAnsId(inputVo);
	}

	@Override
	public List<QnaVo> selectAnsList(QnaVo inputVo) {
		return qnaMapper.selectAnsList(inputVo);
	}

	@Override
	public int reqAnsUser(QnaVo inputVo) {
		return qnaMapper.reqAnsUser(inputVo);
	}

	@Override
	public List<FileVo> ansFileList(QnaVo inputVo) {
		return qnaMapper.ansFileList(inputVo);
	}

}
