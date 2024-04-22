package kr.co.hivesys.bill.vo;

import kr.co.hivesys.comm.file.vo.FileVo;

public class BillVo extends FileVo{
	private String BILL_ID;
	private String USER_ID;
	private String USER_NAME;
	private String COMPANY_ID;
	private String COMPANY_NAME;
	private String SND_DT;
	private String RCV_DT;
	
	private String BILL_PRICE;
	private String BILL_MN_FILE;
	
	private String BILL_FILE_ID;
	private String BILL_PRIOR;
	private String BILL_NAME;
	private String REG_DT;
	
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
	private String searchRadio2;
	
	public String getUSER_NAME() {
		return USER_NAME;
	}
	public void setUSER_NAME(String uSER_NAME) {
		USER_NAME = uSER_NAME;
	}
	public String getCOMPANY_NAME() {
		return COMPANY_NAME;
	}
	public void setCOMPANY_NAME(String cOMPANY_NAME) {
		COMPANY_NAME = cOMPANY_NAME;
	}
	public String getSearchRadio2() {
		return searchRadio2;
	}
	public void setSearchRadio2(String searchRadio2) {
		this.searchRadio2 = searchRadio2;
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
	public String getBILL_PRICE() {
		return BILL_PRICE;
	}
	public void setBILL_PRICE(String bILL_PRICE) {
		BILL_PRICE = bILL_PRICE;
	}
	public String getBILL_MN_FILE() {
		return BILL_MN_FILE;
	}
	public void setBILL_MN_FILE(String bILL_MN_FILE) {
		BILL_MN_FILE = bILL_MN_FILE;
	}
	public String getBILL_ID() {
		return BILL_ID;
	}
	public void setBILL_ID(String bILL_ID) {
		BILL_ID = bILL_ID;
	}
	public String getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}
	public String getCOMPANY_ID() {
		return COMPANY_ID;
	}
	public void setCOMPANY_ID(String cOMPANY_ID) {
		COMPANY_ID = cOMPANY_ID;
	}
	public String getSND_DT() {
		return SND_DT;
	}
	public void setSND_DT(String sND_DT) {
		SND_DT = sND_DT;
	}
	public String getRCV_DT() {
		return RCV_DT;
	}
	public void setRCV_DT(String rCV_DT) {
		RCV_DT = rCV_DT;
	}
	public String getBILL_FILE_ID() {
		return BILL_FILE_ID;
	}
	public void setBILL_FILE_ID(String bILL_FILE_ID) {
		BILL_FILE_ID = bILL_FILE_ID;
	}
	public String getBILL_PRIOR() {
		return BILL_PRIOR;
	}
	public void setBILL_PRIOR(String bILL_PRIOR) {
		BILL_PRIOR = bILL_PRIOR;
	}
	public String getBILL_NAME() {
		return BILL_NAME;
	}
	public void setBILL_NAME(String bILL_NAME) {
		BILL_NAME = bILL_NAME;
	}
	public String getREG_DT() {
		return REG_DT;
	}
	public void setREG_DT(String rEG_DT) {
		REG_DT = rEG_DT;
	}
	@Override
	public String toString() {
		return "BillVo [BILL_ID=" + BILL_ID + ", USER_ID=" + USER_ID + ", COMPANY_ID=" + COMPANY_ID + ", SND_DT="
				+ SND_DT + ", RCV_DT=" + RCV_DT + ", BILL_FILE_ID=" + BILL_FILE_ID + ", BILL_PRIOR=" + BILL_PRIOR
				+ ", BILL_NAME=" + BILL_NAME + ", REG_DT=" + REG_DT + "]";
	}
	
}
