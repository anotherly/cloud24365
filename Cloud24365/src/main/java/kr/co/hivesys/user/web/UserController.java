package kr.co.hivesys.user.web;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
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

/**
 * 사용자 컨트롤러 클래스
 * @author 솔루션사업팀 정다빈
 * @since 2021.07.23
 * @version 1.0
 * @see
 *
 * << 개정이력(Modification Information) >>
 *
 *   수정일            수정자              수정내용
 *  -------    -------- ---------------------------
 *  2021.07.23  정다빈           최초 생성
 */

@Controller
public class UserController {
	
	public static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="authService")
	private AuthService authService;
	
	@Resource(name="companyService")
	private CompanyService companyService;
	
	public String url="";

	public boolean isClose = false;
	

	//권한조회 후 최초 주소
	@RequestMapping(value= "/client/setting/user.do")
	public String firstAuth(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		return "redirect:/admin/client/auth/authList.do";
	}
	
	//주소에 맞게 매핑
	@RequestMapping(value= "/client/setting/**/*.do")
	public String urlMapping(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.main 최초 컨트롤러 진입 httpSession : "+httpSession);
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		logger.debug("▶▶▶▶▶▶▶.보내려는 url : "+url);
		return url;
	}
	/////////////////////
	
	//사용자 목록 조회
	@RequestMapping(value="/client/setting/user/userList.ajax")
	public @ResponseBody ModelAndView userList( @ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		
		UserVO uvo = new UserVO();
		//url로 h,g 판별하여 해당하는 값만 조회
		ModelAndView mav = new ModelAndView("jsonView");
		List<UserVO> userList= null;
		try {
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			//사용자관리에서 검색하지 않는다면 로그인 시 받은 parameter 사용
			if(userVO.getSearchValue()!=null) {
				uvo=userVO;
			}
			uvo.setCOMPANY_ID(nlVo.getCOMPANY_ID());			
			userList = userService.selectUserList(uvo);
			mav.addObject("data", userList);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	//사용자 등록 화면
	@RequestMapping(value="/client/setting/user/userInsert.do")
	public @ResponseBody ModelAndView userInsert ( @ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		//url로 h,g 판별하여 해당하는 값만 조회
		ModelAndView mav = new ModelAndView(url);
		try {
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			//사용자관리에서 검색하지 않는다면 로그인 시 받은 parameter 사용
			List<AuthVo> authList= new ArrayList<>();
			AuthVo avo = new AuthVo();
			authList = authService.selectAuthType(avo);
			mav.addObject("authList", authList);
			
			//고객사 셀렉트박스
			List<CompanyVo> companyList= new ArrayList<>();
			CompanyVo cvo = new CompanyVo();
			companyList = companyService.selectCompanyList(cvo);
			mav.addObject("companyList", companyList);
			
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	

	//검색한 id 조회
	@RequestMapping(value="/user/findUserId.do")
	public @ResponseBody ModelAndView findUserId( @ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		UserVO disUser= null;
		try {
			disUser = userService.selectUser(userVO);
			mav.addObject("data", disUser.getUSER_ID());
		} catch (Exception e) {
			logger.debug(""+e);
			mav.addObject("msg","search_not");
		}
		return mav;
	}
	
	//사용자 등록 로직
	@RequestMapping(value="/user/insertUser.ajax", method=RequestMethod.POST)
	public ModelAndView insertUser(HttpServletRequest request, @ModelAttribute UserVO userVO, RedirectAttributes redirectAttributes) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.request.getRequestURL() : "+request.getRequestURL());
		logger.debug("▶▶▶▶▶▶▶.request.getRequestURI() : "+request.getRequestURI());
		logger.debug("▶▶▶▶▶▶▶.request.getContextPath() : "+request.getContextPath());
		ModelAndView mav = new ModelAndView("jsonView");
		int cnt = 0;
		try {
			String authUrl = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
			//패스워드 암호화 처리
			logger.debug("변환전 uservo: "+userVO.toString());
			String hashedPw = BCrypt.hashpw(userVO.getUSER_PW(), BCrypt.gensalt());
			userVO.setUSER_PW(hashedPw);
			logger.debug("변환후 uservo: "+userVO.toString());
			userService.insertUser(userVO);
			cnt=1;
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		mav.addObject("cnt", cnt);
		return mav;
	}
	
	//사용자 상세 조회
	@RequestMapping(value= {"/client/setting/user/userDetail.do"})
	public @ResponseBody ModelAndView userDetail( @ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		UserVO disUser= null;
		try {
			if(url.contains("account")) {
				userVO= (UserVO) request.getSession().getAttribute("login");
			}
			disUser = userService.selectUser(userVO);
			logger.debug("▶▶▶▶▶▶▶.시험코드 결과값들:"+disUser);
			
			mav.addObject("data", disUser);
			mav.setViewName(url);
		} catch (Exception e) {
			logger.debug(""+e);
			mav.addObject("msg","에러가 발생했습니다.");
		}
		return mav;
	}
	
	//검색한 id 조회
	@RequestMapping(value="/admin/auth/findUSER_ID.do")
	public @ResponseBody ModelAndView findUSER_ID( @ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		UserVO disUser= null;
		try {
			disUser = userService.selectUser(userVO);
			mav.addObject("data", disUser.getUSER_ID());
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","search_not");
		}
		return mav;
	}

	//사용자 수정 페이지 진입
	@RequestMapping(value="/client/setting/user/userUpdate.do")
	public @ResponseBody ModelAndView userUpdate( @ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		UserVO disUser= null;
		try {
			disUser = userService.selectUser(userVO);
			logger.debug("▶▶▶▶▶▶▶.시험코드 결과값들:"+disUser);
			//권한등급 셀렉트박스
			List<AuthVo> authList= new ArrayList<>();
			AuthVo avo = new AuthVo();
			authList = authService.selectAuthType(avo);
			mav.addObject("authList", authList);
			
			//고객사 셀렉트박스
			List<CompanyVo> companyList= new ArrayList<>();
			CompanyVo cvo = new CompanyVo();
			companyList = companyService.selectCompanyList(cvo);
			mav.addObject("companyList", companyList);
			
			mav.addObject("data", disUser);
			mav.setViewName(url);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	//사용자 수정 반영
	@RequestMapping(value="/user/userUpdate.ajax")
	public @ResponseBody ModelAndView userUpdateForm( @ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 수정!!!!!!!!!!!!!!!!");
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		//비밀번호 암호화
		if(!(userVO.getUSER_PW().equals(""))&&!(userVO.getUSER_PW()==null)) {
			String hashedPw = BCrypt.hashpw(userVO.getUSER_PW(), BCrypt.gensalt());
			userVO.setUSER_PW(hashedPw);
		}
		
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			userService.updateUser(userVO);
			
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","에러가 발생하였습니다");
		}
		return mav;
	}
	
	//사용자 삭제
	@RequestMapping(value="/client/setting/user/userDelete.do")
	public @ResponseBody ModelAndView userDelete( @RequestParam(value="idArr[]")List<String> userArr,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 삭제!!!!!!!!!!!!!!!!");
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			userService.deleteUser(userArr);
			
		} catch (Exception e) {
			mav.addObject("msg","에러가 발생하였습니다");
		}
		return mav;
	}
	
}
