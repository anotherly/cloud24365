package kr.co.hivesys.charge.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.net.URLEncoder;
import java.nio.file.Files;
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

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.io.IOUtils;
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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.hivesys.comm.excel.ExcelComport;
import kr.co.hivesys.comm.file.FileUploadSave;
import kr.co.hivesys.comm.file.service.FileService;
import kr.co.hivesys.comm.file.vo.FileVo;
import kr.co.hivesys.company.service.CompanyService;
import kr.co.hivesys.company.vo.CompanyVo;
import kr.co.hivesys.bill.service.BillService;
import kr.co.hivesys.bill.vo.BillVo;
import kr.co.hivesys.charge.service.ChargeService;
import kr.co.hivesys.charge.vo.ChargeVo;
import kr.co.hivesys.user.service.UserService;
import kr.co.hivesys.user.vo.UserVO;


@Controller
public class ChargeController{

	public static final Logger logger = LoggerFactory.getLogger(ChargeController.class);
	
	@Resource(name="companyService")
	private CompanyService companyService;
	
	@Resource(name="chargeService")
	private ChargeService chargeService;
	
	@Resource(name="billService")
	private BillService billService;
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="fileService")
	private FileService fileService;
	
	@Resource(name="fileLogic")
	private FileUploadSave fus;
	
	public String url="";
	
	//권한조회 후 최초 주소
	@RequestMapping(value= "/client/charge.do")
	public String firstAuth(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		return "redirect:/client/charge/chargeList.do";
	}
	
	//주소에 맞게 매핑
	@RequestMapping(value= "/client/charge/**/*.do")
	public String urlMapping(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.main 최초 컨트롤러 진입 httpSession : "+httpSession);
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		logger.debug("▶▶▶▶▶▶▶.보내려는 url : "+url);
		return url;
	}
	
	//과금현황 목록
	@RequestMapping(value= "/client/charge/chargeList.ajax")
	public @ResponseBody ModelAndView selectPriceList(
			@ModelAttribute("companyVO") CompanyVo thvo,
			HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		
		ModelAndView mav = new ModelAndView("jsonView");
		List<ChargeVo> chargeList= null;
		try {
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			thvo.setCOMPANY_ID(nlVo.getCOMPANY_ID());
			chargeList = chargeService.selectPriceList(thvo);
			mav.addObject("data", chargeList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	//과금현황 수정
	@RequestMapping(value= "/client/charge/updatePriceList.ajax")
	public @ResponseBody ModelAndView updatePriceList(
			@ModelAttribute("companyVO") CompanyVo thvo
			,HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		ModelAndView mav = new ModelAndView("jsonView");
		List<ChargeVo> sList= null;
		
		// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
		UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
		thvo.setCOMPANY_ID(nlVo.getCOMPANY_ID());
		
		int cnt=1;
		try {
			try {
				//msp 요금제 관련
				if(thvo.getChgList()!=null) {
						chargeService.deleteCharge(thvo.getChgList());
					cnt=chargeService.chargeInsert(thvo.getChgList());
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.debug("에러메시지 : "+e.toString());
				mav.addObject("msg","저장에 실패했습니다 유효한 값을 입력해 주세요");
				return mav;
			}
			mav.addObject("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	

	//############################수동청구서######################################
	
	
	//수동청구서 목록
	@RequestMapping(value= "/client/charge/billList.ajax")
	public @ResponseBody ModelAndView billList(
			@ModelAttribute("billVO") BillVo thvo,
			HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		
		ModelAndView mav = new ModelAndView("jsonView");
		List<BillVo> mnList= null;
		try {
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			mnList = billService.manualList(thvo);
			mav.addObject("data", mnList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	//수동청구서 등록 페이지
	@RequestMapping(value= "/client/charge/billInsert.do")
	public @ResponseBody ModelAndView billInsert(
			@ModelAttribute("billVO") BillVo thvo,
			HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.수동청구서 등록화면!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView(url);
		List<CompanyVo> companyList = new ArrayList<>();
		try {
			FileVo fvo = new FileVo();
			fvo=billService.firstFile();
			mav.addObject("file", fvo);
			companyList=companyService.selectCompanyList(new CompanyVo());
			mav.addObject("companyList", companyList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	//등록 저장
	@RequestMapping(value= "/client/charge/insertBill.ajax")
	public ModelAndView insertReq(
			@ModelAttribute("BillVo") BillVo inputVo
			,@RequestParam("multiFile") List<MultipartFile> multiFileList
			,HttpServletRequest request) throws Exception{
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			//작성자는 로그인 사용자로
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			inputVo.setUSER_ID(nlVo.getUSER_ID());
			//id 생성
			inputVo.setBILL_FILE_ID(billService.createMnId(inputVo));
			inputVo.setBILL_ID(inputVo.getBILL_FILE_ID());
			/*파일 업로드 관련*/
				//화면에 따른 변경부분
				//경로,원본id
			 	//String firstPath="C:\\";
				String firstPath="/usr/local/tomcat/share_data/";
				String inputPath = "resources/billManual/" +inputVo.getBILL_FILE_ID()+ "/";
				String oriId = inputVo.getBILL_FILE_ID();
				/*공통 적용 부분*/
				FileVo fvo = new FileVo();
				fvo.setFILE_DIR(inputPath);
				fvo.setFILE_ORIGIN(oriId);
				
				FileVo orifileVo=billService.firstFile();
				
				File file = new File(firstPath+inputPath+orifileVo.getFILE_NAME());
				File orifile = new File(firstPath+"resources"+orifileVo.getFILE_DIR()+orifileVo.getFILE_NAME());
				
				file.getParentFile().mkdirs();// 파일 상부의 모든 존재하지 않는 경로 생성
				
				//파일을 멀티파일로
				
				DiskFileItem fileItem = new DiskFileItem("file", Files.probeContentType(file.toPath()), false, file.getName(), (int) file.length() , file.getParentFile());    		       
				InputStream input = new FileInputStream(orifile);
				OutputStream os = fileItem.getOutputStream();
				IOUtils.copy(input, os);    		        
				MultipartFile multipartFile = new CommonsMultipartFile(fileItem);
				//멀티파일을 서버에 저장
				multipartFile.transferTo(file);
				
				fvo.setFILE_NAME(orifileVo.getFILE_NAME());
				fvo.setFILE_ID(UUID.randomUUID().toString());
				List<FileVo> fileList = new ArrayList<>();
				fileList.add(fvo);
				// db 작업 실행
				fileService.insertFile(fileList);
				
			int cnt=billService.manualInsert(inputVo);
			mav.addObject("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","저장에 실패하였습니다");
		}
		return mav;
		
	}
	
}
