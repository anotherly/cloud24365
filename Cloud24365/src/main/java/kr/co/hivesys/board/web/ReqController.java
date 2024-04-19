package kr.co.hivesys.board.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import kr.co.hivesys.board.service.QnaService;
import kr.co.hivesys.board.vo.QnaVo;
import kr.co.hivesys.user.service.UserService;
import kr.co.hivesys.user.vo.UserVO;


@Controller
public class ReqController{

	public static final Logger logger = LoggerFactory.getLogger(ReqController.class);
	
	@Resource(name="qnaService")
	private QnaService qnaService;
	
	@Resource(name="companyService")
	private CompanyService companyService;
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="fileService")
	private FileService fileService;
	
	List<QnaVo> sList=  new ArrayList<>();
	
	public String url="";
	
	@Resource(name="fileLogic")
	private FileUploadSave fus;
	
	//문의하기 목록 조회
	@RequestMapping(value="/client/support/request/reqList.ajax")
	public @ResponseBody ModelAndView reqList( 
			HttpServletRequest request
			//@RequestParam(required=false, value="idArr[]")List<String> listArr
			,@ModelAttribute("qnaVo") QnaVo inputVo) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			inputVo.setCOMPANY_ID(nlVo.getCOMPANY_ID());	
			sList = qnaService.selectReqList(inputVo);
			
			mav.addObject("data", sList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	//수동등록 화면
	@RequestMapping(value="/client/support/request/reqInsert.do")
	public @ResponseBody ModelAndView reqInsert (HttpServletRequest request) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView(url);
		List<CompanyVo> cpnyList = new ArrayList<>();
		try {
			cpnyList = companyService.selectCompanyList(new CompanyVo());
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	//수동등록 저장
	@RequestMapping(value= "/client/support/request/insertReq.ajax")
	public ModelAndView insertReq( 
			HttpSession httpSession, Model model
			,@RequestParam("multiFile") List<MultipartFile> multiFileList
			, HttpServletRequest request, HttpServletResponse response
			,@ModelAttribute("qnaVo") QnaVo inputVo
			,@RequestParam(required=false, value="fileChg") String fileChg
			,@RequestParam(required=false, value="createFileError") String createFileError
			) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			//현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			if(inputVo.getREQ_QUESTION()!=null) {
				inputVo.setREQ_QUESTION(inputVo.getREQ_QUESTION().replace("\r\n","<br>"));
			}
			inputVo.setCOMPANY_ID(nlVo.getCOMPANY_ID());
			inputVo.setREQ_ID(qnaService.creReqId(inputVo));
			inputVo.setINSERT_TYPE("1");
			
			/*파일 업로드 관련*/
			if(multiFileList.size()!=0) {
				//화면에 따른 변경부분
				//경로,원본id
				String inputPath = "resources/support/" +inputVo.getREQ_ID()+ "/";
				String oriId = inputVo.getREQ_ID();
				/*공통 적용 부분*/
				FileVo fvo = new FileVo();
				fvo.setFILE_DIR(inputPath);
				fvo.setFILE_ORIGIN(oriId);
				fus.fileUploadMultiple(multiFileList,fvo);
			}
			
			int cnt =qnaService.insertReq(inputVo);
			mav.addObject("cnt", cnt);
			
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","저장에 실패하였습니다");
		}
		return mav;
	}
		
	//사용자 목록에 답변하기(상셰)
	@RequestMapping(value="/client/support/request/reqDetail.do")
	public @ResponseBody ModelAndView reqDetail( 
	HttpServletRequest request, HttpServletResponse response
	,@ModelAttribute("qnaVo") QnaVo inputVo
	) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		QnaVo reqVo= null;
		List<UserVO> userList= null;
		List<FileVo> fileList= null;
		FileVo fvo= new FileVo();
		try {
			reqVo = qnaService.selectReqOne(inputVo);
			userList = userService.selectAdmin();
			fvo.setFILE_ORIGIN(inputVo.getREQ_ID());
			fileList=fileService.selectFileList(fvo);
			
			//엔터처리
			if(reqVo.getREQ_QUESTION()!=null) {
				reqVo.setREQ_QUESTION(reqVo.getREQ_QUESTION().replace("<br>","\r\n"));
			}
			
			mav.addObject("reqVo", reqVo);
			mav.addObject("userList", userList);
			mav.addObject("fileList", fileList);
			mav.setViewName(url);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(""+e);
			mav.addObject("msg","에러가 발생했습니다.");
		}
		return mav;
	}
	
	//사용자 목록에 답변 후 저장
	@RequestMapping(value="/client/support/request/reqUpdate.ajax")
	public @ResponseBody ModelAndView reqUpdate(
			@RequestParam("multiFile") List<MultipartFile> multiFileList
			, HttpServletRequest request, HttpServletResponse response
			,@ModelAttribute("qnaVo") QnaVo inputVo
			) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		QnaVo thvo= null;
		try {
			
			//현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			inputVo.setUSER_ID(nlVo.getUSER_ID());
			if(inputVo.getREQ_ANSWER()!=null) {
				inputVo.setREQ_ANSWER(inputVo.getREQ_ANSWER().replace("\r\n","<br>"));
			}
			
			inputVo.setANS_ID(qnaService.creAnsId(inputVo));
			inputVo.setREQ_STATUS("2");
			/*파일 업로드 관련*/
			if(multiFileList.size()!=0) {
				//화면에 따른 변경부분
				//경로,원본id
				String inputPath = "resources/support/" +inputVo.getANS_ID()+ "/";
				String oriId = inputVo.getANS_ID();
				/*공통 적용 부분*/
				FileVo fvo = new FileVo();
				fvo.setFILE_DIR(inputPath);
				fvo.setFILE_ORIGIN(oriId);
				fus.fileUploadMultiple(multiFileList,fvo);
			}
			
			//qnaService.reqUpdate(inputVo);
			int cnt =qnaService.ansInsert(inputVo);
			mav.addObject("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(""+e);
			mav.addObject("msg","에러가 발생했습니다.");
		}
		return mav;
	}
	//답변+파일리스트 가져오기
	@RequestMapping(value="/request/ansHistoryList.ajax")
	public @ResponseBody ModelAndView ansHistoryList( 
			HttpServletRequest request
			,@ModelAttribute("qnaVo") QnaVo inputVo) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			List<QnaVo> ansList = qnaService.selectAnsList(inputVo);
			
			//개행 처리 ㅡㅡ
			for (int i = 0; i < ansList.size(); i++) {
				QnaVo upvo = new QnaVo(); 
				upvo = ansList.get(i);
				if(upvo.getREQ_ANSWER()!=null) {
					upvo.setREQ_ANSWER(upvo.getREQ_ANSWER().replace("<br>","\r\n"));
				}
				ansList.set(i, upvo);
			}
			List<FileVo> fileList = qnaService.ansFileList(inputVo);
			
			mav.addObject("ansList", ansList);
			mav.addObject("fileList", fileList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	
	// 엑셀 다운로드를 위한 th td 매핑
	@RequestMapping(
		value={"/client/support/req/excelDownload.ajax"}
	)
	public void excelDownload(
		HttpServletRequest req, HttpServletResponse res
	) throws Exception{
		
		Map<String, Object> model = new HashMap<>();
		
		HashMap<Integer, String> thMap = new HashMap<Integer, String>();
		HashMap<Integer, Map> tbMap = new HashMap<Integer,Map>();
		HashMap<Integer, String> tbSubMap;
		
		//표제 부분
		thMap.put(0,"문의번호");
		thMap.put(1,"상태");
		thMap.put(2,"문의유형");
		thMap.put(3,"중요도");
		thMap.put(4,"배정 담당자");
		thMap.put(5,"제목");
		thMap.put(6,"작성일자");
		thMap.put(7,"등록유형");
		
		//표 내용 부분
		for (int i = 0; i < sList.size(); i++) {
			tbSubMap = new HashMap<Integer, String>();
			tbSubMap.put(0,sList.get(i).getREQ_ID());
			tbSubMap.put(1,sList.get(i).getREQ_STATUS());
			tbSubMap.put(2,sList.get(i).getREQ_TYPE());
			tbSubMap.put(3,sList.get(i).getREQ_IMPORTANT());
			tbSubMap.put(4,sList.get(i).getUSER_NAME());
			tbSubMap.put(5,sList.get(i).getREQ_TITLE());
			tbSubMap.put(6,sList.get(i).getREQ_DT());
			tbSubMap.put(7,sList.get(i).getANS_TYPE());
			tbMap.put(i,tbSubMap);
		}
		
		ExcelComport ex =new ExcelComport();
		//별도의 엑셀 표 생성 함수 
		XSSFWorkbook workbook = ex.createDfExcelContent(thMap,tbMap);
		
		//다운로드를 위한 헤더 핸들링
		ex.excelDownload(req,res,"문의관리_목록",workbook);
	}
}
