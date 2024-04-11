package kr.co.hivesys.admin.edit.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.main.mapper.MainMapper;
import kr.co.hivesys.main.service.MainService;
import kr.co.hivesys.admin.edit.mapper.EditMapper;
import kr.co.hivesys.admin.edit.service.EditService;
import kr.co.hivesys.admin.edit.vo.EditVo;
import kr.co.hivesys.user.vo.UserVO;

@Service("editService")
public class EditServiceImpl implements EditService{
	@Resource(name="editMapper")
	private EditMapper editMapper;

	@Override
	public List<EditVo> selectTouList(EditVo cmsVo) {
		return editMapper.selectTouList(cmsVo);
	}

	@Override
	public EditVo selectTou(EditVo cmsVo) {
		return editMapper.selectTou(cmsVo);
	}

	@Override
	public void insertTou(EditVo thvo) {
		editMapper.insertTou(thvo);
	}

	@Override
	public void deleteTou(EditVo thvo) {
		editMapper.deleteTou(thvo);
	}
}
