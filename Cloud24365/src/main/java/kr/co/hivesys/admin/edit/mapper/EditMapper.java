package kr.co.hivesys.admin.edit.mapper;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.hivesys.admin.edit.vo.EditVo;

@Mapper("editMapper")
public interface EditMapper {

	List<EditVo> selectTouList(EditVo editVo);

	EditVo selectTou(EditVo cmsVo);
	
	void insertTou(EditVo thvo);

	void deleteTou(EditVo thvo);

	
}
