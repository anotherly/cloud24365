package kr.co.hivesys.client.setting.web;

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
import kr.co.hivesys.client.setting.service.AcUserService;
import kr.co.hivesys.comm.SessionListener;
import kr.co.hivesys.company.service.CompanyService;
import kr.co.hivesys.company.vo.CompanyVo;
import kr.co.hivesys.user.service.UserService;
import kr.co.hivesys.user.vo.UserVO;




@Controller
public class AcUserController {

	public static final Logger logger = LoggerFactory.getLogger(AcUserController.class);
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="companyService")
	private CompanyService companyService;
	
	@Resource(name="authService")
	private AuthService authService;
	
	public String url="";
	
	//최초 사용자 정보입력여부 파악
	@RequestMapping(value= "/client/setting/account/*.do")
	public String accountUrlMapping(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		return url;
	}
	
	//주소에 맞게 매핑
	@RequestMapping(value= "/client/setting/user/*.do")
	public String userUrlMapping(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		return url;
	}
	
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
			//admin 계정인지 일반 계정인지 판별 필요(url구분 or 화면 파라미터 구분)
			
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
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	//사용자 등록 로직
		@RequestMapping(value="/client/setting/user/insertUser.ajax", method=RequestMethod.POST)
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
		@RequestMapping(value="/client/setting/user/userDetail.do")
		public @ResponseBody ModelAndView userDetail( @ModelAttribute("userVO") UserVO userVO,HttpServletRequest request) throws Exception{
			logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
			
			url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
			
			ModelAndView mav = new ModelAndView("jsonView");
			UserVO disUser= null;
			try {
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
		@RequestMapping(value="/client/setting/user/findUSER_ID.do")
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
		@RequestMapping(value="/client/setting/user/userUpdate.ajax")
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
		
	//내정보 조회
	@RequestMapping(value= "/client/setting/account/actInfo.do")
	public ModelAndView actInfo(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView(url);
		String uid = SessionListener.getInstance().getUserID(httpSession);
		UserVO uvo = new UserVO();
		uvo.setUSER_ID(uid);
		uvo = userService.selectUser(uvo);
		CompanyVo cmsVo= new CompanyVo();
		cmsVo.setCOMPANY_ID(uvo.getCOMPANY_ID());
		cmsVo=companyService.selectCompany(cmsVo);
		mav.addObject("userVo",uvo);
		mav.addObject("cmsVo",cmsVo);
		return mav;
	}
	
	
	//비밀번호 체크 검증 로직
	@RequestMapping(value= "/client/setting/account/chkPw.ajax")
	public ModelAndView chkPw(@ModelAttribute UserVO inputVo,HttpSession httpSession
			,HttpServletRequest request,Model model) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		String msg="";
		UserVO userVo = new UserVO();
		ModelAndView mav = new ModelAndView("jsonView");
		
		try {
			//현재 세션으로 로그인 한 사용자의 id를 받아옴
			String uid = SessionListener.getInstance().getUserID(httpSession);
			inputVo.setUSER_ID(uid);
			userVo = userService.selectUser(inputVo);
			//등록되지 않은 사용자 또는 사용자 입력 오류
			if(userVo ==null || !(BCrypt.checkpw(inputVo.getUSER_PW(), userVo.getUSER_PW()))) {
				logger.debug("▶▶▶▶▶▶▶.기존 비밀번호가 일치하지 않습니다");
				msg="기존 비밀번호가 일치하지 않습니다";
				userVo =null;
			//유효한 계정 및 비밀번호 입력 시	
			}else {
				String hashedPw = BCrypt.hashpw(inputVo.getUSER_PW1(), BCrypt.gensalt());
				userVo.setUSER_PW(hashedPw);
				userService.updateUser(userVo);
			}
		} catch (Exception e) {
			msg="정보를 잘못 입력하셨습니다";
			userVo=null;
			logger.debug("▶▶▶▶▶▶▶.캐치 에러 : "+e.getMessage());
			e.printStackTrace();
		}finally {
			mav.addObject("msg", msg);
		}
		return mav;
	}
	
	//내정보조회 저장 - 해당부분은 회사정보기입 인증때문에 별도 매핑부로 구성
	@RequestMapping(value= "/client/setting/account/saveActInfo.do")
	public ModelAndView saveActInfo(HttpSession httpSession, 
			HttpServletRequest request,Model model
			,@ModelAttribute UserVO inputVo
			,@ModelAttribute CompanyVo cmsVo
			) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			//사용자관리부분이 아닌 user페이지의 내정보 변경을 통해서 수정
			inputVo.setINTRO_YN("T");
			userService.updateUser(inputVo);
			companyService.updateCompany(cmsVo);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","저장에 실패하였습니다");
		}
		return mav;
	}
	
}
