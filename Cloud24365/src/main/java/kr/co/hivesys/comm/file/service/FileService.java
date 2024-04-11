package kr.co.hivesys.comm.file.service;

import java.util.List;

import kr.co.hivesys.board.vo.QnaVo;
import kr.co.hivesys.comm.file.vo.FileVo;
import kr.co.hivesys.partner.vo.PartnerVo;

public interface FileService {
	public List<FileVo> selectFileList(FileVo inputVo);
	public void insertFile (List<FileVo> inputVo);
	int update(List<FileVo> inputVo);
	int delete(FileVo inputVo);
	int deleteAll(List<FileVo> inputVo);
}
