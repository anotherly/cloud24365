package kr.co.hivesys.bill.web;

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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.hivesys.bill.service.BillService;
import kr.co.hivesys.bill.vo.BillVo;
import kr.co.hivesys.board.vo.NoticeVo;
import kr.co.hivesys.board.web.NoticeController;
import kr.co.hivesys.comm.excel.ExcelComport;
import kr.co.hivesys.comm.file.FileUploadSave;
import kr.co.hivesys.comm.file.service.FileService;
import kr.co.hivesys.comm.file.vo.FileVo;
import kr.co.hivesys.company.service.CompanyService;
import kr.co.hivesys.report.service.ReportService;
import kr.co.hivesys.user.service.UserService;
import kr.co.hivesys.user.vo.UserVO;


@Controller
public class BillController{

	public static final Logger logger = LoggerFactory.getLogger(BillController.class);
	
	@Resource(name="billService")
	private BillService billService;
	
	@Resource(name="companyService")
	private CompanyService companyService;
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="fileService")
	private FileService fileService;
	
	@Resource(name="fileLogic")
	private FileUploadSave fus;
	
	public String url="";
	
	List<BillVo> sList=  new ArrayList<>();
	
	//문의하기 목록 조회
	@RequestMapping(value="/admin/edit/billList.ajax")
	public @ResponseBody ModelAndView reqList( 
			HttpServletRequest request
			//,@RequestParam(required=false, value="idArr[]")List<String> listArr
			,@ModelAttribute("BillVo") BillVo inputVo) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			sList = billService.selectList(inputVo);
			mav.addObject("data", sList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	//등록 저장
	@RequestMapping(value= "/admin/edit/insertBill.ajax")
	public ModelAndView insertReq(HttpSession httpSession, 
			HttpServletRequest request,Model model
			,@ModelAttribute("BillVo") BillVo inputVo
			,@RequestParam("multiFile") List<MultipartFile> multiFileList
			) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			//작성자는 로그인 사용자로
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			inputVo.setUSER_ID(nlVo.getUSER_ID());
			//id 생성
			inputVo.setBILL_FILE_ID(billService.createId(inputVo));
			
			/*파일 업로드 관련*/
			if(multiFileList.size()!=0) {
				//화면에 따른 변경부분
				//경로,원본id
				String inputPath = "resources/bill/" +inputVo.getBILL_FILE_ID()+ "/";
				String oriId = inputVo.getBILL_FILE_ID();
				/*공통 적용 부분*/
				FileVo fvo = new FileVo();
				fvo.setFILE_DIR(inputPath);
				fvo.setFILE_ORIGIN(oriId);
				fus.fileUploadMultiple(multiFileList,fvo);
			}
			
			int cnt=billService.insert(inputVo);
			mav.addObject("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","저장에 실패하였습니다");
		}
		return mav;
	}
	// 상세,수정 페이지 진입
	@RequestMapping(value={"/admin/edit/billDetail.do","/admin/edit/billUpdate.do"})
	public @ResponseBody ModelAndView detail( @ModelAttribute("BillVo") BillVo thvo,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		BillVo inputVo= null;
		List<FileVo> fileList= null;
		FileVo fvo = new FileVo();
		try {
			inputVo = billService.selectOne(thvo);
			logger.debug("▶▶▶▶▶▶▶.결과값들:"+inputVo);
			
			fvo.setFILE_ORIGIN(inputVo.getBILL_FILE_ID());
			fileList=fileService.selectFileList(fvo);
			
			mav.addObject("data", inputVo);
			mav.addObject("fileList", fileList);
			mav.setViewName(url);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	// 수정 반영
	@RequestMapping(value="/admin/edit/billUpdate.ajax")
	public @ResponseBody ModelAndView update( 
			@ModelAttribute("BillVo") BillVo inputVo
			,@RequestParam("multiFile") List<MultipartFile> multiFileList
			,HttpServletRequest request) throws Exception{
		
		logger.debug("▶▶▶▶▶▶▶.회원정보 수정!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			/*파일 업로드 관련*/
			if(multiFileList.size()!=0) {
				//화면에 따른 변경부분
				//경로,원본id
				String inputPath = "resources/bill/" +inputVo.getBILL_FILE_ID()+ "/";
				String oriId = inputVo.getBILL_FILE_ID();
				/*공통 적용 부분*/
				FileVo fvo = new FileVo();
				fvo.setFILE_DIR(inputPath);
				fvo.setFILE_ORIGIN(oriId);
				fus.fileUploadMultiple(multiFileList,fvo);
			}
			int cnt=billService.update(inputVo);
			mav.addObject("cnt", cnt);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","에러가 발생하였습니다");
		}
		return mav;
	}
	
	//우선순위 업데이트
	@RequestMapping(value="/admin/edit/firstNumber.ajax")
	public @ResponseBody ModelAndView firstNumber( 
			@ModelAttribute("BillVo") BillVo inputVo
			,HttpServletRequest request) throws Exception{

		logger.debug("▶▶▶▶▶▶▶.회원정보 수정!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			int cnt=billService.firstNumber(inputVo);
			mav.addObject("cnt", cnt);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","에러가 발생하였습니다");
		}
		return mav;
		
	}
	// 삭제
	@RequestMapping(value="/admin/edit/billDelete.do")
	public @ResponseBody ModelAndView userDelete( @RequestParam(value="idArr[]")List<String> listArr,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 삭제!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			billService.delete(listArr);
			
		} catch (Exception e) {
			mav.addObject("msg","에러가 발생하였습니다");
		}
		return mav;
	}
	
	
}
