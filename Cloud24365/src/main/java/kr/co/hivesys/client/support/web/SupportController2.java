package kr.co.hivesys.client.support.web;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.hivesys.client.support.service.SupportService;
import kr.co.hivesys.comm.file.FileUploadSave;
import kr.co.hivesys.comm.file.service.FileService;
import kr.co.hivesys.comm.file.vo.FileVo;
import kr.co.hivesys.company.vo.CompanyVo;
import kr.co.hivesys.board.service.FaqService;
import kr.co.hivesys.board.service.NoticeService;
import kr.co.hivesys.board.service.QnaService;
import kr.co.hivesys.board.vo.FaqVo;
import kr.co.hivesys.board.vo.NoticeVo;
import kr.co.hivesys.board.vo.QnaVo;
import kr.co.hivesys.user.service.UserService;
import kr.co.hivesys.user.vo.UserVO;




@Controller
public class SupportController2 {

	/*public static final Logger logger = LoggerFactory.getLogger(SupportController2.class);
	
	@Resource(name="noticeService")
	private NoticeService noticeService;
	
	@Resource(name="userService")
	private UserService userService;
	
	@Resource(name="faqService")
	private FaqService faqService;
	
	@Resource(name="qnaService")
	private QnaService qnaService;
	
	@Resource(name="fileService")
	private FileService fileService;
	
	public String url="";
	
	@Resource(name="fileLogic")
	private FileUploadSave fus;
	
	//주소에 맞게 매핑
	@RequestMapping(value= "/client/support/**.do")
	public String urlMapping(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.main 최초 컨트롤러 진입 httpSession : "+httpSession);
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		logger.debug("▶▶▶▶▶▶▶.보내려는 url : "+url);
		return url;
	}
	//공지사항
	//문의하기 목록 조회
	@RequestMapping(value="/client/support/noticeList.ajax")
	public @ResponseBody ModelAndView reqList( 
			HttpServletRequest request
			//,@RequestParam(required=false, value="idArr[]")List<String> listArr
			,@ModelAttribute("noticeVo") NoticeVo inputVo
		) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		List<NoticeVo> sList=  new ArrayList<>();
		try {
			sList = noticeService.selectList(inputVo);
			mav.addObject("data", sList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	// 상세,수정 페이지 진입
	@RequestMapping(value={"/client/support/noticeDetail.do","/client/support/noticeUpdate.do"})
	public @ResponseBody ModelAndView detail( @ModelAttribute("NoticeVo") NoticeVo thvo,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		NoticeVo inputVo= null;
		List<FileVo> fileList= null;
		FileVo fvo = new FileVo();
		try {
			inputVo = noticeService.selectOne(thvo);
			logger.debug("▶▶▶▶▶▶▶.결과값들:"+inputVo);
			
			fvo.setFILE_ORIGIN(inputVo.getNOTICE_ID());
			fileList=fileService.selectFileList(fvo);
			
			mav.addObject("data", inputVo);
			mav.addObject("fileList", fileList);
			mav.setViewName(url);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	//FAQ
	// 목록 조회
	@RequestMapping(value="/client/support/faqList.ajax")
	public @ResponseBody ModelAndView reqList( 
			HttpServletRequest request
			//,@RequestParam(required=false, value="idArr[]")List<String> listArr
			,@ModelAttribute("FaqVo") FaqVo inputVo) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			List<FaqVo> sList=  new ArrayList<>();
			sList = faqService.selectList(inputVo);
			mav.addObject("data", sList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	// 상세,수정 페이지 진입
	@RequestMapping(value={"/client/support/faqDetail.do","/client/support/faqUpdate.do"})
	public @ResponseBody ModelAndView detail( @ModelAttribute("FaqVo") FaqVo thvo,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		FaqVo inputVo= null;
		try {
			inputVo = faqService.selectOne(thvo);
			logger.debug("▶▶▶▶▶▶▶.결과값들:"+inputVo);
			mav.addObject("data", inputVo);
			mav.setViewName(url);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	//나의문의 조회
	@RequestMapping(value="/client/support/reqList.ajax")
	public @ResponseBody ModelAndView reqList( 
			HttpServletRequest request
			//@RequestParam(required=false, value="idArr[]")List<String> listArr
			,@ModelAttribute("qnaVo") QnaVo inputVo) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			List<QnaVo> sList=  new ArrayList<>();
			sList = qnaService.selectReqList(inputVo);
			mav.addObject("data", sList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	//문의하기
	@RequestMapping(value="/client/support/reqInsert.ajax")
	public ModelAndView reqInsert(
			HttpSession httpSession, Model model
			,@RequestParam("multiFile") List<MultipartFile> multiFileList
			, HttpServletRequest request, HttpServletResponse response
			,@ModelAttribute("qnaVo") QnaVo inputVo
			,@RequestParam(required=false, value="fileChg") String fileChg
			,@RequestParam(required=false, value="createFileError") String createFileError
			) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		//현재 세션에 대해 로그인한 사용자 정보를 가져옴
		UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
		
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			inputVo.setREQ_QUESTION(inputVo.getREQ_QUESTION().replace("\r\n","<br>"));
			inputVo.setCOMPANY_ID(nlVo.getCOMPANY_ID());
			inputVo.setREQ_ID(qnaService.creReqId(inputVo));
			inputVo.setINSERT_TYPE("0");
			
			파일 업로드 관련
			if(multiFileList.size()!=0) {
				//화면에 따른 변경부분
				//경로,원본id
				String inputPath = "resources/support/" +inputVo.getREQ_ID()+ "/";
				String oriId = inputVo.getREQ_ID();
				공통 적용 부분
				FileVo fvo = new FileVo();
				fvo.setFILE_DIR(inputPath);
				fvo.setFILE_ORIGIN(oriId);
				fus.fileUploadMultiple(multiFileList,fvo);
			}
			
			int cnt =qnaService.insertReq(inputVo);
			mav.addObject("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","저장에 실패하였습니다");
		}
		return mav;
	}
	
	//사용자 목록에 답변하기(상셰)
	@RequestMapping(value="/client/support/reqDetail.do")
	public @ResponseBody ModelAndView reqDetail( 
	HttpServletRequest request, HttpServletResponse response
	,@ModelAttribute("qnaVo") QnaVo inputVo
	) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		QnaVo reqVo= null;
		List<UserVO> userList= null;
		List<FileVo> fileList= null;
		FileVo fvo= new FileVo();
		try {
			reqVo = qnaService.selectReqOne(inputVo);
			userList = userService.selectAdmin();
			fvo.setFILE_ORIGIN(inputVo.getREQ_ID());
			fileList=fileService.selectFileList(fvo);
			reqVo.setREQ_QUESTION(reqVo.getREQ_QUESTION().replace("<br>","\r\n"));
			
			mav.addObject("reqVo", reqVo);
			mav.addObject("userList", userList);
			mav.addObject("fileList", fileList);
			mav.setViewName(url);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(""+e);
			mav.addObject("msg","에러가 발생했습니다.");
		}
		return mav;
	}
	//사용자 목록에 답변 후 저장
	@RequestMapping(value="/client/support/reqUpdate.ajax")
	public @ResponseBody ModelAndView reqUpdate(
			@RequestParam("multiFile") List<MultipartFile> multiFileList
			, HttpServletRequest request, HttpServletResponse response
			,@ModelAttribute("qnaVo") QnaVo inputVo
			) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		QnaVo thvo= null;
		try {
			
			//현재 세션에 대해 로그인한 사용자 정보를 가져옴
			UserVO nlVo = (UserVO) request.getSession().getAttribute("login");
			inputVo.setUSER_ID(nlVo.getUSER_ID());
			
			inputVo.setREQ_ANSWER(inputVo.getREQ_ANSWER().replace("\r\n","<br>"));
			inputVo.setANS_ID(qnaService.creAnsId(inputVo));
			inputVo.setREQ_STATUS("2");
			파일 업로드 관련
			if(multiFileList.size()!=0) {
				//화면에 따른 변경부분
				//경로,원본id
				String inputPath = "resources/support/" +inputVo.getANS_ID()+ "/";
				String oriId = inputVo.getANS_ID();
				공통 적용 부분
				FileVo fvo = new FileVo();
				fvo.setFILE_DIR(inputPath);
				fvo.setFILE_ORIGIN(oriId);
				fus.fileUploadMultiple(multiFileList,fvo);
			}
			
			qnaService.reqUpdate(inputVo);
			int cnt =qnaService.ansInsert(inputVo);
			mav.addObject("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug(""+e);
			mav.addObject("msg","에러가 발생했습니다.");
		}
		return mav;
	}
	//답변+파일리스트 가져오기
	@RequestMapping(value="/client/support/ansHistoryList.ajax")
	public @ResponseBody ModelAndView ansHistoryList( 
			HttpServletRequest request
			,@ModelAttribute("qnaVo") QnaVo inputVo) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			List<QnaVo> ansList = qnaService.selectAnsList(inputVo);
			//개행 처리 ㅡㅡ
			for (int i = 0; i < ansList.size(); i++) {
				QnaVo upvo = new QnaVo(); 
				upvo = ansList.get(i);
				upvo.setREQ_ANSWER(upvo.getREQ_ANSWER().replace("<br>","\r\n"));
				ansList.set(i, upvo);
			}
			//inputVo.setFILE_ORIGIN(inputVo.getANS_ID());
			List<FileVo> fileList = qnaService.ansFileList(inputVo);
			
			mav.addObject("ansList", ansList);
			mav.addObject("fileList", fileList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}*/
	
}
