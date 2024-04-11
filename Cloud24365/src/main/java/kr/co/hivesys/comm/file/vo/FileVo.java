package kr.co.hivesys.comm.file.vo;

public class FileVo {
	private String FILE_ID;
	private String FILE_DIR;
	private String FILE_NAME;
	private String REG_DT;
	private String FILE_ORIGIN;
	
	private String filePath;
	
	
	
	public String getFILE_ORIGIN() {
		return FILE_ORIGIN;
	}
	public void setFILE_ORIGIN(String fILE_ORIGIN) {
		FILE_ORIGIN = fILE_ORIGIN;
	}
	public String getFILE_DIR() {
		return FILE_DIR;
	}
	public void setFILE_DIR(String fILE_DIR) {
		FILE_DIR = fILE_DIR;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFILE_ID() {
		return FILE_ID;
	}
	public void setFILE_ID(String fILE_ID) {
		FILE_ID = fILE_ID;
	}
	public String getFILE_NAME() {
		return FILE_NAME;
	}
	public void setFILE_NAME(String fILE_NAME) {
		FILE_NAME = fILE_NAME;
	}
	public String getREG_DT() {
		return REG_DT;
	}
	public void setREG_DT(String rEG_DT) {
		REG_DT = rEG_DT;
	}
	@Override
	public String toString() {
		return "FileVo [FILE_ID=" + FILE_ID + ", FILE_DIR=" + FILE_DIR + ", FILE_NAME=" + FILE_NAME + ", REG_DT="
				+ REG_DT + ", FILE_ORIGIN=" + FILE_ORIGIN + ", filePath=" + filePath + "]";
	}
}
