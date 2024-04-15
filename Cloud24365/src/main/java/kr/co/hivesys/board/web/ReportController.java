package kr.co.hivesys.board.web;

import java.lang.reflect.Field;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.InputVerifier;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.hivesys.comm.excel.ExcelComport;
import kr.co.hivesys.comm.file.FileUploadSave;
import kr.co.hivesys.comm.file.service.FileService;
import kr.co.hivesys.comm.file.vo.FileVo;
import kr.co.hivesys.company.service.CompanyService;
import kr.co.hivesys.company.vo.CompanyVo;
import kr.co.hivesys.board.service.ReportService;
import kr.co.hivesys.board.vo.ReportVo;
import kr.co.hivesys.user.service.UserService;
import kr.co.hivesys.user.vo.UserVO;


@Controller
public class ReportController{

	public static final Logger logger = LoggerFactory.getLogger(ReportController.class);
	
	@Resource(name="companyService")
	private CompanyService companyService;
	
	@Resource(name="reportService")
	private ReportService reportService;
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="fileService")
	private FileService fileService;
	
	@Resource(name="fileLogic")
	private FileUploadSave fus;
	
	public String url="";
	
	List<ReportVo> sList=  new ArrayList<>();
	
	//주소에 맞게 매핑
	@RequestMapping(value="/admin/report/**/*.do")
	public String urlMapping(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.고객지원 관리 페이지 최초 진입 및 분기 컨트롤러");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		logger.debug("▶▶▶▶▶▶▶.보내려는 url : "+url);
		return url;
	}
	
	//문의하기 목록 조회
	@RequestMapping(value= {
			"/admin/report/reportList.ajax"
			,"/client/support/reportList.ajax"})
	public @ResponseBody ModelAndView reqList( 
			HttpServletRequest request
			//,@RequestParam(required=false, value="idArr[]")List<String> listArr
			,@ModelAttribute("ReportVo") ReportVo inputVo
		) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			sList = reportService.selectList(inputVo);
			mav.addObject("data", sList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	//등록 저장
	@RequestMapping(value= {
			"/admin/report/insertReport.ajax"
			,"/client/support/insertReport.ajax"})
	public ModelAndView insertReq(HttpSession httpSession, 
			HttpServletRequest request,Model model
			,@ModelAttribute("ReportVo") ReportVo inputVo
			,@RequestParam("multiFile") List<MultipartFile> multiFileList
			) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		
		try {
			//작성자는 로그인 사용자로
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			inputVo.setCOMPANY_ID(nlVo.getCOMPANY_ID());
			//id 생성
			inputVo.setREPORT_ID(reportService.creReportId(inputVo));
			
			/*파일 업로드 관련*/
			if(multiFileList.size()!=0) {
				//화면에 따른 변경부분
				//경로,원본id
				String inputPath = "resources/report/" +inputVo.getREPORT_ID()+ "/";
				String oriId = inputVo.getREPORT_ID();
				/*공통 적용 부분*/
				FileVo fvo = new FileVo();
				fvo.setFILE_DIR(inputPath);
				fvo.setFILE_ORIGIN(oriId);
				fus.fileUploadMultiple(multiFileList,fvo);
				
			}
			
			int cnt=reportService.insert(inputVo);
			mav.addObject("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","저장에 실패하였습니다");
		}
		return mav;
	}
	// 상세,수정 페이지 진입
	@RequestMapping(value={
			"/admin/report/reportInsert.do"
			,"/admin/report/reportDetail.do"
			,"/admin/report/reportUpdate.do"

			,"/client/support/reportInsert.do"
			,"/client/support/reportDetail.do"
			,"/client/support/reportUpdate.do"
	})
	public @ResponseBody ModelAndView detail( @ModelAttribute("ReportVo") ReportVo thvo,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		List<CompanyVo> companyList = new ArrayList<>();
		ModelAndView mav;
		if(url.contains("Insert")) {
			mav = new ModelAndView(url);
		}else {
			mav = new ModelAndView("jsonView");
		}
		ReportVo inputVo= null;
		List<FileVo> fileList= null;
		FileVo fvo = new FileVo();
		try {
			inputVo = reportService.selectOne(thvo);
			logger.debug("▶▶▶▶▶▶▶.결과값들:"+inputVo);
			
			companyList=companyService.selectCompanyList(new CompanyVo());
			mav.addObject("companyList", companyList);
			
			fvo.setFILE_ORIGIN(inputVo.getREPORT_ID());
			fileList=fileService.selectFileList(fvo);
			
			mav.addObject("data", inputVo);
			mav.addObject("fileList", fileList);
			mav.addObject("companyList", companyList);
			mav.setViewName(url);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	// 수정 반영
	@RequestMapping(value= {
			"/admin/report/reportUpdate.ajax"
			,"/client/support/reportUpdate.ajax"
	})
	public @ResponseBody ModelAndView update( 
			@ModelAttribute("ReportVo") ReportVo inputVo
			,@RequestParam("multiFile") List<MultipartFile> multiFileList
			,HttpServletRequest request) throws Exception{
		
		logger.debug("▶▶▶▶▶▶▶.회원정보 수정!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			//작성자는 로그인 사용자로
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			inputVo.setCOMPANY_ID(nlVo.getCOMPANY_ID());
			
			/*파일 업로드 관련*/
			if(multiFileList.size()!=0) {
				//화면에 따른 변경부분
				//경로,원본id
				String inputPath = "resources/report/" +inputVo.getREPORT_ID()+ "/";
				String oriId = inputVo.getREPORT_ID();
				/*공통 적용 부분*/
				FileVo fvo = new FileVo();
				fvo.setFILE_DIR(inputPath);
				fvo.setFILE_ORIGIN(oriId);
				fus.fileUploadMultiple(multiFileList,fvo);
			}
			int cnt=reportService.update(inputVo);
			mav.addObject("cnt", cnt);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","에러가 발생하였습니다");
		}
		return mav;
	}
	
	// 삭제
	@RequestMapping(value= {
			"/admin/report/reportDelete.do"
			,"/client/support/reportDelete.do"
	})
	public @ResponseBody ModelAndView userDelete( @RequestParam(value="idArr[]")List<String> listArr,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 삭제!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			/*부모 키에 따른 파일 일괄삭제 관련*/
			List<FileVo> fileList = new ArrayList<>();
			for (String str : listArr) {
				//화면에 따른 변경부분
				String inputPath = "resources/report/" +str+ "/";
				String oriId = str;
				/*공통 적용 부분*/
				FileVo dbvo = new FileVo();
				dbvo.setFILE_DIR(inputPath);
				dbvo.setFILE_ORIGIN(oriId);
				fileList.add(dbvo);
			}
			fus.folderDelete(fileList);
			reportService.delete(listArr);
		} catch (Exception e) {
			mav.addObject("msg","에러가 발생하였습니다");
		}
		return mav;
	}
	
	// 엑셀 다운로드를 위한 th td 매핑
	@RequestMapping(
		value={"/admin/report/excelDownload.ajax"}
	)
	public void excelDownload(
		HttpServletRequest req, HttpServletResponse res
	) throws Exception{
		
		Map<String, Object> model = new HashMap<>();
		
		HashMap<Integer, String> thMap = new HashMap<Integer, String>();
		HashMap<Integer, Map> tbMap = new HashMap<Integer,Map>();
		HashMap<Integer, String> tbSubMap;
		
		//표제 부분
		thMap.put(0,"공지번호");
		thMap.put(1,"분류");
		thMap.put(2,"제목");
		thMap.put(3,"작성자");
		thMap.put(4,"작성일자");
		
		//표 내용 부분
		for (int i = 0; i < sList.size(); i++) {
			tbSubMap = new HashMap<Integer, String>();
			tbSubMap.put(0,sList.get(i).getREPORT_ID());
			tbSubMap.put(1,sList.get(i).getREPORT_TYPE_NM());
			tbSubMap.put(2,sList.get(i).getCOMPANY_NAME());
			tbSubMap.put(3,sList.get(i).getPROJECT_NAME());
			tbSubMap.put(3,sList.get(i).getREPORT_NAME());
			tbSubMap.put(4,sList.get(i).getREG_DT());
			tbMap.put(i,tbSubMap);
		}
		
		ExcelComport ex =new ExcelComport();
		//별도의 엑셀 표 생성 함수 
		XSSFWorkbook workbook = ex.createDfExcelContent(thMap,tbMap);
		
		//다운로드를 위한 헤더 핸들링
		ex.excelDownload(req,res,"공지사항_목록",workbook);
	}
}
