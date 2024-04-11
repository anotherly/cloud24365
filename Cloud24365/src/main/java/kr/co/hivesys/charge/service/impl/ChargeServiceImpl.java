package kr.co.hivesys.charge.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.charge.mapper.ChargeMapper;
import kr.co.hivesys.charge.service.ChargeService;
import kr.co.hivesys.charge.vo.ChargeVo;

@Service("chargeService")
public class ChargeServiceImpl implements ChargeService{

	@Resource(name="chargeMapper")
	private ChargeMapper chargeMapper;
	
	@Override
	public List<ChargeVo> selectList(ChargeVo inputVo) {
		return chargeMapper.selectList(inputVo);
	}
	
	@Override
	public String crechargeId(ChargeVo inputVo) {
		return chargeMapper.crechargeId(inputVo);
	}

	@Override
	public int insert(ChargeVo inputVo) {
		return chargeMapper.insert(inputVo);
	}

	@Override
	public ChargeVo selectOne(ChargeVo inputVo) {
		return chargeMapper.selectOne(inputVo);
	}

	@Override
	public int update(ChargeVo inputVo) {
		return chargeMapper.update(inputVo);
	}

	@Override
	public int delete(List<String> inputList) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("chkList",inputList);
		return chargeMapper.delete(map);	
	}


	
}
