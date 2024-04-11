package kr.co.hivesys.board.vo;

import java.util.List;

public class FaqVo {
	
	private String FAQ_ID;
	private String FAQ_TYPE;
	private String FAQ_TYPE_NM;
	private String FAQ_TITLE;
	private String USER_ID;
	private String USER_NAME;
	private String FAQ_DT;
	private String CONTENT;
	
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
	
	public String getUSER_NAME() {
		return USER_NAME;
	}
	public void setUSER_NAME(String uSER_NAME) {
		USER_NAME = uSER_NAME;
	}
	public String getFAQ_TYPE_NM() {
		return FAQ_TYPE_NM;
	}
	public void setFAQ_TYPE_NM(String fAQ_TYPE_NM) {
		FAQ_TYPE_NM = fAQ_TYPE_NM;
	}
	public String getFAQ_ID() {
		return FAQ_ID;
	}
	public void setFAQ_ID(String fAQ_ID) {
		FAQ_ID = fAQ_ID;
	}
	public String getFAQ_TYPE() {
		return FAQ_TYPE;
	}
	public void setFAQ_TYPE(String fAQ_TYPE) {
		FAQ_TYPE = fAQ_TYPE;
	}
	public String getFAQ_TITLE() {
		return FAQ_TITLE;
	}
	public void setFAQ_TITLE(String fAQ_TITLE) {
		FAQ_TITLE = fAQ_TITLE;
	}
	public String getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}
	public String getFAQ_DT() {
		return FAQ_DT;
	}
	public void setFAQ_DT(String fAQ_DT) {
		FAQ_DT = fAQ_DT;
	}
	public String getCONTENT() {
		return CONTENT;
	}
	public void setCONTENT(String cONTENT) {
		CONTENT = cONTENT;
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
		return "FaqVo [FAQ_ID=" + FAQ_ID + ", FAQ_TYPE=" + FAQ_TYPE + ", FAQ_TYPE_NM=" + FAQ_TYPE_NM + ", FAQ_TITLE="
				+ FAQ_TITLE + ", USER_ID=" + USER_ID + ", FAQ_DT=" + FAQ_DT + ", CONTENT=" + CONTENT + ", listArr="
				+ listArr + ", searchType=" + searchType + ", searchValue=" + searchValue + ", sDate=" + sDate
				+ ", eDate=" + eDate + ", searchChk=" + searchChk + ", searchRadio=" + searchRadio + "]";
	}
	
}
