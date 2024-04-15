package kr.co.hivesys.comm;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import kr.co.hivesys.admin.auth.service.AuthService;
import kr.co.hivesys.admin.auth.vo.AuthVo;

import kr.co.hivesys.user.vo.UserVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AuthInterceptor extends HandlerInterceptorAdapter {

	public static final Logger logger = LoggerFactory.getLogger(AuthInterceptor.class);

	@Resource(name = "authService")
	private AuthService authService;

	/**
	 * 컨트롤러 수행전에 세션 정보가 있는지 확인하는 처리..
	 * 
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.debug("☎☎☎☎☎☎☎☎☎☎☎☎☎☎☎☎.AUTH -  프리핸들 request : " + request);
		logger.debug("☎☎☎☎☎☎☎☎☎☎☎☎☎☎☎☎.AUTH -  프리핸들 request.getSession() : " + request.getSession());
		logger.debug(request.getRequestURL().toString());
		String furl = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		boolean rtn = false;//최종 t/f 리턴값
		boolean ynUrl = false; // 권한관리 체크에 포함된 url인지 아닌지
		// 새로고침이나 유효하지 않은 요청 제외하고는 권한체크
		if (request.getSession().getAttribute("login") != null) {
			logger.debug("☎☎☎☎☎☎☎☎☎☎☎☎☎☎☎☎.   request.getSession().getAttribute(login) : " + request.getSession().getAttribute("login"));
			String nowUrl = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
			String[] urlList = nowUrl.split("/", 11);
			nowUrl="";
			for (int i = 1; i < urlList.length-1; i++) {
				nowUrl += "/"+urlList[i];
			}
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO reqLoginVo = (UserVO) request.getSession().getAttribute("login");
			AuthVo avo = new AuthVo();
			avo.setAuthCode(reqLoginVo.getAUTH_CODE());
			avo.setUrl(nowUrl);
			//최초 페이지 진입 시 분기처리(관리자만)
			List<AuthVo> alist = new ArrayList<>();
			
			String smallFurl = furl.toLowerCase();
			
			if(furl.equals("/main/main")) {
				avo.setCdFlag("1");
				alist = authService.selectAuthUrl(avo);
				response.sendRedirect(request.getContextPath()+alist.get(0).getUrl()+".do");
				
			}else if(//등록,수정,삭제의 경우
					smallFurl.contains("insert")
				  ||smallFurl.contains("update")
				  ||smallFurl.contains("delete")
				  ||smallFurl.contains("manual")
			){
				avo.setCdFlag("2");
				alist = authService.selectAuthUrl(avo);

				if (alist.size() == 0) {
					// 현재 선택한 메뉴의 권한여부가 n일 경우
					logger.debug("♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨권한이 없음");
					response.sendRedirect(request.getContextPath()+"/cmn/client/authChk.do");
					rtn =false;
					return false;
				} else {
					rtn = true;
				}
				
			}else {
				alist = authService.selectAuthUrl(avo);
				if (alist.size() == 0) {
					// 현재 선택한 메뉴의 권한여부가 n일 경우
					logger.debug("♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨권한이 없음");
					response.sendRedirect(request.getContextPath()+"/cmn/client/authChk.do");
					rtn =false;
					return false;
				} else {
					rtn = true;
				}
			}
			
		} else {
			logger.debug("♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨세션 값이 존재하지 않음");
			response.sendRedirect(request.getContextPath()+"/login/loginPost.do");
			rtn =false;
			return false;
		}
		return rtn;
	}

	/**
	 * 세션에 메뉴권한(SessionVO)이 있는지 여부로 메뉴권한 여부를 체크한다. 계정정보(SessionVO)가 없다면, 로그인 페이지로
	 * 이동한다.
	 */
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.debug("♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨♨.AUTH - postHandle 메소드 진입 : ");
	}

	/**
	 * 
	 */
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		logger.info("★★★★★★★★★★★★★★★★★.Interceptor: afterCompletion");
		super.afterCompletion(request, response, handler, ex);
	}

} // end class