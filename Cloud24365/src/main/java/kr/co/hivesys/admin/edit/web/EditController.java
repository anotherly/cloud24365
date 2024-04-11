package kr.co.hivesys.admin.edit.web;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.activation.CommandMap;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import kr.co.hivesys.admin.edit.service.EditService;
import kr.co.hivesys.admin.edit.vo.EditVo;
import kr.co.hivesys.company.vo.CompanyVo;
import kr.co.hivesys.user.vo.UserVO;


@Controller
public class EditController {

	public static final Logger logger = LoggerFactory.getLogger(EditController.class);
	
	@Resource(name="editService")
	private EditService editService;
	public String url="";
	
	/*//주소에 맞게 매핑
	@RequestMapping(value= "/admin/edit/**.do")
	public String urlMapping(HttpSession httpSession, HttpServletRequest request,Model model
			) throws Exception{
		logger.debug("▶▶▶▶▶▶▶. 최초 컨트롤러 진입 httpSession : "+httpSession);
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		logger.debug("▶▶▶▶▶▶▶.보내려는 url : "+url);
		return url;
	}
	
	//사용자 목록 조회
	@RequestMapping(value={"/admin/edit/touList.ajax","/admin/edit/privacySvcList.ajax"})
	public @ResponseBody ModelAndView touList( @ModelAttribute("editVo") EditVo thvo, HttpServletRequest request) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		//url로 h,g 판별하여 해당하는 값만 조회
		ModelAndView mav = new ModelAndView("jsonView");
		List<EditVo> sList= null;
		try {
			
			if (url.contains("privacySvc")) {
				thvo.setDOCUMENT_DIV("1");
			} else {
				thvo.setDOCUMENT_DIV("0");
			}
			
			sList = editService.selectTouList(thvo);
			mav.addObject("data", sList);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	@RequestMapping(value={"/admin/edit/touInsert.ajax","/admin/edit/privacySvcInsert.ajax"})
    public ModelAndView touInsert( @ModelAttribute("editVo") EditVo thvo, HttpServletRequest request) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
        thvo.setTEXT_VAL(thvo.getTEXT_VAL().replace("\r\n","<br>"));
        try {
			if (url.contains("privacySvc")) {
				thvo.setDOCUMENT_DIV("1");
			} else {
				thvo.setDOCUMENT_DIV("0");
			}
        	
            editService.insertTou(thvo);
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("msg","에러가 발생하였습니다");
		}
        return mav;
    }
	
	@RequestMapping(value={"/admin/edit/touDetail.do","/admin/edit/privacySvcDetail.do"})
	public ModelAndView touDetail( @ModelAttribute("editVo") EditVo thvo, HttpServletRequest request) throws Exception{
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		//url로 h,g 판별하여 해당하는 값만 조회
		ModelAndView mav = new ModelAndView("jsonView");
		List<EditVo> sList= null;
		try {
			
			if (url.contains("privacySvc")) {
				thvo.setDOCUMENT_DIV("1");
			} else {
				thvo.setDOCUMENT_DIV("0");
			}
			
			sList = editService.selectTouList(thvo);
			mav.addObject("data", sList.get(0));
			mav.setViewName(url);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
		return mav;
	}
	
	@RequestMapping(value={"/admin/edit/touDelete.do","/admin/edit/privacySvcDelete.do"})
	public ModelAndView touDelete( @ModelAttribute("editVo") EditVo thvo, HttpServletRequest request) throws Exception{
		//url로 h,g 판별하여 해당하는 값만 조회
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		ModelAndView mav = new ModelAndView("jsonView");
		try {
			
			if (url.contains("privacySvc")) {
				thvo.setDOCUMENT_DIV("1");
			} else {
				thvo.setDOCUMENT_DIV("0");
			}
			
			editService.deleteTou(thvo);
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
			mav.addObject("msg","에러가 발생하였습니다");
		}
		return mav;
	}
	
	@RequestMapping(value= {"/admin/edit/touDownload.ajax","/admin/edit/privacySvcDownload.ajax"})
	public void touDownload( @ModelAttribute("editVo") EditVo thvo,
			Map model, HttpServletRequest request, HttpServletResponse response
			) throws Exception{
		//url로 h,g 판별하여 해당하는 값만 조회
		url = request.getRequestURI().substring(request.getContextPath().length()).split(".do")[0];
		List<EditVo> sList= null;
		String title ="";
		try {
			if (url.contains("privacySvc")) {
				thvo.setDOCUMENT_DIV("1");
				title = "개인정보처리방침 v"+thvo.getDOCUMENT_ID()+".txt";
			} else {
				thvo.setDOCUMENT_DIV("0");
				title = "이용약관 v"+thvo.getDOCUMENT_ID()+".txt";
			}
			
			thvo = editService.selectTouList(thvo).get(0);			
			String str = thvo.getTEXT_VAL();
			
			response.setHeader("Cache-Control", "no-cache");
			
		    byte[] fileByte = str.getBytes();
		    
		    //파일유형설정
	        response.setContentType("application/octet-stream"); 
	        //파일길이설정
	        response.setContentLength(fileByte.length);
	        //데이터형식/성향설정 (attachment: 첨부파일)
	        response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(title,"UTF-8")+"\";");
	        //내용물 인코딩방식설정
	        response.setHeader("Content-Transfer-Encoding", "binary");
	        //버퍼의 출력스트림을 출력
	        response.getOutputStream().write(fileByte);
	        //버퍼에 남아있는 출력스트림을 출력
	        response.getOutputStream().flush();
	        //출력스트림을 닫는다
	        response.getOutputStream().close();
		} catch (Exception e) {
			logger.debug("에러메시지 : "+e.toString());
		}
	}*/
	
}
