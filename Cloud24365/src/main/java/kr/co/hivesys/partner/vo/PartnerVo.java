package kr.co.hivesys.partner.vo;

import kr.co.hivesys.comm.file.vo.FileVo;

public class PartnerVo extends FileVo{
	
	public String PARTNER_ID;
	public String PARTNER_NAME;
	public String REG_DT;
	public String PARTNER_URL;
	public String CONTENTS;
	
	public String getPARTNER_ID() {
		return PARTNER_ID;
	}
	public void setPARTNER_ID(String pARTNER_ID) {
		PARTNER_ID = pARTNER_ID;
	}
	public String getPARTNER_NAME() {
		return PARTNER_NAME;
	}
	public void setPARTNER_NAME(String pARTNER_NAME) {
		PARTNER_NAME = pARTNER_NAME;
	}
	public String getREG_DT() {
		return REG_DT;
	}
	public void setREG_DT(String rEG_DT) {
		REG_DT = rEG_DT;
	}
	public String getPARTNER_URL() {
		return PARTNER_URL;
	}
	public void setPARTNER_URL(String pARTNER_URL) {
		PARTNER_URL = pARTNER_URL;
	}
	public String getCONTENTS() {
		return CONTENTS;
	}
	public void setCONTENTS(String cONTENTS) {
		CONTENTS = cONTENTS;
	}
	@Override
	public String toString() {
		return "PartnerVo [PARTNER_ID=" + PARTNER_ID + ", PARTNER_NAME=" + PARTNER_NAME + ", REG_DT=" + REG_DT
				+ ", PARTNER_URL=" + PARTNER_URL + ", CONTENTS=" + CONTENTS + "]";
	}
	
}
