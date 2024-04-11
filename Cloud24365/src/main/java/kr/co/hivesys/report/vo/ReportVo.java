package kr.co.hivesys.report.vo;

import java.util.List;

import kr.co.hivesys.comm.file.vo.FileVo;

public class ReportVo extends FileVo{
	
	private String REPORT_ID;
	private String REPORT_NAME;
	private String REPORT_TYPE;
	private String REPORT_TYPE_NM;
	private String COMPANY_ID;
	private String COMPANY_NAME;
	private String PROJECT_NAME;
	private String REG_DT;
	
	//범위값
	private List<String> listArr;
	//검색타입
	private String searchType;
	//검색값
	private String searchValue;
	//검색 시작 시간
	private String sDate;
	//검색 종료 시간
	private String eDate;
	//체크박스 버튼 
	private String searchChk;
	//라디오버튼 
	private String searchRadio;
	
	public String getCOMPANY_NAME() {
		return COMPANY_NAME;
	}
	public void setCOMPANY_NAME(String cOMPANY_NAME) {
		COMPANY_NAME = cOMPANY_NAME;
	}
	public String getREPORT_TYPE_NM() {
		return REPORT_TYPE_NM;
	}
	public void setREPORT_TYPE_NM(String rEPORT_TYPE_NM) {
		REPORT_TYPE_NM = rEPORT_TYPE_NM;
	}
	public String getREPORT_ID() {
		return REPORT_ID;
	}
	public void setREPORT_ID(String rEPORT_ID) {
		REPORT_ID = rEPORT_ID;
	}
	public String getREPORT_NAME() {
		return REPORT_NAME;
	}
	public void setREPORT_NAME(String rEPORT_NAME) {
		REPORT_NAME = rEPORT_NAME;
	}
	public String getREPORT_TYPE() {
		return REPORT_TYPE;
	}
	public void setREPORT_TYPE(String rEPORT_TYPE) {
		REPORT_TYPE = rEPORT_TYPE;
	}
	public String getCOMPANY_ID() {
		return COMPANY_ID;
	}
	public void setCOMPANY_ID(String cOMPANY_ID) {
		COMPANY_ID = cOMPANY_ID;
	}
	public String getPROJECT_NAME() {
		return PROJECT_NAME;
	}
	public void setPROJECT_NAME(String pROJECT_NAME) {
		PROJECT_NAME = pROJECT_NAME;
	}
	public String getREG_DT() {
		return REG_DT;
	}
	public void setREG_DT(String rEG_DT) {
		REG_DT = rEG_DT;
	}
	public List<String> getListArr() {
		return listArr;
	}
	public void setListArr(List<String> listArr) {
		this.listArr = listArr;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getSearchValue() {
		return searchValue;
	}
	public void setSearchValue(String searchValue) {
		this.searchValue = searchValue;
	}
	public String getsDate() {
		return sDate;
	}
	public void setsDate(String sDate) {
		this.sDate = sDate;
	}
	public String geteDate() {
		return eDate;
	}
	public void seteDate(String eDate) {
		this.eDate = eDate;
	}
	public String getSearchChk() {
		return searchChk;
	}
	public void setSearchChk(String searchChk) {
		this.searchChk = searchChk;
	}
	public String getSearchRadio() {
		return searchRadio;
	}
	public void setSearchRadio(String searchRadio) {
		this.searchRadio = searchRadio;
	}
	@Override
	public String toString() {
		return "ReportVo [REPORT_ID=" + REPORT_ID + ", REPORT_NAME=" + REPORT_NAME + ", REPORT_TYPE=" + REPORT_TYPE
				+ ", COMPANY_ID=" + COMPANY_ID + ", PROJECT_NAME=" + PROJECT_NAME + ", REG_DT=" + REG_DT + ", listArr="
				+ listArr + ", searchType=" + searchType + ", searchValue=" + searchValue + ", sDate=" + sDate
				+ ", eDate=" + eDate + ", searchChk=" + searchChk + ", searchRadio=" + searchRadio + "]";
	}
	
}
