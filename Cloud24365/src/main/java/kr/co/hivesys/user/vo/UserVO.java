package kr.co.hivesys.user.vo;

public class UserVO {

	//디폴트 정보
	private String USER_ID;
	private String USER_PW;
	private String USER_PW1;
	private String USER_NAME;
	private String USER_LEVEL;
	private String USER_PHONE;
	private String USER_EMAIL;
	private String USER_DEPT;
	private String USER_RANK;
	private String USE_YN;
	private String REG_DT;
	
	//소속 회사 id
	private String COMPANY_ID;
	private String COMPANY_NAME;
	
	//권한
	private String AUTH_CODE;
	private String AUTH_NAME;
	//최초정보기입여부
	private String INTRO_YN;
	//전화인증여부
	private String AUTH_PHONE;
	
	//아래는 DB에 없는것들
	// 최종로그인
	private String stDt;
	// 최종로그아웃
	private String fnDt;
	//현재 접속여부
	private String cnYn;
	
	//검색타입
	private String searchType;
	//검색값
	private String searchValue;
	//사용 시간
	private String useTime;
	//검색 시작 시간
	private String sDate;
	//검색 종료 시간
	private String eDate;
	//체크박스 버튼 
	private String searchChk;
	//라디오버튼 
	private String searchRadio;
	
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
	public String getCOMPANY_NAME() {
		return COMPANY_NAME;
	}
	public void setCOMPANY_NAME(String cOMPANY_NAME) {
		COMPANY_NAME = cOMPANY_NAME;
	}
	public String getAUTH_NAME() {
		return AUTH_NAME;
	}
	public void setAUTH_NAME(String aUTH_NAME) {
		AUTH_NAME = aUTH_NAME;
	}
	public String getUSER_ID() {
		return USER_ID;
	}
	public void setUSER_ID(String uSER_ID) {
		USER_ID = uSER_ID;
	}
	public String getUSER_PW() {
		return USER_PW;
	}
	public void setUSER_PW(String uSER_PW) {
		USER_PW = uSER_PW;
	}
	public String getUSER_PW1() {
		return USER_PW1;
	}
	public void setUSER_PW1(String uSER_PW1) {
		USER_PW1 = uSER_PW1;
	}
	public String getUSER_NAME() {
		return USER_NAME;
	}
	public void setUSER_NAME(String uSER_NAME) {
		USER_NAME = uSER_NAME;
	}
	public String getUSER_LEVEL() {
		return USER_LEVEL;
	}
	public void setUSER_LEVEL(String uSER_LEVEL) {
		USER_LEVEL = uSER_LEVEL;
	}
	public String getUSER_PHONE() {
		return USER_PHONE;
	}
	public void setUSER_PHONE(String uSER_PHONE) {
		USER_PHONE = uSER_PHONE;
	}
	public String getUSER_EMAIL() {
		return USER_EMAIL;
	}
	public void setUSER_EMAIL(String uSER_EMAIL) {
		USER_EMAIL = uSER_EMAIL;
	}
	public String getUSER_DEPT() {
		return USER_DEPT;
	}
	public void setUSER_DEPT(String uSER_DEPT) {
		USER_DEPT = uSER_DEPT;
	}
	public String getUSER_RANK() {
		return USER_RANK;
	}
	public void setUSER_RANK(String uSER_RANK) {
		USER_RANK = uSER_RANK;
	}
	public String getUSE_YN() {
		return USE_YN;
	}
	public void setUSE_YN(String uSE_YN) {
		USE_YN = uSE_YN;
	}
	public String getREG_DT() {
		return REG_DT;
	}
	public void setREG_DT(String rEG_DT) {
		REG_DT = rEG_DT;
	}
	public String getAUTH_CODE() {
		return AUTH_CODE;
	}
	public void setAUTH_CODE(String aUTH_CODE) {
		AUTH_CODE = aUTH_CODE;
	}
	public String getINTRO_YN() {
		return INTRO_YN;
	}
	public void setINTRO_YN(String iNTRO_YN) {
		INTRO_YN = iNTRO_YN;
	}
	public String getAUTH_PHONE() {
		return AUTH_PHONE;
	}
	public void setAUTH_PHONE(String aUTH_PHONE) {
		AUTH_PHONE = aUTH_PHONE;
	}
	public String getStDt() {
		return stDt;
	}
	public void setStDt(String stDt) {
		this.stDt = stDt;
	}
	public String getFnDt() {
		return fnDt;
	}
	public void setFnDt(String fnDt) {
		this.fnDt = fnDt;
	}
	public String getCnYn() {
		return cnYn;
	}
	public void setCnYn(String cnYn) {
		this.cnYn = cnYn;
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
	public String getUseTime() {
		return useTime;
	}
	public void setUseTime(String useTime) {
		this.useTime = useTime;
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
	public String getCOMPANY_ID() {
		return COMPANY_ID;
	}
	public void setCOMPANY_ID(String cOMPANY_ID) {
		COMPANY_ID = cOMPANY_ID;
	}
	@Override
	public String toString() {
		return "UserVO [USER_ID=" + USER_ID + ", USER_PW=" + USER_PW + ", USER_PW1=" + USER_PW1 + ", USER_NAME="
				+ USER_NAME + ", USER_LEVEL=" + USER_LEVEL + ", USER_PHONE=" + USER_PHONE + ", USER_EMAIL=" + USER_EMAIL
				+ ", USER_DEPT=" + USER_DEPT + ", USER_RANK=" + USER_RANK + ", USE_YN=" + USE_YN + ", REG_DT=" + REG_DT
				+ ", AUTH_CODE=" + AUTH_CODE + ", AUTH_NAME=" + AUTH_NAME + ", INTRO_YN=" + INTRO_YN + ", AUTH_PHONE="
				+ AUTH_PHONE + ", stDt=" + stDt + ", fnDt=" + fnDt + ", cnYn=" + cnYn + ", searchType=" + searchType
				+ ", searchValue=" + searchValue + ", useTime=" + useTime + ", sDate=" + sDate + ", eDate=" + eDate
				+ ", COMPANY_ID=" + COMPANY_ID + ", COMPANY_NAME=" + COMPANY_NAME + "]";
	}
	

}
