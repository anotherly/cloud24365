package kr.co.hivesys.company.service;

import java.util.List;

import kr.co.hivesys.company.vo.CompanyVo;
import kr.co.hivesys.company.vo.MspVo;

public interface CompanyService {
	
	CompanyVo serviceCnt(CompanyVo cmsVo);
	
	List<CompanyVo> selectCompanyList(CompanyVo cmsVo);
	
	CompanyVo selectCompany(CompanyVo cmsVo);
	
	String creComId();

	void insertCompany(CompanyVo cmsVo);
	
	void updateCompany(CompanyVo cmsVo);
	
	public void deleteCompany(List<String> listArr);

	/*MSP 요금제 관련*/
	
	List<MspVo> selectMspList(CompanyVo cmsVo);
	
	void subListInsert(List<MspVo> listArr);
	
	List<MspVo> selectMspOne(MspVo cmsVo);
	
	void subListUpdate(List<MspVo> listArr);
	
	void deleteMsp(CompanyVo cmsVo);
	
}
