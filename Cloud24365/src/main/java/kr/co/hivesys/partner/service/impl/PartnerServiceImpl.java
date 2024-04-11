package kr.co.hivesys.partner.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.partner.mapper.PartnerMapper;
import kr.co.hivesys.partner.service.PartnerService;
import kr.co.hivesys.partner.vo.PartnerVo;

@Service("partnerService")
public class PartnerServiceImpl implements PartnerService{
	@Resource(name="partnerMapper")
	private PartnerMapper partnerMapper;
	
	@Override
	public List<PartnerVo> selectList(PartnerVo inputVo) {
		return partnerMapper.selectList(inputVo);
	}
	
	@Override
	public String createId(PartnerVo inputVo) {
		return partnerMapper.createId(inputVo);
	}

	@Override
	public int insert(PartnerVo inputVo) {
		return partnerMapper.insert(inputVo);
	}

	@Override
	public PartnerVo selectOne(PartnerVo inputVo) {
		return partnerMapper.selectOne(inputVo);
	}

	@Override
	public int update(PartnerVo inputVo) {
		return partnerMapper.update(inputVo);
	}

	@Override
	public int delete(PartnerVo inputVo) {
		return partnerMapper.delete(inputVo);	
	}
}
