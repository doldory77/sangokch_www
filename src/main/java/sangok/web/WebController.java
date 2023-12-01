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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import sangok.service.WebService;
import sangok.utils.JList;
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

	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/home.do")
	public String home(HttpSession session, ModelMap model) throws Exception {
		
		if (menuList == null) {
			menuList = webService.selectMenuByTree();
		}
		List<Map<String, Object>> MAIN01 = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").build());
		List<Map<String, Object>> MAIN02 = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").build());
		
		/*관리자메뉴는 제외*/
		model.addAttribute("MENU_LIST", menuList);
		for (int i=menuList.size()-1; i>=0; i--) {
			if ("G0000000".equals(menuList.get(i).get("MENU_ID"))) {
				menuList.remove(i);
				break;
			}
		}
		model.addAttribute("MAIN01", JMap.replaceFirst(MAIN01, "CONTENT", "<h1>.+</h1>", "").get(0));
		model.addAttribute("MAIN02_LIST", JMap.replaceFirst(MAIN02, "CONTENT", "<h1>.+</h1>", ""));
		
//		for (String beanName : beanFactory.getBeanDefinitionNames()) {
//			LOGGER.debug("class : " + beanFactory.getBean(beanName).getClass().getName());
//		}
		
		return "home/main";
	}
	
	/*
	 * 관리자 로그인 접속
	 */
	@RequestMapping(value = "/admin/login.do")
	public String adminLogin(@RequestParam(required = false, name = "LOGIN_YN") String loginYn, ModelMap model, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession(false);
		if (session != null && session.getAttribute("USER_INFO") != null) {
			return "redirect:/admin/main.do";
		}
		
		model.addAttribute("LOGIN_YN", loginYn);
		
		return "admin/adminLogin";
	}
	
	/*
	 * 관리자 로그인 처리
	 */
	@RequestMapping(value = "/admin/login/loginCheck.do")
	public String adminLoginCheck(@RequestParam(required = true, name = "USER_ID") String userId
			, @RequestParam(required = true, name = "USER_PW") String userPw
			, ModelMap model, HttpServletRequest request, RedirectAttributes re) throws Exception {
		List<Map<String, Object>> userList = webService.selectUser(JMap.instance("ID", userId).put("PW", userPw).put("USE_YN", "Y").build());
		if (userList == null || userList.size() == 0) {
			re.addAttribute("LOGIN_YN", "N");
			return "redirect:/admin/login.do";
		} else {
			UserInfo userInfo = new UserInfo();
			userInfo.setId(userList.get(0).get("ID").toString());
			userInfo.setAdmYn(userList.get(0).get("ADM_YN").toString());
			userInfo.setUseYn(userList.get(0).get("USE_YN").toString());
			userInfo.setAttr01(userList.get(0).get("ATTR01").toString());
			request.getSession().setAttribute("USER_INFO", userInfo);
			//re.addAttribute("LOGIN_YN", "Y");
			return "redirect:/admin/main.do";
		}
		
	}
	
	/*
	 * 관리자 로그아웃
	 */
	@RequestMapping(value = "/admin/login/logout.do")
	public String adminLoginOut(@RequestParam Map<String, Object> params, ModelMap model, HttpServletRequest request) throws Exception {
		request.getSession().invalidate();
		
		return "redirect:/admin/login.do";
	}
	
	/*
	 * 관리자 메인페이지 접속
	 */
	@RequestMapping(value = "/admin/main.do")
	public String adminMain(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		List<Map<String, Object>> menuList = webService.selectMenuByTree();
		model.addAttribute("MENU_LIST", menuList);
		
		return "admin/adminMain";
	}
	
	/*
	 * 사용자 조회
	 */
	@RequestMapping(value = "/admin/user/userMng.do")
	public String userMng(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		List<Map<String, Object>> userList = webService.selectUser(JMap.instance("ID", null).put("PW", null).put("USE_YN", null).build());
		model.addAttribute("USER_LIST", userList);
		
		return "admin/user/userMng";
	}
	
	/*
	 * 사용자 저장
	 */
	@RequestMapping(value = "/admin/user/saveUser.do")
	public String saveUser(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		params.put("RTN_MSG", "SUCCESS");
		LOGGER.debug("==========> " + params);
		webService.updateUser(params);
		
		return "redirect:/admin/user/userMng.do";
	}	
	
	/*
	 * 코드그룹 조회
	 */
	@RequestMapping(value = "/admin/code/groupMng.do")
	public String groupMng(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		List<Map<String, Object>> groupList = webService.selectCodeGroup(null);
		model.addAttribute("CODE_GROUP", groupList);
		
		return "admin/code/groupMng";
	}
	
	/*
	 * 해당 코드그룹의 코드조회
	 */
	@RequestMapping(value = "/admin/code/codeMng.do")
	public String codeMng(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		List<Map<String, Object>> codeList = webService.selectCode(params);
		
		model.addAttribute("GROUP_ID", params.get("GROUP_ID"));
		model.addAttribute("CODE", codeList);
		
		return "admin/code/codeMng";
	}
	
	/*
	 * 코드그룹 저장
	 */
	@RequestMapping(value = "/admin/code/saveCodeGroup.do")
	public String saveGroup(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		params.put("RTN_MSG", "SUCCESS");
		LOGGER.debug("==========> " + params);
		webService.updateCodeGroup(params);
		
		return "redirect:/admin/code/groupMng.do";
	}
	
	/*
	 * 해당 코드그룹의 코드 저장
	 */
	@RequestMapping(value = "/admin/code/saveCode.do")
	public String saveCode(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		params.put("RTN_MSG", "SUCCESS");
		LOGGER.debug("==========> " + params);
		webService.updateCode(params);
		
		return "redirect:/admin/code/codeMng.do?GROUP_ID="+params.get("GROUP_ID");
	}
	
	/*
	 * 메인메뉴 조회
	 */
	@RequestMapping(value = "/admin/menu/mainMenuMng.do")
	public String mainMenuMng(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		List<Map<String, Object>> mainMenuList = webService.selectMenuByTree();
		model.addAttribute("MAIN_MENU", mainMenuList);
		
		return "admin/menu/mainMenuMng";
	}
	
	/*
	 * 해당 메뉴그룹의 서브메뉴 조회
	 */
	@RequestMapping(value = "/admin/menu/subMenuMng.do")
	public String subMenuMng(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		List<Map<String, Object>> subMenuList = webService.selectMenu(params);
		
		model.addAttribute("PARENT_MENU_ID", params.get("PARENT_MENU_ID"));
		model.addAttribute("SUB_MENU", subMenuList);
		
		return "admin/menu/subMenuMng";
	}	
	
	@RequestMapping(value = "/admin/board/write.do")
	public String boardWrite(@RequestParam Map<String, Object> params, ModelMap model, HttpServletRequest request) throws Exception {
		LOGGER.debug(params + "");
		List<Map<String, Object>> groupIdList = webService.selectMenu(JMap.instance("P_MENU_GROUP", null).put("P_DEPTH_CHAR", "--").build());
		List<Map<String, Object>> YNCodeList = webService.selectCode(JMap.instance("GROUP_ID", "CD0000").put("USE_YN", "Y").build());
		List<Map<String, Object>> TagCodeList = webService.selectCode(JMap.instance("GROUP_ID", "CD0001").put("USE_YN", "Y").build());
		List<Map<String, Object>> boardDtlList = webService.selectBoardDtl(params);
		LOGGER.debug("BOARD_DTL === " + boardDtlList);
		model.addAttribute("groupIdList", groupIdList);
		model.addAttribute("YNCodeList", YNCodeList);
		model.addAttribute("TagCodeList", TagCodeList);
		model.addAttribute("BOARD_DTL", JList.get(boardDtlList, 0));
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
	
	private List<Map<String, Object>> setBoardListInitParams(Map<String, Object> params, ModelMap model) throws Exception {
		if (JNum.isInteger(params.get("CURR_PAGE")) == false) {
			params.put("CURR_PAGE", 1);
		}
		if (JStr.isStr(params.get("GROUP_ID")) == false) {
			params.put("GROUP_ID", null);
		}
		if (JStr.isStr(params.get("TAG_CD")) == false) {
			params.put("TAG_CD", null);
		}
		if (JStr.isStr(params.get("SCREEN_YN")) == false) {
			params.put("SCREEN_YN", null);
		}
		List<Map<String, Object>> list = webService.selectBoardList(params);
		//model.addAttribute("PAGE", params.get("PAGE"));
		//model.addAttribute("SCREEN_YN", params.get("SCREEN_YN"));
		//model.addAttribute("GROUP_ID", params.get("GROUP_ID"));
		model.addAttribute("BOARD_LIST", list);
		model.addAttribute("PAGE_CTL", params);
		return list;
	}
	
	@RequestMapping(value = "/admin/board/list.do")
	public String boardList(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		List<Map<String, Object>> list = this.setBoardListInitParams(params, model);
		
		model.addAttribute("BOARD_LIST", list);
		model.addAttribute("PAGE_CTL", params);
		model.addAttribute("BOARD_TITLE", params.get("BOARD_TITLE"));
		
		return "admin/board/list";
	}
	
	@RequestMapping(value = "/admin/adminPage.do")
	public String adminPage(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		String jspAdminPage = params.get("PAGE").toString();
		this.setBoardListInitParams(params, model);
		
		return "admin/" + jspAdminPage.substring(0, 1) + "0000000/" + jspAdminPage;
	}
	
	@RequestMapping(value = "/bibleAndHymn.do")
	public String bibleAndHymn(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		params.put("RTN_MSG", "SUCCESS");
		LOGGER.debug("========= " + params.toString());
		List<Map<String, Object>> list = webService.selectBibleAndHymn(params);
		model.put("dvsn", params.get("DVSN"));
		model.put("title", params.get("SEARCH_KEYWORD"));
		model.put("cnt", list == null ? 0 : list.size());
		model.put("content", list);
		
		return "jsonView";
	}
	
	@ResponseBody
	@RequestMapping(value = "/jsonTest.do")
	public Map<String, Object> jsonTest(@RequestBody Map<String, Object> params, ModelMap model) throws Exception {
		
		LOGGER.debug(params.toString());
		model.put("dvsn", "A");
		model.put("title", "B");
		model.put("cnt", 0);
		
		return JMap.instance("dvsn", "A").put("title", "B").put("cnt", 0).build();
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
