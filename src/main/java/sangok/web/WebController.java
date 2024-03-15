package sangok.web;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.InitializingBean;
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

import sangok.scheduler.CacheScheduler;
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
public class WebController implements InitializingBean {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(WebController.class);
	
	@Autowired
	DefaultListableBeanFactory beanFactory;
	
	@Autowired
	ServletContext ctx;
	
	@Autowired
	org.springframework.context.support.MessageSourceAccessor messageSourceAccessor;
	
	@Resource(name = "cacheScheduler")
	private CacheScheduler cacheScheduler;
	
	@Resource(name = "webService")
	private WebService webService;
	
	private List<Map<String, Object>> menuList = null;
	
	private Pattern p = Pattern.compile("^/([A-Z]{1,2}[0]{2,3}0{3}[1-9]{1})[.]do$");
	
	/*
	 * 페이지 요청시 메뉴 공통처리
	 */
	private void commProcessSetMenu(boolean excludeAdmMenuYn, ModelMap model) throws Exception {
		if (menuList == null) {
			menuList = webService.selectMenuByTree();
			for (int i=menuList.size()-1; i>=0; i--) {
				if ("A0000000".equals(menuList.get(i).get("MENU_ID"))) {
					menuList.remove(i);
					break;
				}
			}
		}
		if (excludeAdmMenuYn) {
			/*관리자메뉴는 제외*/
			model.addAttribute("MENU_LIST", menuList);
			for (int i=menuList.size()-1; i>=0; i--) {
				if ("G0000000".equals(menuList.get(i).get("MENU_ID"))) {
					menuList.get(i).put("SUB_MENU", null);
					break;
				}
			}
		}
	}
	
	/*
	 * 페이지 요청시 메뉴 하이라이트
	 */
	private void commProcessMenuHighlight(HttpServletRequest request, ModelMap model) throws Exception {
		String serveltPath = request.getServletPath();
		Matcher m = p.matcher(serveltPath);
		if (m.find()) {
			String S_MENU = m.group(1);
			model.addAttribute("M_MENU", S_MENU.substring(0, 2) + "000000");
			model.addAttribute("S_MENU", S_MENU);
			Map<String, Object> map = webService.getMapper().selectMenuNm(S_MENU);
			model.addAttribute("TITLE", map.get("TITLE"));
		}
		
	}
	
	/*
	 * 페이지 요청시 메뉴 하이라이트
	 */
	private void commProcessMenuHighlightByBoardDtlView(HttpServletRequest request, ModelMap model) throws Exception {
		String S_MENU = request.getParameter("GROUP_ID");
		if (S_MENU != null && S_MENU.length() > 7) {
			model.addAttribute("M_MENU", S_MENU.substring(0, 2) + "000000");
			model.addAttribute("S_MENU", S_MENU);
			Map<String, Object> map = webService.getMapper().selectMenuNm(S_MENU);
			model.addAttribute("TITLE", map.get("TITLE"));
		}
		
	}
	
	/*
	 * 페이지 title, 경로 표시
	 */	
	private void commSetTitle(String menuId, ModelMap model) {
		try {
			String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", menuId).build()).get("MENU_NM").toString();
			model.addAttribute("TITLE", title);
		} catch (Exception e) {
			
		}
	}
	
	/*
	 * 게시판 내용중 <h1></h1> 이스케이프 처리
	 */
	@SuppressWarnings("unchecked")
	private void commProcessEscapeBoard(String[] boardNameList
			, Boolean[] boardListYn
			, ModelMap model) throws Exception {
		if (boardNameList != null && boardListYn != null && boardNameList.length == boardListYn.length) {			
			for (int i=0; i<boardNameList.length; i++) {
				if (model.get(boardNameList[i]) != null) {
					if (model.get(boardNameList[i]) instanceof List && ((List<Map<String, Object>>) model.get(boardNameList[i])).size() > 0) {
						if (boardListYn[i] == true) {
							model.addAttribute(boardNameList[i], JMap.replaceFirst((List<Map<String, Object>>) model.get(boardNameList[i]), "CONTENT", "<h1>.+</h1>", ""));
						} else {
							if (model.get(boardNameList[i]) != null) { model.addAttribute(boardNameList[i], JMap.replaceFirst((List<Map<String, Object>>) model.get(boardNameList[i]), "CONTENT", "<h1>.+</h1>", "").get(0)); }
						}
					}
				}
			}
		}
	}
	
	/*
	 * 게시판 조회 공통처리
	 */
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
		if (JStr.isStr(params.get("ORDER_BY")) == false) {
			params.put("ORDER_BY", null);
		}
		
		List<Map<String, Object>> list = webService.selectBoardList(params);
		
		model.addAttribute("GROUP_ID", params.get("GROUP_ID"));
		model.addAttribute("TAG_CD", params.get("TAG_CD"));
		model.addAttribute("PAGE", params.get("PAGE"));
		
		model.addAttribute("BOARD_LIST", list);
		model.addAttribute("PAGE_CTL", params);
		return list;
	}
	
	@SuppressWarnings("unused")
	private boolean isDebug = true;
	
	/*
	 * 디버그 출력
	 */
	private void debug(Object obj) {
		if (isDebug = true && obj != null) LOGGER.debug("==========> " + obj);
	}
	
/***************************************************************************************************************************/	
	
	/*
	 * 생성된 클래스 확인
	 */
	@Override
	public void afterPropertiesSet() throws Exception {
		for (String beanName : beanFactory.getBeanDefinitionNames()) {
			LOGGER.debug("class : " + beanFactory.getBean(beanName).getClass().getName());
		}
		ctx.setAttribute("ENV", cacheScheduler.envMap);		
	}	
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/home.do")
	public String home(HttpSession session, ModelMap model) throws Exception {
		
		commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "A0000000").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "A0000000").put("USE_YN", "Y").build());
		
		model.addAttribute("HEADER_IMG", HEADER_IMG);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("TITLE", "산곡교회 홈페이지");
		commProcessEscapeBoard(new String[] {"HEADER_IMG","BODY_LIST"}, new Boolean[] {false, true}, model);
		
		return "home/main";
	}
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/boardDtlView.do")
	public String boardDtlView(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {		
		this.commProcessMenuHighlightByBoardDtlView(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("SEQ_NO", params.get("SEQ_NO")).put("GROUP_ID", params.get("GROUP_ID")).build());
		
		model.addAttribute("BODY", BODY_LIST);
		model.addAttribute("TITLE", "상세");
		model.addAttribute("W_SIZE", params.get("W_SIZE"));
		commProcessEscapeBoard(new String[] {"BODY"}, new Boolean[] {false}, model);
		if (BODY_LIST != null && BODY_LIST.size() > 0) {
			model.addAttribute("TITLE", BODY_LIST.get(0).get("SUBJECT"));
		}
		return "home/boardDtlView";
	}	
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/B0000001.do")
	public String b0000001(HttpServletRequest request, ModelMap model) throws Exception {		
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "B0000001").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "B0000001").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "05").put("GROUP_ID", "B0000001").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "B0000001").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG);
		model.addAttribute("BODY_IMG", BODY_IMG);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("TITLE", title);
		commProcessEscapeBoard(new String[] {"HEADER_IMG", "BODY_IMG", "BODY_LIST"}, new Boolean[] {false, false, true}, model);
		
		return "home/B0000000/B0000001";
	}
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/B0000002.do")
	public String b0000002(HttpServletRequest request, ModelMap model) throws Exception {		
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "B0000002").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "B0000002").put("USE_YN", "Y").build());
		List<Map<String, Object>> FOOTER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "03").put("GROUP_ID", "B0000002").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "B0000002").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("FOOTER_IMG", FOOTER_IMG);
		model.addAttribute("TITLE", title);
		commProcessEscapeBoard(new String[] {"HEADER_IMG", "FOOTER_IMG", "BODY_LIST"}, new Boolean[] {false, false, true}, model);
		
		return "home/B0000000/B0000002";
	}
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/B0000003.do")
	public String b0000003(HttpServletRequest request, ModelMap model) throws Exception {		
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "B0000003").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "B0000003").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "B0000003").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("TITLE", title);
		commProcessEscapeBoard(new String[] {"HEADER_IMG","BODY_LIST"}, new Boolean[] {false, true}, model);
		
		return "home/B0000000/B0000003";
	}	
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/B0000004.do")
	public String b0000004(HttpServletRequest request, ModelMap model) throws Exception {		
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "B0000004").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "00").put("GROUP_ID", "B0000004").put("ORDER_BY", "ATTR03 DESC").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "B0000004").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("TITLE", title);
		commProcessEscapeBoard(new String[] {"HEADER_IMG","BODY_LIST"}, new Boolean[] {false, true}, model);
		
		return "home/B0000000/B0000004";
	}
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/B0000005.do")
	public String b0000005(HttpServletRequest request, ModelMap model) throws Exception {		
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "B0000005").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "B0000005").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "B0000005").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG);
		model.addAttribute("BODY", BODY_LIST);
		model.addAttribute("TITLE", title);
		commProcessEscapeBoard(new String[] {"HEADER_IMG", "BODY"}, new Boolean[] {false, false}, model);
		
		return "home/B0000000/B0000005";
	}
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/C0000001.do")
	public String c0000001(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {		
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "C0000001").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "C0000001").build()).get("MENU_NM").toString();
		
		debug("[ADMIN PAGE PARAMS] " + params);
		params.put("ORDER_BY", "ATTR02 DESC");

		this.setBoardListInitParams(params, model);
		
		model.addAttribute("HEADER_IMG", HEADER_IMG);
		model.addAttribute("TITLE", title);
		commProcessEscapeBoard(new String[] {"HEADER_IMG"}, new Boolean[] {false}, model);
		
		return "home/C0000000/C0000001";
	}
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/C0000002.do")
	public String c0000002(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {		
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "C0000002").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "C0000002").build()).get("MENU_NM").toString();
		
		debug("[ADMIN PAGE PARAMS] " + params);
		params.put("ORDER_BY", "ATTR02 DESC");

		this.setBoardListInitParams(params, model);
		
		model.addAttribute("HEADER_IMG", HEADER_IMG);
		model.addAttribute("TITLE", title);
		commProcessEscapeBoard(new String[] {"HEADER_IMG"}, new Boolean[] {false}, model);
		
		return "home/C0000000/C0000002";
	}
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/D0000001.do")
	public String d0000001(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {		
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "D0000001").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "D0000001").build()).get("MENU_NM").toString();
		
		debug("[ADMIN PAGE PARAMS] " + params);
		params.put("ORDER_BY", "ATTR02 DESC");
		
		this.setBoardListInitParams(params, model);
		
		model.addAttribute("HEADER_IMG", HEADER_IMG);
		model.addAttribute("TITLE", title);
		commProcessEscapeBoard(new String[] {"HEADER_IMG"}, new Boolean[] {false}, model);
		
		return "home/D0000000/D0000001";
	}
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/D0000002.do")
	public String d0000002(HttpServletRequest request, ModelMap model) throws Exception {		
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "D0000002").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "D0000002").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "D0000002").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("TITLE", title);
		commProcessEscapeBoard(new String[] {"HEADER_IMG","BODY_LIST"}, new Boolean[] {false, true}, model);
		
		return "home/D0000000/D0000002";
	}
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/D0000003.do")
	public String d0000003(HttpServletRequest request, ModelMap model) throws Exception {		
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "D0000003").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "D0000003").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "D0000003").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("TITLE", title);
		commProcessEscapeBoard(new String[] {"HEADER_IMG","BODY_LIST"}, new Boolean[] {false, true}, model);
		
		return "home/D0000000/D0000003";
	}
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/D0000004.do")
	public String d0000004(HttpServletRequest request, ModelMap model) throws Exception {		
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "D0000004").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "D0000004").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "D0000004").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("TITLE", title);
		commProcessEscapeBoard(new String[] {"HEADER_IMG","BODY_LIST"}, new Boolean[] {false, true}, model);
		
		return "home/D0000000/D0000004";
	}
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/E0000002.do")
	public String e0000002(HttpServletRequest request, ModelMap model) throws Exception {		
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "E0000002").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "E0000002").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "E0000002").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("TITLE", title);
		commProcessEscapeBoard(new String[] {"HEADER_IMG","BODY_LIST"}, new Boolean[] {false, true}, model);
		
		return "home/E0000000/E0000002";
	}	
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/F0000001.do")
	public String f0000001(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {		
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "F0000001").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "F0000001").build()).get("MENU_NM").toString();
		
		debug("[ADMIN PAGE PARAMS] " + params);
		params.put("ORDER_BY", "ATTR02 DESC");
		
		this.setBoardListInitParams(params, model);
		
		model.addAttribute("HEADER_IMG", HEADER_IMG);
		model.addAttribute("TITLE", title);
		commProcessEscapeBoard(new String[] {"HEADER_IMG"}, new Boolean[] {false}, model);
		
		return "home/F0000000/F0000001";
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
			List<Map<String, Object>> userAuth = webService.selectUserAuth(JMap.instance("USER_ID", userId).build());
			Map<String, Object> authMap = new HashMap<String, Object>();
			for (int i=0; i<userAuth.size(); i++) {
				authMap.put("" + userAuth.get(i).get("MENU_ID"), userAuth.get(i).get("USE_YN"));
			}
			Map<String, Object> map = userList.get(0); 
			UserInfo userInfo = new UserInfo();
			userInfo.setId(map.get("ID").toString());
			userInfo.setAdmYn(map.get("ADM_YN").toString());
			userInfo.setUseYn(map.get("USE_YN").toString());
			userInfo.setAttr01(map.get("ATTR01").toString());
			userInfo.setAuthMap(authMap);
			request.getSession().setAttribute("USER_INFO", userInfo);
			return "redirect:/admin/main.do";
		}
		
	}
	
	/*
	 * 관리자 로그아웃
	 */
	@RequestMapping(value = "/admin/login/logout.do")
	public String adminLoginOut(@RequestParam Map<String, Object> params, ModelMap model, HttpServletRequest request) throws Exception {
		request.getSession().invalidate();
		
		return "redirect:/home.do";
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
	 * 해당 코드그룹의 코드조회
	 */
	@RequestMapping(value = "/admin/user/userAuthMng.do")
	public String userAuthMng(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		List<Map<String, Object>> authList = webService.selectUserAuth(params);
		
		model.addAttribute("USER_ID", params.get("USER_ID"));
		model.addAttribute("AUTH", authList);
		
		return "admin/user/userAuthMng";
	}
	
	/*
	 * JSON 요청 테스트
	 */
	@ResponseBody
	@RequestMapping(value = "/admin/user/saveUserAuth.do")
	public Map<String, Object> saveUserAuth(@RequestBody List<Map<String, Object>> params, ModelMap model) throws Exception {
		
		debug(params);
		webService.updateUserAuth(params);
		return JMap.instance("result", "SUCCESS").put("count", params.size()).build();
		/*
		$.ajax({
			type: 'POST'
			, url: '/jsonTest.do'
			, data: JSON.stringify({age:37, name:'doldory'})
			, dataType: 'JSON'
			, contentType: 'application/json; charset-utf-8'
			, success: function(result) {
				console.log(result);
			}
			, error: function(xhr, status, error) {
				console.log(error);
			}
		}) 		
		*/
	}	
	
	/*
	 * 사용자 저장
	 */
	@RequestMapping(value = "/admin/user/saveUser.do")
	public String saveUser(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		params.put("RTN_MSG", "SUCCESS");
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
		webService.updateCodeGroup(params);
		
		return "redirect:/admin/code/groupMng.do";
	}
	
	/*
	 * 해당 코드그룹의 코드 저장
	 */
	@RequestMapping(value = "/admin/code/saveCode.do")
	public String saveCode(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		params.put("RTN_MSG", "SUCCESS");
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
		
		model.addAttribute("PARENT_MENU_ID", params.get("P_MENU_GROUP"));
		model.addAttribute("SUB_MENU", subMenuList);
		
		return "admin/menu/subMenuMng";
	}
	
	/*
	 * 하위메뉴를 저장한다.
	 */
	@RequestMapping(value = "/admin/menu/saveSubMenu.do")
	public String saveSubMenu(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		params.put("RTN_MSG", "SUCCESS");
		params.put("ORD_NO", null);
		params.put("MENU_LEVEL", null);
		webService.updateSubMenu(params);
		
		return "redirect:/admin/menu/subMenuMng.do?P_MENU_GROUP="+params.get("PARENT_MENU_ID");
	}	
	
	/*
	 * 게시판 작성(상세) 페이지 조회
	 */
	@RequestMapping(value = "/admin/board/write.do")
	public String boardWrite(@RequestParam Map<String, Object> params, ModelMap model, HttpServletRequest request) throws Exception {
		debug("[BAORD WRITE PARAMETERS] " + params);
		List<Map<String, Object>> groupIdList = webService.selectMenu(JMap.instance("P_MENU_GROUP", null).put("P_DEPTH_CHAR", "ㄴ").build());
		List<Map<String, Object>> YNCodeList = webService.selectCode(JMap.instance("GROUP_ID", "CD0000").put("USE_YN", "Y").build());
		List<Map<String, Object>> TagCodeList = webService.selectCode(JMap.instance("GROUP_ID", "CD0001").put("USE_YN", "Y").build());
		List<Map<String, Object>> boardDtlList = null;
		model.addAttribute("BOARD_DTL", null);
		if (params.get("SEQ_NO") != null) {
			boardDtlList = webService.selectBoardDtl(params);
			debug("[BOARD_DTL] " + boardDtlList);
			model.addAttribute("BOARD_DTL", JList.get(boardDtlList, 0));
		}
		model.addAttribute("groupIdList", groupIdList);
		model.addAttribute("YNCodeList", YNCodeList);
		model.addAttribute("TagCodeList", TagCodeList);
		model.addAttribute("CURR_PAGE", request.getParameter("CURR_PAGE"));
		model.addAttribute("PAGE", params.get("PAGE"));
		model.addAttribute("SCREEN_YN", params.get("SCREEN_YN"));
		model.addAttribute("GROUP_ID", params.get("GROUP_ID"));
		if (params.get("GROUP_ID") != null) {
			model.addAttribute("TITLE", webService.getMapper().selectMenuNm(params.get("GROUP_ID").toString()).get("TITLE"));
		}
		return "admin/board/write";
	}
	
	/*
	 * 게시판 저장
	 */
	@RequestMapping(value = "/admin/board/save.do")
	public String boardSave(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		//#DEL_YN#, #SUBJECT#, #CONTENT#, #GROUP_ID#, #SEQ_NO#, #SCREEN_YN#, #DEPTH_NO#, #ORD_NO#, #USE_YN#, #USER_ID#
		params.put("RTN_MSG", "");
		params.put("USER_ID", "SYS_TEST");
		
		debug(params);
		webService.updateBoard(params);
		debug(JStr.toStr(params.get("SEQ_NO")));
		debug(JStr.toStr(params.get("RTN_MSG")));
		
		String isAdminIfrmPage = params.get("IS_ADMIN_IFRM_PAGE").toString();
		if ("N".equalsIgnoreCase(isAdminIfrmPage)) {
			return "redirect:/admin/adminPage.do?CURR_PAGE=" + params.get("CURR_PAGE")
				+ "&PAGE=" + params.get("PAGE")
				//+ "&SCREEN_YN=" + params.get("SCREEN_YN")
				+ "&GROUP_ID=" + JStr.ifNull(params.get("GROUP_ID"), "");
		} else {
			return "redirect:/admin/adminIfrmPage.do?CURR_PAGE=" + params.get("CURR_PAGE")
				+ "&PAGE=" + params.get("PAGE")
				//+ "&SCREEN_YN=" + params.get("SCREEN_YN")
				+ "&TAG_CD=" + params.get("TAG_CD")
				+ "&GROUP_ID=" + JStr.ifNull(params.get("GROUP_ID"), "");			
		}
	}
	
	/*
	 * 게시판 목록 조회
	 */
	@RequestMapping(value = "/admin/board/list.do")
	public String boardList(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		List<Map<String, Object>> list = this.setBoardListInitParams(params, model);
		
		model.addAttribute("BOARD_LIST", list);
		model.addAttribute("PAGE_CTL", params);
		model.addAttribute("BOARD_TITLE", params.get("BOARD_TITLE"));
		
		return "admin/board/list";
	}
	
	/*
	 * 관리자 기능별 페이지 조회
	 */
	@RequestMapping(value = "/admin/adminPage.do")
	public String adminPage(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		debug("[ADMIN PAGE PARAMS] " + params);
		params.put("ORDER_BY", "SCREEN_YN DESC, ORD_NO ASC");
		
		this.commSetTitle(params.get("PAGE").toString(), model);
		String jspAdminPage = params.get("PAGE").toString();
		this.setBoardListInitParams(params, model);
		
		return "admin/" + jspAdminPage.substring(0, 1) + "0000000/" + jspAdminPage;
	}
	
	/*
	 * 관리자 기능별 페이지 조회
	 */
	@RequestMapping(value = "/admin/adminIfrmPage.do")
	public String adminIfrmPage(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		debug("[ADMIN IFRM PAGE PARAMS] " + params);
		
		String jspAdminPage = params.get("PAGE").toString();
		this.setBoardListInitParams(params, model);
		
		return "admin/" + jspAdminPage.substring(0, 1) + "0000000/" + jspAdminPage + "F";
	}	
	
	/*
	 * 성경구정 또는 찬송가 조회
	 */
	@RequestMapping(value = "/bibleAndHymn.do")
	public String bibleAndHymn(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		params.put("RTN_MSG", "SUCCESS");
		debug(params);
		List<Map<String, Object>> list = webService.selectBibleAndHymn(params);
		model.put("dvsn", params.get("DVSN"));
		model.put("title", params.get("SEARCH_KEYWORD"));
		model.put("cnt", list == null ? 0 : list.size());
		model.put("content", list);
		
		return "jsonView";
	}	
	
	/*
	 * JSON 요청 테스트
	 */
	@ResponseBody
	@RequestMapping(value = "/jsonTest.do")
	public Map<String, Object> jsonTest(@RequestBody List<Map<String, Object>> params, ModelMap model) throws Exception {
		
		debug(params);
		model.put("dvsn", "A");
		model.put("title", "B");
		model.put("cnt", 0);
		
		return JMap.instance("dvsn", "A").put("title", "B").put("cnt", 0).build();
		/*
		$.ajax({
			type: 'POST'
			, url: '/jsonTest.do'
			, data: JSON.stringify({age:37, name:'doldory'})
			, dataType: 'JSON'
			, contentType: 'application/json; charset-utf-8'
			, success: function(result) {
				console.log(result);
			}
			, error: function(xhr, status, error) {
				console.log(error);
			}
		}) 		
		*/
	}
	
	/*
	 * ckeditor5 이미지 저장
	 */
	@RequestMapping(value = "/ckeditor5/imageUpload.do")
	public String imageUpload(@RequestParam Map<String, Object> params, MultipartHttpServletRequest request, ModelMap model) throws Exception {
		String imgPath = null;
		try {
			//final String imgRealPath = request.getSession().getServletContext().getRealPath("/").concat("/images/");
			//final String imgRealPath = "C:\\dev\\eGovFrameDev-3.10.0-64bit\\workspace\\www\\src\\main\\webapp\\images\\board\\";
			final String imgRealPath = messageSourceAccessor.getMessage("path.image.board");
			final String imgUrlPath = request.getContextPath().concat("/images/board/");
			List<MultipartFile> fileList = request.getFiles("upload");
			for (MultipartFile mf : fileList) {
				if (fileList.get(0).getSize() > 0) {
					String originFileName = mf.getOriginalFilename();
					debug("[originFileName] " + originFileName);
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
