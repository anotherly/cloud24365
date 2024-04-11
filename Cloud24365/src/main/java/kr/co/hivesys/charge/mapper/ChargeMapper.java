package kr.co.hivesys.charge.mapper;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.hivesys.charge.vo.ChargeVo;

@Mapper("chargeMapper")
public interface ChargeMapper {

	List<ChargeVo> selectList(ChargeVo inputVo);

	String crechargeId(ChargeVo inputVo);
	
	int insert(ChargeVo inputVo);

	ChargeVo selectOne(ChargeVo inputVo);

	int update(ChargeVo inputVo);

	int delete(HashMap<String, Object> map);
	
}
