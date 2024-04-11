package kr.co.hivesys.main.web;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.hivesys.comm.SessionListener;
import kr.co.hivesys.comm.file.service.FileService;
import kr.co.hivesys.comm.file.vo.FileVo;
import kr.co.hivesys.main.service.MainService;
import kr.co.hivesys.user.service.UserService;
import kr.co.hivesys.user.vo.UserVO;


@Controller
public class MainController {

	public static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	public String url="";
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="fileService")
	private FileService fileService;
	
	//jsp include 시 포함하는 페이지 주소를 보내므로
	//* 을 사용했을때 ex: /cmn/top.do 의 주소를 못 가져오고
	//메인 페이지의 주소를 가져오는 것으로 추정
	// 따라서 직접 주소 명시
	@RequestMapping(value = "/cmn/client/authChk.do")
	public String authChk(HttpSession httpSession, HttpServletRequest request,Model model) {
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		logger.debug("▶▶▶▶▶▶▶.보내려는 url : "+url);
		return "/cmn/client/authChk";
	}
	@RequestMapping(value = "/cmn/client/top.do")
	public String clientTop(HttpSession httpSession, HttpServletRequest request,Model model) {
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		logger.debug("▶▶▶▶▶▶▶.보내려는 url : "+url);
		return "/cmn/client/top";
	}
	@RequestMapping(value = "/cmn/client/header.do")
	public String clientHeader(HttpSession httpSession, HttpServletRequest request,Model model) {
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		logger.debug("▶▶▶▶▶▶▶.보내려는 url : "+url);
		return "/cmn/client/header";
	}
	@RequestMapping(value = "/cmn/client/menu.do")
	public String clientMenu(HttpSession httpSession, HttpServletRequest request,Model model) {
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		logger.debug("▶▶▶▶▶▶▶.보내려는 url : "+url);
		return "/cmn/client/menu";
	}
	
	@RequestMapping("/download.ajax")
	private ModelAndView download(String FILE_ID, ModelAndView mView) {
		FileVo fvo = new FileVo();
		fvo.setFILE_ID(FILE_ID);
		fvo=fileService.selectFileList(fvo).get(0);
		String filePath = fvo.getFILE_DIR()+fvo.getFILE_NAME();
		fvo.setFilePath(filePath);
		mView.addObject("fvo", fvo);
		// 응답을 할 bean의 이름 설정
		mView.setViewName("fileDownView");
		return mView;
	}
}