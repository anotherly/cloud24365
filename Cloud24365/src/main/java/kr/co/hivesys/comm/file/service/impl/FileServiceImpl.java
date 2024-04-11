package kr.co.hivesys.comm.file.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.comm.file.mapper.FileMapper;
import kr.co.hivesys.comm.file.service.FileService;
import kr.co.hivesys.comm.file.vo.FileVo;
import kr.co.hivesys.partner.vo.PartnerVo;

@Service("fileService")
public class FileServiceImpl implements FileService{
	@Resource(name="fileMapper")
	private FileMapper fileMapper;

	@Override
	public List<FileVo> selectFileList(FileVo inputVo) {
		System.out.println("와이 여길 못탐?");
		return fileMapper.selectFileList(inputVo);
	}

	@Override
	public void insertFile(List<FileVo> inputVo) {
		fileMapper.insertFile(inputVo);
	}
	
	@Override
	public int update(List<FileVo> inputVo) {
		return fileMapper.update(inputVo);
	}

	@Override
	public int delete(FileVo inputVo) {
		return fileMapper.delete(inputVo);	
	}
	@Override
	public int deleteAll(List<FileVo> inputVo) {
		return fileMapper.deleteAll(inputVo);	
	}
}
