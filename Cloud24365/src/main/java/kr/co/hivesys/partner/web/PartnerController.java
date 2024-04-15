package kr.co.hivesys.partner.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import kr.co.hivesys.partner.service.PartnerService;
import kr.co.hivesys.partner.vo.PartnerVo;
import kr.co.hivesys.comm.file.FileUploadSave;
import kr.co.hivesys.comm.file.service.FileService;
import kr.co.hivesys.comm.file.vo.FileVo;


@Controller
public class PartnerController{

	public static final Logger logger = LoggerFactory.getLogger(PartnerController.class);
	
	@Resource(name="partnerService")
	private PartnerService partnerService;
	
	@Resource(name="fileService")
	private FileService fileService;
	
	@Resource(name="fileLogic")
	private FileUploadSave fus;
	
	public String url="";
	
	List<PartnerVo> sList=  new ArrayList<>();
	
	//문의하기 목록 조회
	@RequestMapping(value="/client/edit/partnerList.ajax")
	public @ResponseBody ModelAndView reqList( 
			HttpServletRequest request
			//,@RequestParam(required=false, value="idArr[]")List<String> listArr
			,@ModelAttribute("PartnerVo") PartnerVo inputVo) throws Exception{
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			sList = partnerService.selectList(inputVo);
			mav.addObject("data", sList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	//등록 저장
	@RequestMapping(value= "/client/edit/insertPartner.ajax")
	public ModelAndView insertReq(HttpSession httpSession, 
			HttpServletRequest request,Model model
			,@ModelAttribute("PartnerVo") PartnerVo inputVo
			,@RequestParam("multiFile") List<MultipartFile> multiFileList
			) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			//id 생성
			inputVo.setPARTNER_ID(partnerService.createId(inputVo));
			
			//파일 업로드 관련
			if(multiFileList.size()!=0) {
				//화면에 따른 변경부분
				//경로,원본id
				String inputPath = "resources/partner/" +inputVo.getPARTNER_ID()+ "/";
				String oriId = inputVo.getPARTNER_ID();
				//공통 적용 부분
				FileVo fvo = new FileVo();
				fvo.setFILE_DIR(inputPath);
				fvo.setFILE_ORIGIN(oriId);
				fus.fileUploadMultiple(multiFileList,fvo);
			}
			
			int cnt=partnerService.insert(inputVo);
			mav.addObject("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","저장에 실패하였습니다");
		}
		return mav;
	}
	// 상세,수정 페이지 진입
	@RequestMapping(value={"/client/edit/partnerDetail.do","/client/edit/partnerUpdate.do"})
	public @ResponseBody ModelAndView detail( @ModelAttribute("PartnerVo") PartnerVo thvo,HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 조회 목록!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		
		ModelAndView mav = new ModelAndView("jsonView");
		PartnerVo inputVo= null;
		try {
			inputVo = partnerService.selectOne(thvo);
			logger.debug("▶▶▶▶▶▶▶.결과값들:"+inputVo);
			mav.addObject("data", inputVo);
			mav.setViewName(url);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	// 수정 반영
	@RequestMapping(value="/client/edit/partnerUpdate.ajax")
	public @ResponseBody ModelAndView update( 
			@ModelAttribute("PartnerVo") PartnerVo inputVo
			,@RequestParam("multiFile") List<MultipartFile> multiFileList
			,HttpServletRequest request) throws Exception{
		
		logger.debug("▶▶▶▶▶▶▶.회원정보 수정!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			//파일 업로드 관련
			if(multiFileList.size()!=0) {
				//화면에 따른 변경부분
				//경로,원본id
				String inputPath = "resources/partner/" +inputVo.getPARTNER_ID()+ "/";
				String oriId = inputVo.getPARTNER_ID();
				//공통 적용 부분
				FileVo fvo = new FileVo();
				fvo.setFILE_DIR(inputPath);
				fvo.setFILE_ORIGIN(oriId);
				fus.fileUploadMultiple(multiFileList,fvo);
			}
			int cnt=partnerService.update(inputVo);
			mav.addObject("cnt", cnt);
		} catch (Exception e) {
			e.printStackTrace();
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","에러가 발생하였습니다");
		}
		return mav;
	}
	
	// 삭제
	@RequestMapping(value="/client/edit/partnerDelete.do")
	public @ResponseBody ModelAndView delete( @ModelAttribute("PartnerVo") PartnerVo inputVo, HttpServletRequest request) throws Exception{
		logger.debug("▶▶▶▶▶▶▶.회원정보 삭제!!!!!!!!!!!!!!!!");
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			//부모 키에 따른 파일 일괄삭제 관련
			//-> 그런데 이 부분은 단일파일이라 로직을 조금 다르게 구성해야함
			//파라미터를 체크박스로 받아와서 여러개 삭제가 아니기 때문
			List<FileVo> fileList = new ArrayList<>();
			//경로,원본id
			String inputPath = "resources/partner/" +inputVo.getPARTNER_ID()+ "/";
			String oriId = inputVo.getPARTNER_ID();
			//공통 적용 부분
			FileVo fvo = new FileVo();
			fvo.setFILE_DIR(inputPath);
			fvo.setFILE_ORIGIN(oriId);
			fileList.add(fvo);
			fus.folderDelete(fileList);
			//원본 글 삭제
			partnerService.delete(inputVo);
			
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("msg","에러가 발생하였습니다");
		}
		return mav;
	}
	
}
