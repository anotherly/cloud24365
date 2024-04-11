package kr.co.hivesys.company.vo;

public class MspVo {
	private String COMPANY_ID;
	private String CLOUD_TYPE;
	private String CLOUD_TYPE_NM;
	private String SERVICE_TYPE;
	private String SERVICE_TYPE_NM;
	private String BUY_CNT;
	
	public String getCLOUD_TYPE_NM() {
		return CLOUD_TYPE_NM;
	}
	public void setCLOUD_TYPE_NM(String cLOUD_TYPE_NM) {
		CLOUD_TYPE_NM = cLOUD_TYPE_NM;
	}
	public String getSERVICE_TYPE_NM() {
		return SERVICE_TYPE_NM;
	}
	public void setSERVICE_TYPE_NM(String sERVICE_TYPE_NM) {
		SERVICE_TYPE_NM = sERVICE_TYPE_NM;
	}
	public String getCOMPANY_ID() {
		return COMPANY_ID;
	}
	public void setCOMPANY_ID(String cOMPANY_ID) {
		COMPANY_ID = cOMPANY_ID;
	}
	public String getCLOUD_TYPE() {
		return CLOUD_TYPE;
	}
	public void setCLOUD_TYPE(String cLOUD_TYPE) {
		CLOUD_TYPE = cLOUD_TYPE;
	}
	public String getSERVICE_TYPE() {
		return SERVICE_TYPE;
	}
	public void setSERVICE_TYPE(String sERVICE_TYPE) {
		SERVICE_TYPE = sERVICE_TYPE;
	}
	public String getBUY_CNT() {
		return BUY_CNT;
	}
	public void setBUY_CNT(String bUY_CNT) {
		BUY_CNT = bUY_CNT;
	}
	@Override
	public String toString() {
		return "MspVo [COMPANY_ID=" + COMPANY_ID + ", CLOUD_TYPE=" + CLOUD_TYPE + ", SERVICE_TYPE=" + SERVICE_TYPE
				+ ", BUY_CNT=" + BUY_CNT + "]";
	}
	
}
