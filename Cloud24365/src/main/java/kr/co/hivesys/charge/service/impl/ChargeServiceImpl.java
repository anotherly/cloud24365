package kr.co.hivesys.charge.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.charge.mapper.ChargeMapper;
import kr.co.hivesys.charge.service.ChargeService;
import kr.co.hivesys.charge.vo.ChargeVo;
import kr.co.hivesys.company.vo.CompanyVo;

@Service("chargeService")
public class ChargeServiceImpl implements ChargeService{

	@Resource(name="chargeMapper")
	private ChargeMapper chargeMapper;
	
	@Override
	public List<ChargeVo> selectPriceList(CompanyVo thvo) {
		return chargeMapper.selectPriceList(thvo);
	}

	@Override
	public int chargeInsert(List<ChargeVo> thvo) {
		return chargeMapper.chargeInsert(thvo);
	}

	@Override
	public void deleteCharge(List<ChargeVo> thvo) {
		chargeMapper.deleteCharge(thvo);		
	}
	
}
