package kr.co.hivesys.admin.edit.service;

import java.util.List;

import kr.co.hivesys.admin.edit.vo.EditVo;

public interface EditService {

	List<EditVo> selectTouList(EditVo cmsVo);
	
	EditVo selectTou(EditVo cmsVo);
	
	void insertTou(EditVo thvo);
	
	public void deleteTou(EditVo thvo);
	

}
