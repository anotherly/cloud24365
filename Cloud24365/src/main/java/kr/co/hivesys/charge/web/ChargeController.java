package kr.co.hivesys.charge.web;

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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import kr.co.hivesys.comm.excel.ExcelComport;
import kr.co.hivesys.comm.file.FileUploadSave;
import kr.co.hivesys.comm.file.service.FileService;
import kr.co.hivesys.company.service.CompanyService;
import kr.co.hivesys.company.vo.CompanyVo;
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
}
