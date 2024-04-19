package kr.co.hivesys.board.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
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
import kr.co.hivesys.board.service.FaqService;
import kr.co.hivesys.board.service.QnaService;
import kr.co.hivesys.board.vo.FaqVo;
import kr.co.hivesys.board.vo.NoticeVo;
import kr.co.hivesys.board.vo.QnaVo;
import kr.co.hivesys.user.service.UserService;
import kr.co.hivesys.user.vo.UserVO;


@Controller
public class FaqController {

	public static final Logger logger = LoggerFactory.getLogger(FaqController.class);
	
	@Resource(name="faqService")
	private FaqService faqService;
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="fileService")
	private FileService fileService;
	List<FaqVo> sList=  new ArrayList<>();
	
	public String url="";
	
	//문의하기 목록 조회
	@RequestMapping(value="/client/support/faq/faqList.ajax")
	public @ResponseBody ModelAndView reqList( 
			HttpServletRequest request
			//,@RequestParam(required=false, value="idArr[]")List<String> listArr
			,@ModelAttribute("FaqVo") FaqVo inputVo) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			sList = faqService.selectList(inputVo);
			
			//개행 처리 ㅡㅡ
			for (int i = 0; i < sList.size(); i++) {
				FaqVo upvo = new FaqVo(); 
				upvo = sList.get(i);
				if(upvo.getCONTENT()!=null) {
					upvo.setCONTENT(upvo.getCONTENT().replace("<br>","\r\n"));
				}
				sList.set(i, upvo);
			}
			
			mav.addObject("data", sList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	// 상세,수정 페이지 진입
	@RequestMapping(value={"/client/support/faq/faqDetail.do"})
	public @ResponseBody ModelAndView detail( @ModelAttribute("FaqVo") FaqVo thvo,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		FaqVo inputVo= null;
		try {
			inputVo = faqService.selectOne(thvo);
			logger.debug("▶▶▶▶▶▶▶.결과값들:"+inputVo);
			if(inputVo.getCONTENT()!=null) {
				inputVo.setCONTENT(inputVo.getCONTENT().replace("<br>","\r\n"));
			}
			mav.addObject("data", inputVo);
			mav.setViewName(url);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	// 엑셀 다운로드를 위한 th td 매핑
	@RequestMapping(
		value={"/client/support/faq/excelDownload.ajax"}
	)
	public void excelDownload(
		HttpServletRequest req, HttpServletResponse res
	) throws Exception{
		
		Map<String, Object> model = new HashMap<>();
		
		HashMap<Integer, String> thMap = new HashMap<Integer, String>();
		HashMap<Integer, Map> tbMap = new HashMap<Integer,Map>();
		HashMap<Integer, String> tbSubMap;
		
		//표제 부분
		thMap.put(0,"번호");
		thMap.put(1,"분류");
		thMap.put(2,"제목");
		thMap.put(3,"작성자");
		thMap.put(4,"작성일자");
		
		//표 내용 부분
		for (int i = 0; i < sList.size(); i++) {
			tbSubMap = new HashMap<Integer, String>();
			tbSubMap.put(0,sList.get(i).getFAQ_ID());
			tbSubMap.put(1,sList.get(i).getFAQ_TYPE_NM());
			tbSubMap.put(2,sList.get(i).getFAQ_TITLE());
			tbSubMap.put(3,sList.get(i).getUSER_NAME());
			tbSubMap.put(4,sList.get(i).getFAQ_DT());
			tbMap.put(i,tbSubMap);
		}
		
		ExcelComport ex =new ExcelComport();
		//별도의 엑셀 표 생성 함수 
		XSSFWorkbook workbook = ex.createDfExcelContent(thMap,tbMap);
		
		//다운로드를 위한 헤더 핸들링
		ex.excelDownload(req,res,"FAQ관리_목록",workbook);
	}
}
