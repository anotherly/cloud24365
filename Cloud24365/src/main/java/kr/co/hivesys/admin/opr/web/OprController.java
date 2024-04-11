package kr.co.hivesys.admin.opr.web;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import kr.co.hivesys.admin.edit.service.EditService;
import kr.co.hivesys.admin.opr.service.OprService;
import kr.co.hivesys.company.service.CompanyService;
import kr.co.hivesys.company.vo.CompanyVo;
import kr.co.hivesys.user.vo.UserVO;


@Controller
public class OprController {

	public static final Logger logger = LoggerFactory.getLogger(OprController.class);
	
	/*@Resource(name="oprService")
	private OprService oprService;
	public String url="";
	
	@Resource(name="companyService")
	private CompanyService companyService;
	
	//주소에 맞게 매핑
	@RequestMapping(value= "/admin/opr/**.do")	
	public String urlMapping(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.main 최초 컨트롤러 진입 httpSession : "+httpSession);
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		logger.debug("▶▶▶▶▶▶▶.보내려는 url : "+url);
		return url;
	}
	
	//주소에 맞게 매핑
	@RequestMapping(value= "/admin/opr/oprList.do")
	public ModelAndView oprList(HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.운영정보 조회 목록!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		CompanyVo newVo = new CompanyVo();
		//url로 h,g 판별하여 해당하는 값만 조회
		ModelAndView mav = new ModelAndView(url);
		List<CompanyVo> sList= null;
		try {
			// 현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			
			sList = companyService.selectCompanyList(newVo);
			mav.addObject("cmsVo", sList.get(0));
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}*/
}
