package kr.co.hivesys.partner.service;

import java.util.List;

import kr.co.hivesys.partner.vo.PartnerVo;


public interface PartnerService {
	List<PartnerVo> selectList(PartnerVo inputVo);

	String createId(PartnerVo inputVo);
	
	int insert(PartnerVo inputVo);

	PartnerVo selectOne(PartnerVo inputVo);

	int update(PartnerVo inputVo);

	int delete(PartnerVo inputVo);
}
