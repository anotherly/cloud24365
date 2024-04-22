package kr.co.hivesys.charge.vo;

import java.util.List;


import kr.co.hivesys.comm.file.vo.FileVo;
public class ChargeVo extends FileVo{
	
	private String CHARGE_ID;
	
	private String COMPANY_ID;
	
	private String COMPANY_NAME;
	
	private String PRE_PRICE;
	
	private String BILL_DT;
	private String BILL_RFDT;
	private String DUE_DATE;
	
	private String SERVICE_TYPE;
	private String SERVICE_TYPE_NM;
	private String PRICE_TYPE;
	
	private String USE_DT;
	private String BR_NUMBER;
	private String MSP_PRICE;
	private String IAAS_PRICE;
	private String DATADR_PRICE;
	
	private String SUM_PRICE;
	
	public String getSERVICE_TYPE() {
		return SERVICE_TYPE;
	}
	public void setSERVICE_TYPE(String sERVICE_TYPE) {
		SERVICE_TYPE = sERVICE_TYPE;
	}
	public String getSERVICE_TYPE_NM() {
		return SERVICE_TYPE_NM;
	}
	public void setSERVICE_TYPE_NM(String sERVICE_TYPE_NM) {
		SERVICE_TYPE_NM = sERVICE_TYPE_NM;
	}
	public String getPRICE_TYPE() {
		return PRICE_TYPE;
	}
	public void setPRICE_TYPE(String pRICE_TYPE) {
		PRICE_TYPE = pRICE_TYPE;
	}
	public String getDUE_DATE() {
		return DUE_DATE;
	}
	public void setDUE_DATE(String dUE_DATE) {
		DUE_DATE = dUE_DATE;
	}
	public String getSUM_PRICE() {
		return SUM_PRICE;
	}
	public void setSUM_PRICE(String sUM_PRICE) {
		SUM_PRICE = sUM_PRICE;
	}
	public String getCHARGE_ID() {
		return CHARGE_ID;
	}
	public void setCHARGE_ID(String cHARGE_ID) {
		CHARGE_ID = cHARGE_ID;
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
	public String getPRE_PRICE() {
		return PRE_PRICE;
	}
	public void setPRE_PRICE(String pRE_PRICE) {
		PRE_PRICE = pRE_PRICE;
	}
	public String getBILL_DT() {
		return BILL_DT;
	}
	public void setBILL_DT(String bILL_DT) {
		BILL_DT = bILL_DT;
	}
	public String getBILL_RFDT() {
		return BILL_RFDT;
	}
	public void setBILL_RFDT(String bILL_RFDT) {
		BILL_RFDT = bILL_RFDT;
	}
	public String getUSE_DT() {
		return USE_DT;
	}
	public void setUSE_DT(String uSE_DT) {
		USE_DT = uSE_DT;
	}
	public String getBR_NUMBER() {
		return BR_NUMBER;
	}
	public void setBR_NUMBER(String bR_NUMBER) {
		BR_NUMBER = bR_NUMBER;
	}
	public String getMSP_PRICE() {
		return MSP_PRICE;
	}
	public void setMSP_PRICE(String mSP_PRICE) {
		MSP_PRICE = mSP_PRICE;
	}
	public String getIAAS_PRICE() {
		return IAAS_PRICE;
	}
	public void setIAAS_PRICE(String iAAS_PRICE) {
		IAAS_PRICE = iAAS_PRICE;
	}
	public String getDATADR_PRICE() {
		return DATADR_PRICE;
	}
	public void setDATADR_PRICE(String dATADR_PRICE) {
		DATADR_PRICE = dATADR_PRICE;
	}
	@Override
	public String toString() {
		return "ChargeVo [CHARGE_ID=" + CHARGE_ID + ", COMPANY_ID=" + COMPANY_ID + ", COMPANY_NAME=" + COMPANY_NAME
				+ ", PRE_PRICE=" + PRE_PRICE + ", BILL_DT=" + BILL_DT + ", BILL_RFDT=" + BILL_RFDT + ", USE_DT="
				+ USE_DT + ", BR_NUMBER=" + BR_NUMBER + ", MSP_PRICE=" + MSP_PRICE + ", IAAS_PRICE=" + IAAS_PRICE
				+ ", DATADR_PRICE=" + DATADR_PRICE + "]";
	}
	
	
}
