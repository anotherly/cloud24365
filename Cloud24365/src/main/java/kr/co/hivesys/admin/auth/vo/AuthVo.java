package kr.co.hivesys.admin.auth.vo;

public class AuthVo {
	
	//순번
	private String idx;
	//순번2
	private String subIdx;
	//권한코드
	private String authCode;
	//권한 주소
	private String url;
	//권한명
	private String authName;
	//권한주소명1
	private String authUrlName1;
	//권한주소명2	
	private String authUrlName2;
	//권한주소명3	
	private String authUrlName3;
	//허용여부
	private String useYn;
	//대중소구분 
	public String cdFlag;
	public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	public String getSubIdx() {
		return subIdx;
	}
	public void setSubIdx(String subIdx) {
		this.subIdx = subIdx;
	}
	public String getAuthCode() {
		return authCode;
	}
	public void setAuthCode(String authCode) {
		this.authCode = authCode;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getAuthName() {
		return authName;
	}
	public void setAuthName(String authName) {
		this.authName = authName;
	}
	public String getAuthUrlName1() {
		return authUrlName1;
	}
	public void setAuthUrlName1(String authUrlName1) {
		this.authUrlName1 = authUrlName1;
	}
	public String getAuthUrlName2() {
		return authUrlName2;
	}
	public void setAuthUrlName2(String authUrlName2) {
		this.authUrlName2 = authUrlName2;
	}
	public String getAuthUrlName3() {
		return authUrlName3;
	}
	public void setAuthUrlName3(String authUrlName3) {
		this.authUrlName3 = authUrlName3;
	}
	public String getUseYn() {
		return useYn;
	}
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	public String getCdFlag() {
		return cdFlag;
	}
	public void setCdFlag(String cdFlag) {
		this.cdFlag = cdFlag;
	}
	@Override
	public String toString() {
		return "AuthVo [idx=" + idx + ", subIdx=" + subIdx + ", authCode=" + authCode + ", url=" + url + ", authName="
				+ authName + ", authUrlName1=" + authUrlName1 + ", authUrlName2=" + authUrlName2 + ", authUrlName3="
				+ authUrlName3 + ", useYn=" + useYn + ", cdFlag=" + cdFlag + "]";
	}
	
}
