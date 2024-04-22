package kr.co.hivesys.charge.service;

import java.util.List;

import kr.co.hivesys.charge.vo.ChargeVo;
import kr.co.hivesys.company.vo.CompanyVo;


public interface ChargeService {
	
	//과금 관련
	List<ChargeVo> selectPriceList(CompanyVo thvo);

	int chargeInsert(List<ChargeVo> thvo);

	void deleteCharge(List<ChargeVo> thvo);
}
