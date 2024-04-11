package kr.co.hivesys.partner.mapper;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.hivesys.partner.vo.PartnerVo;

@Mapper("partnerMapper")
public interface PartnerMapper {
	List<PartnerVo> selectList(PartnerVo inputVo);

	String createId(PartnerVo inputVo);
	
	int insert(PartnerVo inputVo);

	PartnerVo selectOne(PartnerVo inputVo);

	int update(PartnerVo inputVo);

	int delete(PartnerVo inputVo);
}
