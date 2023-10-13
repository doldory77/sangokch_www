package sangok.web;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.support.DefaultListableBeanFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import sangok.service.WebService;
import sangok.utils.JMap;
import sangok.utils.JNum;
import sangok.utils.JStr;

/**
 * 
 * <br>
 * Copyfight 2023 SangokCH All rights reserved.<br>
 * <br>
 * @author doldo
 * @version 
 * @since 2023. 8. 26
 *
 */

@Controller
public class WebController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(WebController.class);
	
	@Autowired
	DefaultListableBeanFactory beanFactory;
	
	@Autowired
	org.springframework.context.support.MessageSourceAccessor messageSourceAccessor;
	
	@Resource(name = "webService")
	private WebService webService;
	
	List<Map<String, Object>> menuList = null; 

	@RequestMapping(value = "/home.do")
	public String home(HttpSession session, ModelMap model) throws Exception {
		
		if (menuList == null) {
			menuList = webService.selectMenuByTree();
		}
		Map<String, Object> MAIN10 = webService.selectBoardDtl(JMap.instance("GROUP_ID", "A0000000").put("SEQ_NO", 10).build());
		Map<String, Object> MAIN11 = webService.selectBoardDtl(JMap.instance("GROUP_ID", "A0000000").put("SEQ_NO", 11).build());
		
		model.addAttribute("MENU_LIST", menuList);
		model.addAttribute("MAIN10", MAIN10);
		model.addAttribute("MAIN11", MAIN11);
		
//		for (String beanName : beanFactory.getBeanDefinitionNames()) {
//			LOGGER.debug("class : " + beanFactory.getBean(beanName).getClass().getName());
//		}
		
		return "home/main";
	}
	
	@RequestMapping(value = "/admin/code/groupMng.do")
	public String codeGroupMng(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		List<Map<String, Object>> GroupList = webService.selectCodeGroup(null);
		model.addAttribute("CODE_GROUP", GroupList);
		
		return "admin/code/groupMng";
	}
	
	@RequestMapping(value = "/admin/board/write.do")
	public String boardWrite(@RequestParam Map<String, Object> params, ModelMap model, HttpServletRequest request) throws Exception {
		LOGGER.debug(params + "");
		List<Map<String, Object>> groupIdList = webService.selectMenu(JMap.instance("P_MENU_GROUP", null).put("P_DEPTH_CHAR", "--").build());
		List<Map<String, Object>> YNCodeList = webService.selectCode(JMap.instance("GRP_ID", "CD0000").build());
		Map<String, Object> boardDtl = webService.selectBoardDtl(params);
		LOGGER.debug("BOARD_DTL === " + boardDtl);
		model.addAttribute("groupIdList", groupIdList);
		model.addAttribute("YNCodeList", YNCodeList);
		model.addAttribute("BOARD_DTL", boardDtl);
		model.addAttribute("CURR_PAGE", request.getParameter("CURR_PAGE"));		
		
		return "admin/board/write";
	}
	
	@RequestMapping(value = "/admin/board/save.do")
	public String boardSave(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		//#DEL_YN#, #SUBJECT#, #CONTENT#, #GROUP_ID#, #SEQ_NO#, #SCREEN_YN#, #DEPTH_NO#, #ORD_NO#, #USE_YN#, #USER_ID#
		params.put("RTN_MSG", "");
		params.put("USER_ID", "SYS_TEST");
		
		LOGGER.debug("==========> " + params);
		webService.updateBoard(params);
		LOGGER.debug("==========> " + JStr.toStr(params.get("SEQ_NO")));
		LOGGER.debug("==========> " + JStr.toStr(params.get("RTN_MSG")));
		
		
		//return this.boardWrite(params, model, request);
		return "redirect:/admin/board/list.do?CURR_PAGE=" + params.get("CURR_PAGE") + "&GROUP_ID=" + JStr.ifNull(params.get("GROUP_ID"), "");
	}
	
	@RequestMapping(value = "/admin/board/list.do")
	public String boardList(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		if (JNum.isInteger(params.get("CURR_PAGE")) == false) {
			params.put("CURR_PAGE", 1);
		}
		if (JStr.isStr(params.get("GROUP_ID")) == false) {
			params.put("GROUP_ID", null);
		}
		List<Map<String, Object>> list = webService.selectBoardList(params);
		
		model.addAttribute("BOARD_LIST", list);
		model.addAttribute("PAGE_CTL", params);
		
		return "admin/board/list";
	}
	
	@RequestMapping(value = "/ckeditor5/imageUpload.do")
	public String imageUpload(@RequestParam Map<String, Object> params, MultipartHttpServletRequest request, ModelMap model) throws Exception {
		String imgPath = null;
		try {
//			final String imgRealPath = request.getSession().getServletContext().getRealPath("/").concat("/images/");
//			final String imgRealPath = "C:\\dev\\eGovFrameDev-3.10.0-64bit\\workspace\\www\\src\\main\\webapp\\images\\board\\";
			final String imgRealPath = messageSourceAccessor.getMessage("path.image.board");
			final String imgUrlPath = request.getContextPath().concat("/images/board/");
			List<MultipartFile> fileList = request.getFiles("upload");
			for (MultipartFile mf : fileList) {
				if (fileList.get(0).getSize() > 0) {
					String originFileName = mf.getOriginalFilename();
					LOGGER.debug("originFileName == " + originFileName);
					String ext = FilenameUtils.getExtension(originFileName);
					String newlnfImgFileName = "img_" + UUID.randomUUID() + "." + ext;
					imgPath = imgUrlPath + newlnfImgFileName;
					File file = new File(imgRealPath + newlnfImgFileName);
					mf.transferTo(file);
					
					//Runtime.getRuntime().exec("chmod 666 " + file);
				}
			}
			
		} catch (IOException e) {
			e.printStackTrace();
			throw e;
		} finally {
			
		}
		
		model.put("uploaded", true);
		model.put("url", imgPath);
		
		return "jsonView";
	}
	
}
