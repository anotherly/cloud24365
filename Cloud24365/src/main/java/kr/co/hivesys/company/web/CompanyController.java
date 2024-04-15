package kr.co.hivesys.company.web;


import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kr.co.hivesys.company.service.CompanyService;
import kr.co.hivesys.company.vo.CompanyVo;
import kr.co.hivesys.company.vo.MspVo;
import kr.co.hivesys.user.service.UserService;
import kr.co.hivesys.user.vo.UserVO;




@Controller
public class CompanyController {

	public static final Logger logger = LoggerFactory.getLogger(CompanyController.class);
	
	@Resource(name="companyService")
	private CompanyService companyService;
	
	@Resource(name="userService")
	private UserService userService;
	
	public String url="";
	
	//주소에 맞게 매핑
	@RequestMapping(value= "/client/setting/account/**.do")
	public String urlMapping(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.main 최초 컨트롤러 진입 httpSession : "+httpSession);
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		logger.debug("▶▶▶▶▶▶▶.보내려는 url : "+url);
		return url;
	}
	

	//사용자 상세 조회
	@RequestMapping(value= {"/client/setting/account/actInfo.do","/client/setting/account/companyUpdate.do"})
	public @ResponseBody ModelAndView userDetail( @ModelAttribute("companyVO") CompanyVo thvo,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		CompanyVo inputVo= null;
		MspVo mspvo = new MspVo();
		List<MspVo> mspList = new ArrayList<>();
		try {
			
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			thvo.setCOMPANY_ID(nlVo.getCOMPANY_ID());
			inputVo = companyService.selectCompany(thvo);
			mspvo.setCOMPANY_ID(thvo.getCOMPANY_ID());
			mspList = companyService.selectMspOne(mspvo);
			
			logger.debug("▶▶▶▶▶▶▶.시험코드 결과값들:"+inputVo);
			
			mav.addObject("data", inputVo);
			mav.addObject("mspList", mspList);
			mav.setViewName(url);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(""+e);
			mav.addObject("msg","에러가 발생했습니다.");
		}
		return mav;
	}

	
	//사용자 수정 반영
	@RequestMapping(value="/client/setting/account/saveActInfo.do")
	public @ResponseBody ModelAndView userUpdateForm( @ModelAttribute("companyVO") CompanyVo thvo,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 수정!!!!!!!!!!!!!!!!");
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			try {
				// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
				UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
				nlVo.setINTRO_YN("T");
				userService.updateUser(nlVo);
				if(thvo.getMspList()!=null) {
					companyService.deleteMsp(thvo);
					companyService.subListInsert(thvo.getMspList());
				}
			} catch (Exception e) {
				e.printStackTrace();
				logger.debug("에러메시지 : "+e.toString());
				mav.addObject("msg","동일 클라우드일 경우에는 다른 요금제를 선택해주세요");
				return mav;
			}
			companyService.updateCompany(thvo);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","에러가 발생하였습니다");
		}
		return mav;
	}
	
	//사용자 삭제
	@RequestMapping(value="/client/setting/account/companyDelete.do")
	public @ResponseBody ModelAndView userDelete( @RequestParam(value="idArr[]")List<String> listArr,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 삭제!!!!!!!!!!!!!!!!");
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			//삭제대상이 '0000' 하이브시스템일 경우 삭제 못하도록 방지
			if(listArr.contains("0000")) {
				mav.addObject("msg","해당 고객사('하이브시스템')는 삭제하실수 없습니다");
			}else {
				companyService.deleteCompany(listArr);
			}
		} catch (Exception e) {
			mav.addObject("msg","에러가 발생하였습니다");
		}
		return mav;
	}
}
