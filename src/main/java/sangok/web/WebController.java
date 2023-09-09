package sangok.web;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
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
import sangok.service.impl.BoardItem;
import sangok.utils.JMap;
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
	
	@Resource(name = "webService")
	private WebService webService;

	@RequestMapping(value = "/home.do")
	public String home(HttpSession session, ModelMap model) throws Exception {
		
//		for (String beanName : beanFactory.getBeanDefinitionNames()) {
//			LOGGER.debug("class : " + beanFactory.getBean(beanName).getClass().getName());
//		}
		
		return "home/main";
	}
	
	@RequestMapping(value = "/admin/board/write.do")
	public String boardWrite(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		LOGGER.debug(params + "");
		
		List<Map<String, Object>> groupIdList = webService.selectMenu(JMap.instance("P_MENU_GROUP", null).put("P_DEPTH_CHAR", "--").build());
		List<Map<String, Object>> YNCodeList = webService.selectCode(JMap.instance("GRP_ID", "CD0000").build());
		
		model.addAttribute("groupIdList", groupIdList);
		model.addAttribute("YNCodeList", YNCodeList);
		return "admin/board/write";
	}
	
	@RequestMapping(value = "/admin/board/save.do")
	public String boardSave(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		//#DEL_YN#, #SUBJECT#, #CONTENT#, #GROUP_ID#, #SEQ_NO#, #SCREEN_YN#, #DEPTH_NO#, #ORD_NO#, #USE_YN#, #USER_ID#
		params.put("RTN_MSG", "");
		params.put("DEL_YN", "N");
		params.put("SEQ_NO", 0);
		params.put("DEPTH_NO", 0);
		params.put("ORD_NO", 0);
		params.put("USER_ID", "SYS_TEST");
		
		BoardItem boardItem = new BoardItem();
		boardItem.setSUBJECT(JStr.toStr(params.get("SUBJECT")));
		boardItem.setCONTENT(JStr.toStr(params.get("CONTENT")));
		boardItem.setGROUP_ID(JStr.toStr(params.get("GROUP_ID")));
		boardItem.setSCREEN_YN(JStr.toStr(params.get("SCREEN_YN")));
		boardItem.setUSE_YN(JStr.toStr(params.get("USE_YN")));
		boardItem.setUSER_ID(JStr.toStr(params.get("USER_ID")));
		//LOGGER.debug("==========> " + params);
		webService.updateBoard(params);
		LOGGER.debug("==========> " + JStr.toStr(params.get("SEQ_NO")));
		//LOGGER.debug("==========> " + JStr.toStr(params.get("RTN_MSG")));
		
		return this.boardWrite(params, model);
	}
	
	@RequestMapping(value = "/ckeditor5/imageUpload.do")
	public String imageUpload(@RequestParam Map<String, Object> params, MultipartHttpServletRequest request, ModelMap model) throws Exception {
		String imgPath = null;
		try {
			final String imgRealPath = request.getSession().getServletContext().getRealPath("/").concat("/images/");
			final String imgUrlPath = request.getContextPath().concat("/images/");
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
