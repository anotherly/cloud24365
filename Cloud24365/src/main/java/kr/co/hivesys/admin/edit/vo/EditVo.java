package kr.co.hivesys.admin.edit.vo;

public class EditVo {
	private String DOCUMENT_ID;
	private String TEXT_VAL;
	private String REG_DT;
	private String DOCUMENT_DIV;
	public String getDOCUMENT_ID() {
		return DOCUMENT_ID;
	}
	public void setDOCUMENT_ID(String dOCUMENT_ID) {
		DOCUMENT_ID = dOCUMENT_ID;
	}
	public String getTEXT_VAL() {
		return TEXT_VAL;
	}
	public void setTEXT_VAL(String tEXT_VAL) {
		TEXT_VAL = tEXT_VAL;
	}
	public String getREG_DT() {
		return REG_DT;
	}
	public void setREG_DT(String rEG_DT) {
		REG_DT = rEG_DT;
	}
	public String getDOCUMENT_DIV() {
		return DOCUMENT_DIV;
	}
	public void setDOCUMENT_DIV(String dOCUMENT_DIV) {
		DOCUMENT_DIV = dOCUMENT_DIV;
	}
	@Override
	public String toString() {
		return "EditVo [DOCUMENT_ID=" + DOCUMENT_ID + ", TEXT_VAL=" + TEXT_VAL + ", REG_DT=" + REG_DT
				+ ", DOCUMENT_DIV=" + DOCUMENT_DIV + "]";
	}
}
