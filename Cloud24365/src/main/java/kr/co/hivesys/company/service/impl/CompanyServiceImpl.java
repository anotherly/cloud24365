package kr.co.hivesys.company.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.hivesys.company.mapper.CompanyMapper;
import kr.co.hivesys.company.service.CompanyService;
import kr.co.hivesys.company.vo.CompanyVo;
import kr.co.hivesys.company.vo.MspVo;

@Service("companyService")
public class CompanyServiceImpl implements CompanyService{
	@Resource(name="companyMapper")
	private CompanyMapper companyMapper;
	
	@Override
	public CompanyVo serviceCnt(CompanyVo cmsVo) {
		return companyMapper.serviceCnt(cmsVo);
	}
	
	@Override
	public List<CompanyVo> selectCompanyList(CompanyVo cmsVo) {
		return companyMapper.selectCompanyList(cmsVo);
	}
	@Override
	public CompanyVo selectCompany(CompanyVo cmsVo) {
		return companyMapper.selectCompany(cmsVo);
	}

	@Override
	public String creComId() {
		return companyMapper.creComId();
	}
	
	@Override
	public int insertCompany(CompanyVo cmsVo) {
		return companyMapper.insertCompany(cmsVo);
		
	}
	
	@Override
	public int updateCompany(CompanyVo cmsVo) {
		return companyMapper.updateCompany(cmsVo);
		
	}
	//사용자 삭제
	public void deleteCompany(List<String> listArr) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("chkList",listArr);
		companyMapper.deleteCompany(map);		
	}

	/*MSP 요금제 관련*/

	@Override
	public List<MspVo> selectMspList(CompanyVo cmsVo) {
		return companyMapper.selectMspList(cmsVo);
	}
	
	@Override
	public void subListInsert(List<MspVo> listArr) {
		companyMapper.subListInsert(listArr);	
	}
	
	@Override
	public List<MspVo> selectMspOne(MspVo cmsVo) {
		return companyMapper.selectMspOne(cmsVo);
	}

	@Override
	public void subListUpdate(List<MspVo> listArr) {
		companyMapper.subListUpdate(listArr);
	}

	@Override
	public void deleteMsp(CompanyVo cmsVo) {
		companyMapper.deleteMsp(cmsVo);
	}

}
