package kr.co.hivesys.charge.service;

import java.util.List;

import kr.co.hivesys.charge.vo.ChargeVo;


public interface ChargeService {

	List<ChargeVo> selectList(ChargeVo inputVo);

	String crechargeId(ChargeVo inputVo);
	
	int insert(ChargeVo inputVo);

	ChargeVo selectOne(ChargeVo inputVo);

	int update(ChargeVo inputVo);

	int delete(List<String> inputList);
}
