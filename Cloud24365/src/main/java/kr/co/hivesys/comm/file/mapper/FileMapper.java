package kr.co.hivesys.comm.file.mapper;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.hivesys.comm.file.vo.FileVo;
import kr.co.hivesys.partner.vo.PartnerVo;

@Mapper("fileMapper")
public interface FileMapper {
	public List<FileVo> selectFileList(FileVo inputVo);
	public void insertFile (List<FileVo> inputVo);
	int update(List<FileVo> inputVo);
	int delete(FileVo inputVo);
	int deleteAll(List<FileVo> inputVo);
}
