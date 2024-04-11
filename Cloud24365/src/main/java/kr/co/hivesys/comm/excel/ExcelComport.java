package kr.co.hivesys.comm.excel;

import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelComport {


	//테이블 속성제목 부 디자인
	public XSSFCellStyle titleStyle(XSSFWorkbook workbook){
		// Cell style(th 부분)
        XSSFCellStyle titleStyle = workbook.createCellStyle();
        //정렬
        titleStyle.setAlignment(CellStyle.ALIGN_CENTER); //가운데 정렬
        titleStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER); //높이 가운데 정렬
        //배경색
        titleStyle.setFillForegroundColor(IndexedColors.GREY_25_PERCENT.getIndex());
        titleStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
        //테두리 선 (우,좌,위,아래)
        titleStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
        titleStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
        titleStyle.setBorderTop(XSSFCellStyle.BORDER_THIN);
        titleStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN);
        /*셀 스타일 셋팅 종료*/
        return titleStyle;
	}
	
	//테이블 내용 부 디자인
	public XSSFCellStyle contentStyle(XSSFWorkbook workbook){
		// Cell style(데이터 내용 tb)
		XSSFCellStyle contentStyle = workbook.createCellStyle();
		//배경색
		//contentStyle.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.index);
		//contentStyle.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		
		//테두리 선 (우,좌,위,아래)
		contentStyle.setBorderTop(CellStyle.BORDER_THIN);
		contentStyle.setBorderBottom(CellStyle.BORDER_THIN);
		contentStyle.setBorderLeft(CellStyle.BORDER_THIN);
		contentStyle.setBorderRight(CellStyle.BORDER_THIN);
		contentStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		/*셀 스타일 셋팅 종료*/
		return contentStyle;
	}
	
	//
	/**
	 * 기본 테이블 엑셀 다운로드 기능
	 * 주의 ! 해당 메소드는 페이지에 표출되는 테이블 형식대로 
	 * 고정 크기와 고정 컬럼값을 지니므로
	 * 셀 병합,특정 셀의 크기 변동등의 별도의 핸들링이 필요하다면
	 * 따로 짜야한다... 
	 * */
	public XSSFWorkbook createDfExcelContent
	(HashMap<Integer, String> thMap, HashMap<Integer, Map> tbMap) {
	    
	    int x=1;//열 인덱스 -> 0부터 시작 1칸 띄우고 시작
		int y=1;//행 인덱스 -> 0부터 시작 1칸 띄우고 시작
		
		//엑셀 객체 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		//엑셀 시트 생성
		XSSFSheet sheet1 = workbook.createSheet("sheet1");//들어가는 파라미터는 시트명임
		//시트너비 (고정)
		for (int i = 0; i < thMap.size(); i++) {
			sheet1.setColumnWidth(i+1, 7000);//약 2500~3000이 기본 엑셀 가로넓이라고 생각하면 됨
		}
	    //엑셀 행렬 객체 생성
	    XSSFRow objRow = sheet1.createRow(y); //행 (y)
	    XSSFCell objCel=null;
	    //th 디자인 
	    XSSFCellStyle titleStyle = titleStyle(workbook); 
	    //tb 디자인 
	    XSSFCellStyle contentStyle = contentStyle(workbook); 
	    
	    //행에 대한 열 생성 / 해당 열에 값 삽입
	    //th 부분
	    for (int i = 0; i < thMap.size(); i++) {
	    	objCel=objRow.createCell(x+i);
	    	objCel.setCellStyle(titleStyle);
	    	objCel.setCellValue(thMap.get(i));
		}
	    y++;
	    //tbody 부분
	    for (int i = 0; i < tbMap.size(); i++) {
	    	objRow = sheet1.createRow(y+i);
	    	HashMap<Integer, String> tbSubMap = new HashMap<Integer, String>();
	    	tbSubMap=(HashMap<Integer, String>) tbMap.get(i);
	    	for (int j = 0; j < tbSubMap.size(); j++) {
	    		objCel=objRow.createCell(x+j);
		    	objCel.setCellStyle(contentStyle);
		    	objCel.setCellValue(tbSubMap.get(j));
			}
	    }
		return workbook;
	}
	
	//다운로드를 위한 헤더 핸들링
	public void excelDownload(HttpServletRequest req, HttpServletResponse res,String fileName,XSSFWorkbook workbook) {
		try {
			// 브라우저에 따른 파일명 인코딩
	        String userAgent = req.getHeader("User-Agent");
	        if (userAgent.indexOf("MSIE") > -1) {
	            fileName = URLEncoder.encode(fileName, "UTF-8");
	        } else {
	            fileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
	        }
	        res.setContentType("application/vnd.ms-excel; charset=euc-kr");
	        res.setHeader("Content-Description" , "JSP Generated Data");
	        res.setHeader("Content-disposition", "attachment; filename=\"" + fileName + ".xlsx\"");
	        
	        	
	        ServletOutputStream out= res.getOutputStream();
	        workbook.write(out);
	        out.flush();
	        out.close();			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
