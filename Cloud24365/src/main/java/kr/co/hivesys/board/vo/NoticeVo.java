package kr.co.hivesys.board.vo;

import java.util.List;

import kr.co.hivesys.comm.file.vo.FileVo;

public class NoticeVo extends FileVo{
	
	private String NOTICE_ID;
	private String NOTICE_TYPE;
	private String NOTICE_TYPE_NM;
	private String NOTICE_TITLE;
	private String USER_ID;
	private String USER_NAME;
	private String NOTICE_DT;
	private String CONTENT;
	private String NOTICE_FILE;
	private String FLAG_EMAIL;
	private String FLAG_SMS;
	
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
	
	
	
	public String getNOTICE_TYPE_NM() {
		return NOTICE_TYPE_NM;
	}
	public void setNOTICE_TYPE_NM(String nOTICE_TYPE_NM) {
		NOTICE_TYPE_NM = nOTICE_TYPE_NM;
	}
	public String getUSER_NAME() {
		return USER_NAME;
	}
	public void setUSER_NAME(String uSER_NAME) {
		USER_NAME = uSER_NAME;
	}
	
	public String getNOTICE_ID() {
		return NOTICE_ID;
	}
	public void setNOTICE_ID(String nOTICE_ID) {
		NOTICE_ID = nOTICE_ID;
	}
	public String getNOTICE_TYPE() {
		return NOTICE_TYPE;
	}
	public void setNOTICE_TYPE(String nOTICE_TYPE) {
		NOTICE_TYPE = nOTICE_TYPE;
	}
	public String getNOTICE_TITLE() {
		return NOTICE_TITLE;
	}
	public void setNOTICE_TITLE(String nOTICE_TITLE) {
		NOTICE_TITLE = nOTICE_TITLE;
	}
	public String getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}
	public String getNOTICE_DT() {
		return NOTICE_DT;
	}
	public void setNOTICE_DT(String nOTICE_DT) {
		NOTICE_DT = nOTICE_DT;
	}
	public String getCONTENT() {
		return CONTENT;
	}
	public void setCONTENT(String cONTENT) {
		CONTENT = cONTENT;
	}
	public String getNOTICE_FILE() {
		return NOTICE_FILE;
	}
	public void setNOTICE_FILE(String nOTICE_FILE) {
		NOTICE_FILE = nOTICE_FILE;
	}
	public String getFLAG_EMAIL() {
		return FLAG_EMAIL;
	}
	public void setFLAG_EMAIL(String fLAG_EMAIL) {
		FLAG_EMAIL = fLAG_EMAIL;
	}
	public String getFLAG_SMS() {
		return FLAG_SMS;
	}
	public void setFLAG_SMS(String fLAG_SMS) {
		FLAG_SMS = fLAG_SMS;
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
		return "NoticeVo [NOTICE_ID=" + NOTICE_ID + ", NOTICE_TYPE=" + NOTICE_TYPE + ", NOTICE_TITLE=" + NOTICE_TITLE
				+ ", USER_ID=" + USER_ID + ", NOTICE_DT=" + NOTICE_DT + ", CONTENT=" + CONTENT + ", NOTICE_FILE="
				+ NOTICE_FILE + ", FLAG_EMAIL=" + FLAG_EMAIL + ", FLAG_SMS=" + FLAG_SMS + ", listArr=" + listArr
				+ ", searchType=" + searchType + ", searchValue=" + searchValue + ", sDate=" + sDate + ", eDate="
				+ eDate + ", searchChk=" + searchChk + ", searchRadio=" + searchRadio + "]";
	}
	
}
