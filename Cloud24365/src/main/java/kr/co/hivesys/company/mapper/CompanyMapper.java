package kr.co.hivesys.company.mapper;

import java.util.HashMap;
import java.util.List;

import egovframework.rte.psl.dataaccess.mapper.Mapper;
import kr.co.hivesys.company.vo.CompanyVo;
import kr.co.hivesys.company.vo.MspVo;

@Mapper("companyMapper")
public interface CompanyMapper {
	
	CompanyVo serviceCnt(CompanyVo cmsVo);

	List<CompanyVo> selectCompanyList(CompanyVo cmsVo);
	
	CompanyVo selectCompany(CompanyVo cmsVo);
	
	String creComId();
	
	int insertCompany(CompanyVo cmsVo);

	int updateCompany(CompanyVo cmsVo);

	void deleteCompany(HashMap<String, Object> map);

	/*MSP 요금제 관련*/
	
	List<MspVo> selectMspList(CompanyVo cmsVo);
	
	void subListInsert(List<MspVo> listArr);
	
	List<MspVo> selectMspOne(MspVo cmsVo);

	void subListUpdate(List<MspVo> listArr);

	void deleteMsp(CompanyVo cmsVo);
}
