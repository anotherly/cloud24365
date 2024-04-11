package kr.co.hivesys.admin.auth.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.hivesys.admin.auth.service.AuthService;
import kr.co.hivesys.admin.auth.vo.AuthVo;
import kr.co.hivesys.company.service.CompanyService;
import kr.co.hivesys.company.vo.CompanyVo;
import kr.co.hivesys.user.service.UserService;
import kr.co.hivesys.user.vo.UserVO;


@Controller
public class AuthController {

	public static final Logger logger = LoggerFactory.getLogger(AuthController.class);
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="authService")
	private AuthService authService;
	
	@Resource(name="companyService")
	private CompanyService companyService;
	
	public String url="";
	
	//권한조회 후 최초 주소
	@RequestMapping(value= "/admin/auth/auth.do")
	public String firstAuth(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		return "/admin/client/auth/authList.do";
	}
	
	//주소에 맞게 매핑
	@RequestMapping(value= "/admin/auth/auth/**.do")
	public String urlMapping(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.main 최초 컨트롤러 진입 httpSession : "+httpSession);
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		logger.debug("▶▶▶▶▶▶▶.보내려는 url : "+url);
		return url;
	}
	
	@RequestMapping(value="/admin/auth/auth/authList.do")
	public @ResponseBody ModelAndView selectAuth1(HttpServletRequest request
			,Model model, @ModelAttribute AuthVo inputVo) throws Exception {
		logger.debug("▶▶▶▶▶▶▶.setting 최초 컨트롤러 진입 httpSession : "+request.getSession());
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mv = new ModelAndView("jsonView");
		List<AuthVo> thlist = new ArrayList<AuthVo>();
		AuthVo thvo = new AuthVo();
		thlist = authService.selectAuth1(thvo);
		mv.addObject("authList", thlist);
		mv.addObject("msg", "메시지테스트");
		mv.setViewName(url);
		return mv;
	}
	

	@RequestMapping(value="/admin/auth/auth/authList.ajax")
	public @ResponseBody ModelAndView selectAuthList(HttpServletRequest request
			,Model model, @ModelAttribute AuthVo inputVo) throws Exception {
		logger.debug("▶▶▶▶▶▶▶.setting 최초 컨트롤러 진입 httpSession : "+request.getSession());
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mv = new ModelAndView("jsonView");
		List<AuthVo> thlist = new ArrayList<AuthVo>();
		thlist = authService.selectAuthList(inputVo);
		mv.addObject("data", thlist);
		mv.addObject("msg", "메시지테스트");
		return mv;
	}
	
	
	@RequestMapping(value="/admin/auth/auth/updateAuth.do")
	public @ResponseBody ModelAndView updateAuth(
			HttpServletRequest request,Model model
			,@ModelAttribute AuthVo inputVo
			,@RequestParam(required=false, value="authCode") String authCode
			,@RequestParam(required=false, value="idx") String idx
			) throws Exception {
		logger.debug("★★★★★★★★★★★★★★★★권한 관리 저장★★★★★★★★★★★★★★★★★★★★★");
		ModelAndView mv = new ModelAndView("jsonView");
		List<AuthVo> thlist = new ArrayList<AuthVo>();
		String msg ="";
		int cnt=authService.updateAuth(inputVo.getAtList());
		if(cnt==0) {
			msg="저장에 실패하였습니다.";
		}
		mv.addObject("msg", msg);
		return mv;
	}
}
