package kr.co.hivesys.client.svrInfo.web;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.hivesys.admin.edit.service.EditService;
import kr.co.hivesys.admin.edit.vo.EditVo;
import kr.co.hivesys.client.svrInfo.service.SvcService;
import kr.co.hivesys.company.vo.CompanyVo;



@Controller
public class SvcController {

	public static final Logger logger = LoggerFactory.getLogger(SvcController.class);
	
	@Resource(name="svcService")
	private SvcService svcService;
	public String url="";
	@Resource(name="editService")
	private EditService editService;
	
	//주소에 맞게 매핑
	@RequestMapping(value= "/client/svcInfo/**.do")
	public String urlMapping(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.main 최초 컨트롤러 진입 httpSession : "+httpSession);
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		logger.debug("▶▶▶▶▶▶▶.보내려는 url : "+url);
		return url;
	}
	
	//사용자 상세 조회
	@RequestMapping(value={"/client/svcInfo/termOfUse.do","/client/svcInfo/privacy.do"})
	public @ResponseBody ModelAndView termOfUse( @ModelAttribute("editVo") EditVo thvo,HttpServletRequest request) throws Exception{
		
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		EditVo inputVo= null;
		try {
			
			if (url.contains("privacySvc")) {
				thvo.setDOCUMENT_DIV("1");
			} else {
				thvo.setDOCUMENT_DIV("0");
			}
			
			inputVo = editService.selectTou(thvo);
			logger.debug("▶▶▶▶▶▶▶.시험코드 결과값들:"+inputVo);
			inputVo.setTEXT_VAL(inputVo.getTEXT_VAL().replace("<br>","\r\n"));
			mav.addObject("data", inputVo);
			mav.setViewName(url);
		} catch (Exception e) {
			logger.debug(""+e);
			mav.addObject("msg","에러가 발생했습니다.");
		}
		return mav;
	}
	
}
