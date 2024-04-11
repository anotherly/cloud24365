package kr.co.hivesys.board.vo;

import java.util.List;

import kr.co.hivesys.comm.file.vo.FileVo;

public class QnaVo extends FileVo{
	
	public String REQ_ID;
	public String REQ_DT;
	public String ANS_ID;
	public String ANS_DT;
	
	//답변 글에 실제 답변을 달은사람
	public String USER_ID;
	public String USER_NAME;
	//담당자로 지정된 사람
	public String ANS_USER;
	public String ANS_USER_NM;
	
	public String COMPANY_ID;
	public String COMPANY_NAME;
	public String REQ_TYPE;
	public String REQ_TYPE_NM;
	public String ANS_TYPE;
	public String ANS_TYPE_NM;
	public String INSERT_TYPE;
	public String INSERT_TYPE_NM;
	public String CLIENT_FILE;
	public String REQ_QUESTION;
	public String REQ_ANSWER;
	public String ADMIN_FILE;
	public String REQ_IMPORTANT;
	public String REQ_IMPORTANT_NM;
	public String REQ_HISTORY;
	public String REQ_DIV;
	public String REQ_DIV_NM;
	public String REQ_STATUS;
	public String REQ_STATUS_NM;
	public String REQ_TITLE;
	
	public String getANS_USER_NM() {
		return ANS_USER_NM;
	}
	public void setANS_USER_NM(String aNS_USER_NM) {
		ANS_USER_NM = aNS_USER_NM;
	}
	public String getANS_USER() {
		return ANS_USER;
	}
	public void setANS_USER(String aNS_USER) {
		ANS_USER = aNS_USER;
	}
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
	//라디오버튼 
	private String searchRadio;
	public String getREQ_ID() {
		return REQ_ID;
	}
	public void setREQ_ID(String rEQ_ID) {
		REQ_ID = rEQ_ID;
	}
	public String getREQ_DT() {
		return REQ_DT;
	}
	public void setREQ_DT(String rEQ_DT) {
		REQ_DT = rEQ_DT;
	}
	public String getANS_ID() {
		return ANS_ID;
	}
	public void setANS_ID(String aNS_ID) {
		ANS_ID = aNS_ID;
	}
	public String getANS_DT() {
		return ANS_DT;
	}
	public void setANS_DT(String aNS_DT) {
		ANS_DT = aNS_DT;
	}
	public String getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}
	public String getUSER_NAME() {
		return USER_NAME;
	}
	public void setUSER_NAME(String uSER_NAME) {
		USER_NAME = uSER_NAME;
	}
	public String getCOMPANY_ID() {
		return COMPANY_ID;
	}
	public void setCOMPANY_ID(String cOMPANY_ID) {
		COMPANY_ID = cOMPANY_ID;
	}
	public String getCOMPANY_NAME() {
		return COMPANY_NAME;
	}
	public void setCOMPANY_NAME(String cOMPANY_NAME) {
		COMPANY_NAME = cOMPANY_NAME;
	}
	public String getREQ_TYPE() {
		return REQ_TYPE;
	}
	public void setREQ_TYPE(String rEQ_TYPE) {
		REQ_TYPE = rEQ_TYPE;
	}
	public String getREQ_TYPE_NM() {
		return REQ_TYPE_NM;
	}
	public void setREQ_TYPE_NM(String rEQ_TYPE_NM) {
		REQ_TYPE_NM = rEQ_TYPE_NM;
	}
	public String getANS_TYPE() {
		return ANS_TYPE;
	}
	public void setANS_TYPE(String aNS_TYPE) {
		ANS_TYPE = aNS_TYPE;
	}
	public String getANS_TYPE_NM() {
		return ANS_TYPE_NM;
	}
	public void setANS_TYPE_NM(String aNS_TYPE_NM) {
		ANS_TYPE_NM = aNS_TYPE_NM;
	}
	public String getINSERT_TYPE() {
		return INSERT_TYPE;
	}
	public void setINSERT_TYPE(String iNSERT_TYPE) {
		INSERT_TYPE = iNSERT_TYPE;
	}
	public String getINSERT_TYPE_NM() {
		return INSERT_TYPE_NM;
	}
	public void setINSERT_TYPE_NM(String iNSERT_TYPE_NM) {
		INSERT_TYPE_NM = iNSERT_TYPE_NM;
	}
	public String getCLIENT_FILE() {
		return CLIENT_FILE;
	}
	public void setCLIENT_FILE(String cLIENT_FILE) {
		CLIENT_FILE = cLIENT_FILE;
	}
	public String getREQ_QUESTION() {
		return REQ_QUESTION;
	}
	public void setREQ_QUESTION(String rEQ_QUESTION) {
		REQ_QUESTION = rEQ_QUESTION;
	}
	public String getREQ_ANSWER() {
		return REQ_ANSWER;
	}
	public void setREQ_ANSWER(String rEQ_ANSWER) {
		REQ_ANSWER = rEQ_ANSWER;
	}
	public String getADMIN_FILE() {
		return ADMIN_FILE;
	}
	public void setADMIN_FILE(String aDMIN_FILE) {
		ADMIN_FILE = aDMIN_FILE;
	}
	public String getREQ_IMPORTANT() {
		return REQ_IMPORTANT;
	}
	public void setREQ_IMPORTANT(String rEQ_IMPORTANT) {
		REQ_IMPORTANT = rEQ_IMPORTANT;
	}
	public String getREQ_IMPORTANT_NM() {
		return REQ_IMPORTANT_NM;
	}
	public void setREQ_IMPORTANT_NM(String rEQ_IMPORTANT_NM) {
		REQ_IMPORTANT_NM = rEQ_IMPORTANT_NM;
	}
	public String getREQ_HISTORY() {
		return REQ_HISTORY;
	}
	public void setREQ_HISTORY(String rEQ_HISTORY) {
		REQ_HISTORY = rEQ_HISTORY;
	}
	public String getREQ_DIV() {
		return REQ_DIV;
	}
	public void setREQ_DIV(String rEQ_DIV) {
		REQ_DIV = rEQ_DIV;
	}
	public String getREQ_DIV_NM() {
		return REQ_DIV_NM;
	}
	public void setREQ_DIV_NM(String rEQ_DIV_NM) {
		REQ_DIV_NM = rEQ_DIV_NM;
	}
	public String getREQ_STATUS() {
		return REQ_STATUS;
	}
	public void setREQ_STATUS(String rEQ_STATUS) {
		REQ_STATUS = rEQ_STATUS;
	}
	public String getREQ_STATUS_NM() {
		return REQ_STATUS_NM;
	}
	public void setREQ_STATUS_NM(String rEQ_STATUS_NM) {
		REQ_STATUS_NM = rEQ_STATUS_NM;
	}
	public String getREQ_TITLE() {
		return REQ_TITLE;
	}
	public void setREQ_TITLE(String rEQ_TITLE) {
		REQ_TITLE = rEQ_TITLE;
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
	public String getSearchRadio() {
		return searchRadio;
	}
	public void setSearchRadio(String searchRadio) {
		this.searchRadio = searchRadio;
	}
	@Override
	public String toString() {
		return "QnaVo [REQ_ID=" + REQ_ID + ", REQ_DT=" + REQ_DT + ", ANS_ID=" + ANS_ID + ", ANS_DT=" + ANS_DT
				+ ", USER_ID=" + USER_ID + ", USER_NAME=" + USER_NAME + ", COMPANY_ID=" + COMPANY_ID + ", COMPANY_NAME="
				+ COMPANY_NAME + ", REQ_TYPE=" + REQ_TYPE + ", REQ_TYPE_NM=" + REQ_TYPE_NM + ", ANS_TYPE=" + ANS_TYPE
				+ ", ANS_TYPE_NM=" + ANS_TYPE_NM + ", INSERT_TYPE=" + INSERT_TYPE + ", INSERT_TYPE_NM=" + INSERT_TYPE_NM
				+ ", CLIENT_FILE=" + CLIENT_FILE + ", REQ_QUESTION=" + REQ_QUESTION + ", REQ_ANSWER=" + REQ_ANSWER
				+ ", ADMIN_FILE=" + ADMIN_FILE + ", REQ_IMPORTANT=" + REQ_IMPORTANT + ", REQ_IMPORTANT_NM="
				+ REQ_IMPORTANT_NM + ", REQ_HISTORY=" + REQ_HISTORY + ", REQ_DIV=" + REQ_DIV + ", REQ_DIV_NM="
				+ REQ_DIV_NM + ", REQ_STATUS=" + REQ_STATUS + ", REQ_STATUS_NM=" + REQ_STATUS_NM + ", REQ_TITLE="
				+ REQ_TITLE + ", listArr=" + listArr + ", searchType=" + searchType + ", searchValue=" + searchValue
				+ ", sDate=" + sDate + ", eDate=" + eDate + ", searchRadio=" + searchRadio + "]";
	}
	
}
