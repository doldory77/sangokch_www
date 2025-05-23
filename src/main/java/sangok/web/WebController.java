package sangok.web;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
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
import sangok.utils.JIMG;
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
	 * 사용자 홈페이지 접근 기록
	 */		
	private void accessLog(HttpServletRequest request) throws Exception {
		String ip = request.getHeader("X-Forwarded-For");
		String url = request.getRequestURI();
	    if (ip == null) {
	        ip = request.getHeader("Proxy-Client-IP");
	    }
	    if (ip == null) {
	        ip = request.getHeader("WL-Proxy-Client-IP");
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_CLIENT_IP");
	    }
	    if (ip == null) {
	        ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	    }
	    if (ip == null) {
	        ip = request.getRemoteAddr();
	    }
	    if (!"127.0.0.1".equals(ip)) webService.getMapper().insertAccessLog(JMap.instance("REQUEST_URL", url).put("REQUEST_QUERY", request.getQueryString()).put("REQUEST_ADDR", ip).build());

	}
	
	/*
	 * 페이지 요청시 메뉴 공통처리
	 */
	private void commProcessSetMenu(boolean excludeAdmMenuYn, ModelMap model) throws Exception {
		if (menuList == null) {
			menuList = webService.selectMenuByTree(true);
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
//	@SuppressWarnings("unchecked")
//	private void commProcessEscapeBoard(String[] boardNameList
//			, Boolean[] boardListYn
//			, ModelMap model) throws Exception {
//		if (boardNameList != null && boardListYn != null && boardNameList.length == boardListYn.length) {			
//			for (int i=0; i<boardNameList.length; i++) {
//				if (model.get(boardNameList[i]) != null) {
//					if (model.get(boardNameList[i]) instanceof List && ((List<Map<String, Object>>) model.get(boardNameList[i])).size() > 0) {
//						if (boardListYn[i] == true) {
//							model.addAttribute(boardNameList[i], JMap.replaceFirst((List<Map<String, Object>>) model.get(boardNameList[i]), "CONTENT", "<h1>.+</h1>", ""));
//						} else {
//							if (model.get(boardNameList[i]) != null) { model.addAttribute(boardNameList[i], JMap.replaceFirst((List<Map<String, Object>>) model.get(boardNameList[i]), "CONTENT", "<h1>.+</h1>", "").get(0)); }
//						}
//					}
//				}
//			}
//		}
//	}
	
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
		model.addAttribute("SUB", params.get("SUB"));
//		if (JStr.isStr(params.get("SUB"))) {
//		}
		
		model.addAttribute("BOARD_LIST", list);
		model.addAttribute("PAGE_CTL", params);
		return list;
	}
	
	/*
	 * 게시판 겔러리 조회 공통처리
	 */
	private List<Map<String, Object>> setBoardGalaryInitParams(Map<String, Object> params, ModelMap model) throws Exception {
		if (JNum.isInteger(params.get("CURR_PAGE")) == false) {
			params.put("CURR_PAGE", 1);
		}
		if (JStr.isStr(params.get("GROUP_ID")) == false) {
			params.put("GROUP_ID", null);
		}
		if (JStr.isStr(params.get("TAG_CD")) == false) {
			params.put("TAG_CD", null);
		}
		
		List<Map<String, Object>> DISP_Y_LIST = webService.selectBoardGalary(params);
		
		model.addAttribute("GROUP_ID", params.get("GROUP_ID"));
		model.addAttribute("TAG_CD", params.get("TAG_CD"));
		model.addAttribute("PAGE", params.get("PAGE"));
		
		model.addAttribute("DISP_Y_LIST", DISP_Y_LIST);
		model.addAttribute("PAGE_CTL", params);
		return DISP_Y_LIST;
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
	 * 사용자 홈페이지 메인 접속
	 */
	@RequestMapping(value = "/home.do")
	public String home(HttpServletRequest request, ModelMap model) throws Exception {
		
		accessLog(request);
		
		commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_TEXT_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "07").put("GROUP_ID", "A0000000").put("USE_YN", "Y").build());
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "A0000000").put("USE_YN", "Y").build());
		List<Map<String, Object>> ROLL_IMG_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "06").put("GROUP_ID", "A0000000").put("USE_YN", "Y").build());
		List<Map<String, Object>> DISP_Y_LIST = webService.getMapper().selectDispYnBoard(JMap.instance("MAIN_DISP_YN", "Y").build());
//		String stdImgPath = null;
//		for (int i=0; i<ROLL_IMG_LIST.size(); i++) {
//			stdImgPath = JStr.extractStr(WebServiceImpl.imgPattern, JStr.toStr(ROLL_IMG_LIST.get(i).get("CONTENT")));
//			ROLL_IMG_LIST.get(i).put("CONTENT", JStr.isStr(stdImgPath) ? stdImgPath.replaceAll("\"", "") : stdImgPath);
//		}
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "A0000000").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		
		model.addAttribute("HEADER_TEXT_LIST", HEADER_TEXT_LIST);
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("ROLL_IMG_LIST", ROLL_IMG_LIST);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("DISP_Y_LIST", DISP_Y_LIST);
		model.addAttribute("TITLE", "산곡교회");
//		commProcessEscapeBoard(new String[] {"HEADER_TEXT_LIST","HEADER_IMG","ROLL_IMG_LIST","BODY_LIST"}, new Boolean[] {true, false, true, true}, model);
		
		return "home/main";
	}
	
	/*
	 * 사용자 사이트맵 접속
	 */
	@RequestMapping(value = "/sitemap.do")
	public String sitemap(HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		commProcessSetMenu(true, model);
		
		return "home/sitemap";
	}
	
	/*
	 * 사용자 홈페이지 접속
	 */
	@RequestMapping(value = "/sitemapXml.do")
	public String sitemapXml(HttpSession session, ModelMap model) throws Exception {
		commProcessSetMenu(true, model);
		model.addAttribute("NOW", JStr.yyyyMMddTHHmiss());
		
		return "home/sitemap_xml";
	}
	
	/*
	 * 사용자 개시판 세부페이지 접속
	 */
	@RequestMapping(value = "/boardDtlView.do")
	public String boardDtlView(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlightByBoardDtlView(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("SEQ_NO", params.get("SEQ_NO")).put("GROUP_ID", params.get("GROUP_ID")).build());
		
		model.addAttribute("BODY", BODY_LIST.size() > 0 ? BODY_LIST.get(0) : null);
		model.addAttribute("TITLE", "상세");
		model.addAttribute("W_SIZE", params.get("W_SIZE"));
//		commProcessEscapeBoard(new String[] {"BODY"}, new Boolean[] {false}, model);
		if (BODY_LIST != null && BODY_LIST.size() > 0) {
			model.addAttribute("TITLE", BODY_LIST.get(0).get("SUBJECT"));
		}
		return "home/boardDtlView";
	}	
	
	/*
	 * 사용자 산곡교회비전 접속
	 */
	@RequestMapping(value = "/B0000001.do")
	public String b0000001(HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "B0000001").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "B0000001").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "05").put("GROUP_ID", "B0000001").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "B0000001").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("BODY_IMG", BODY_IMG);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG", "BODY_IMG", "BODY_LIST"}, new Boolean[] {false, false, true}, model);
		
		return "home/B0000000/B0000001";
	}
	
	/*
	 * 사용자 섬기는분들 접속
	 */
	@RequestMapping(value = "/B0000002.do")
	public String b0000002(HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "B0000002").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "B0000002").put("USE_YN", "Y").build());
		List<Map<String, Object>> FOOTER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "03").put("GROUP_ID", "B0000002").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "B0000002").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("FOOTER_IMG", FOOTER_IMG.size() > 0 ? FOOTER_IMG.get(0) : null);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG", "FOOTER_IMG", "BODY_LIST"}, new Boolean[] {false, false, true}, model);
		
		return "home/B0000000/B0000002";
	}
	
	/*
	 * 사용자 오시는길 접속
	 */
	@RequestMapping(value = "/B0000003.do")
	public String b0000003(HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "B0000003").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "B0000003").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "B0000003").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG","BODY_LIST"}, new Boolean[] {false, true}, model);
		
		return "home/B0000000/B0000003";
	}	
	
	/*
	 * 사용자 산곡교회연혁 접속
	 */
	@RequestMapping(value = "/B0000004.do")
	public String b0000004(HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "B0000004").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "00").put("GROUP_ID", "B0000004").put("ORDER_BY", "ATTR03 DESC").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "B0000004").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG","BODY_LIST"}, new Boolean[] {false, true}, model);
		
		return "home/B0000000/B0000004";
	}
	
	/*
	 * 사용자 예배시간 접속
	 */
	@RequestMapping(value = "/B0000005.do")
	public String b0000005(HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "B0000005").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "B0000005").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "B0000005").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("BODY", BODY_LIST.size() > 0 ? BODY_LIST.get(0) : null);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG", "BODY"}, new Boolean[] {false, false}, model);
		
		return "home/B0000000/B0000005";
	}
	
	/*
	 * 사용자 주일예배 접속
	 */
	@RequestMapping(value = "/C0000001.do")
	public String c0000001(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "C0000001").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "C0000001").build()).get("MENU_NM").toString();
		
		debug("[ADMIN PAGE PARAMS] " + params);
		params.put("USE_YN", "Y");
		params.put("ORDER_BY", "ATTR03 DESC");

		this.setBoardListInitParams(params, model);
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG"}, new Boolean[] {false}, model);
		
		return "home/C0000000/C0000001";
	}
	
	/*
	 * 사용자 경배찬양 접속
	 */
	@RequestMapping(value = "/C0000002.do")
	public String c0000002(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "C0000002").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "C0000002").build()).get("MENU_NM").toString();
		
		debug("[ADMIN PAGE PARAMS] " + params);
		params.put("USE_YN", "Y");
		params.put("ORDER_BY", "ATTR03 DESC");

		this.setBoardListInitParams(params, model);
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG"}, new Boolean[] {false}, model);
		
		return "home/C0000000/C0000002";
	}
	
	/*
	 * 사용자 기타행사 접속
	 */
	@RequestMapping(value = "/C0000003.do")
	public String c0000003(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "C0000003").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "C0000003").build()).get("MENU_NM").toString();
		
		debug("[ADMIN PAGE PARAMS] " + params);
		params.put("USE_YN", "Y");
		params.put("ORDER_BY", "ATTR03 DESC");

		this.setBoardListInitParams(params, model);
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG"}, new Boolean[] {false}, model);
		
		return "home/C0000000/C0000003";
	}	
	
	/*
	 * 사용자 교회학교(영상) 접속
	 */
	@RequestMapping(value = "/D0000001.do")
	public String d0000001(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "D0000001").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "D0000001").build()).get("MENU_NM").toString();
		
		debug("[ADMIN PAGE PARAMS] " + params);
		params.put("USE_YN", "Y");
		params.put("ORDER_BY", "ATTR03 DESC");
		
		this.setBoardListInitParams(params, model);
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG"}, new Boolean[] {false}, model);
		
		return "home/D0000000/D0000001";
	}
	
	/*
	 * 서브 리스트 페이지 확인 및 리턴
	 */
	private String subListPage(String GroupId, Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {
		String subPage = request.getParameter("SUB");
		if (JStr.isStr(subPage)) {
			
			List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", GroupId).put("USE_YN", "Y").build());
			String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", GroupId).build()).get("MENU_NM").toString();
			
			debug("[ADMIN PAGE PARAMS] " + params);
			params.put("USE_YN", "Y");
			params.put("ORDER_BY", "ATTR03 DESC");

			this.setBoardListInitParams(params, model);
			
			model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
			model.addAttribute("TITLE", title);
			
			return "home/" + GroupId.substring(0, 1) + "0000000/" + subPage;
		}
		return null;
	}
	
	/*
	 * 사용자 어린이부 접속
	 */
	@RequestMapping(value = "/D0000002.do")
	public String d0000002(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		String subPage = this.subListPage("D0000002", params, request, model);
		if (JStr.isStr(subPage)) {
			return subPage;
		}
		
		List<Map<String, Object>> ROLLING_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "06").put("GROUP_ID", "D0000002").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		List<Map<String, Object>> TEXT_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "07").put("GROUP_ID", "D0000002").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "D0000002").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		List<Map<String, Object>> BOARD_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "00").put("GROUP_ID", "D0000002").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		List<Map<String, Object>> FOOTER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "03").put("GROUP_ID", "D0000002").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "05").put("GROUP_ID", "D0000002").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "D0000002").build()).get("MENU_NM").toString();
		
		model.addAttribute("ROLLING_IMG", ROLLING_IMG);
		model.addAttribute("TEXT_LIST", TEXT_LIST);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("BOARD_LIST", BOARD_LIST);
		model.addAttribute("FOOTER_IMG", FOOTER_IMG.size() > 0 ? FOOTER_IMG.get(0) : null);
		model.addAttribute("BODY_IMG", BODY_IMG.size() > 0 ? BODY_IMG.get(0) : null);
		model.addAttribute("TITLE", title);
		
		return "home/D0000000/D0000002";
	}
	
	/*
	 * 사용자 중고등부 접속
	 */
	@RequestMapping(value = "/D0000003.do")
	public String d0000003(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		String subPage = this.subListPage("D0000003", params, request, model);
		if (JStr.isStr(subPage)) {
			return subPage;
		}
		
		List<Map<String, Object>> ROLLING_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "06").put("GROUP_ID", "D0000003").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		List<Map<String, Object>> TEXT_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "07").put("GROUP_ID", "D0000003").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "D0000003").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		List<Map<String, Object>> BOARD_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "00").put("GROUP_ID", "D0000003").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		List<Map<String, Object>> FOOTER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "03").put("GROUP_ID", "D0000003").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "05").put("GROUP_ID", "D0000003").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "D0000003").build()).get("MENU_NM").toString();
		
		model.addAttribute("ROLLING_IMG", ROLLING_IMG);
		model.addAttribute("TEXT_LIST", TEXT_LIST);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("BOARD_LIST", BOARD_LIST);
		model.addAttribute("FOOTER_IMG", FOOTER_IMG.size() > 0 ? FOOTER_IMG.get(0) : null);
		model.addAttribute("BODY_IMG", BODY_IMG.size() > 0 ? BODY_IMG.get(0) : null);
		model.addAttribute("TITLE", title);
		
		return "home/D0000000/D0000003";
	}
	
	/*
	 * 사용자 청년부 접속
	 */
	@RequestMapping(value = "/D0000004.do")
	public String d0000004(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		String subPage = this.subListPage("D0000004", params, request, model);
		if (JStr.isStr(subPage)) {
			return subPage;
		}
		
		List<Map<String, Object>> ROLLING_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "06").put("GROUP_ID", "D0000004").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		List<Map<String, Object>> TEXT_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "07").put("GROUP_ID", "D0000004").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "D0000004").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		List<Map<String, Object>> BOARD_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "00").put("GROUP_ID", "D0000004").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		List<Map<String, Object>> FOOTER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "03").put("GROUP_ID", "D0000004").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "05").put("GROUP_ID", "D0000004").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "D0000004").build()).get("MENU_NM").toString();
		
		model.addAttribute("ROLLING_IMG", ROLLING_IMG);
		model.addAttribute("TEXT_LIST", TEXT_LIST);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("BOARD_LIST", BOARD_LIST);
		model.addAttribute("FOOTER_IMG", FOOTER_IMG.size() > 0 ? FOOTER_IMG.get(0) : null);
		model.addAttribute("BODY_IMG", BODY_IMG.size() > 0 ? BODY_IMG.get(0) : null);
		model.addAttribute("TITLE", title);
		
		return "home/D0000000/D0000004";
	}
	
	/*
	 * 사용자 온라인주보 접속
	 */
	@RequestMapping(value = "/E0000001.do")
	public String e0000001(HttpServletRequest request, @RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "E0000001").put("USE_YN", "Y").build());
		params.put("ORDER_BY", "ATTR05 DESC");
		params.put("USE_YN", "Y");
		
		this.setBoardListInitParams(params, model);
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "E0000001").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG"}, new Boolean[] {false}, model);
		
		return "home/E0000000/E0000001";
	}	
	
	/*
	 * 사용자 새각족 접속
	 */
	@RequestMapping(value = "/E0000002.do")
	public String e0000002(HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "E0000002").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "05").put("GROUP_ID", "E0000002").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "E0000002").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
		List<Map<String, Object>> DISP_Y_LIST = webService.getMapper().selectDispYnBoard(JMap.instance("GROUP_ID", "E0000002").put("TAG_CD", "00").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "E0000002").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("BODY_IMG", BODY_IMG.size() > 0 ? BODY_IMG.get(0) : null);
		model.addAttribute("BODY_LIST", BODY_LIST);
		model.addAttribute("DISP_Y_LIST", DISP_Y_LIST);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG","BODY_IMG","BODY_LIST"}, new Boolean[] {false, false, true}, model);
		
		return "home/E0000000/E0000002";
	}
	
	/*
	 * 사용자 공지사항 접속
	 */
	@RequestMapping(value = "/E0000003.do")
	public String e0000003(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "E0000003").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "E0000003").build()).get("MENU_NM").toString();
		
		debug("[ADMIN PAGE PARAMS] " + params);
		params.put("USE_YN", "Y");
		params.put("ORDER_BY", "REG_DT DESC");

		this.setBoardListInitParams(params, model);
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG"}, new Boolean[] {false}, model);
		
		return "home/E0000000/E0000003";
	}
	
	/*
	 * 사용자 겔러리 접속
	 */
	@RequestMapping(value = "/E0000004.do")
	public String e0000004(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "E0000004").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "05").put("GROUP_ID", "E0000004").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "E0000004").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
//		List<Map<String, Object>> DISP_Y_LIST = webService.getMapper().selectDispYnBoard(JMap.instance("GROUP_ID", "E0000004").put("TAG_CD", "00").build());
		this.setBoardGalaryInitParams(params, model);
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "E0000004").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("BODY_IMG", BODY_IMG.size() > 0 ? BODY_IMG.get(0) : null);
		model.addAttribute("BODY_LIST", BODY_LIST);
//		model.addAttribute("DISP_Y_LIST", DISP_Y_LIST);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG","BODY_IMG","BODY_LIST"}, new Boolean[] {false, false, true}, model);
		
		return "home/E0000000/E0000004";
	}
	
	/*
	 * 사용자 바자회 접속
	 */
	@RequestMapping(value = "/X0000001.do")
	public String x0000001(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "X0000001").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "05").put("GROUP_ID", "X0000001").put("USE_YN", "Y").build());
//		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "X0000001").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
//		List<Map<String, Object>> DISP_Y_LIST = webService.getMapper().selectDispYnBoard(JMap.instance("GROUP_ID", "E0000004").put("TAG_CD", "00").build());
		this.setBoardGalaryInitParams(params, model);
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "X0000001").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("BODY_IMG", BODY_IMG.size() > 0 ? BODY_IMG.get(0) : null);
//		model.addAttribute("BODY_LIST", BODY_LIST);
//		model.addAttribute("DISP_Y_LIST", DISP_Y_LIST);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG","BODY_IMG","BODY_LIST"}, new Boolean[] {false, false, true}, model);
		
		return "home/X0000000/X0000001";
	}	
	
	/*
	 * 사용자 세미나 접속
	 */
	@RequestMapping(value = "/F0000001.do")
	public String f0000001(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "F0000001").put("USE_YN", "Y").build());
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "F0000001").build()).get("MENU_NM").toString();
		
		debug("[ADMIN PAGE PARAMS] " + params);
		params.put("USE_YN", "Y");
		params.put("ORDER_BY", "ATTR03 DESC");
		
		this.setBoardListInitParams(params, model);
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG"}, new Boolean[] {false}, model);
		
		return "home/F0000000/F0000001";
	}
	
	/*
	 * 사용자 목장모임 접속
	 */
	@RequestMapping(value = "/F0000002.do")
	public String f0000002(@RequestParam Map<String, Object> params, HttpServletRequest request, ModelMap model) throws Exception {
		accessLog(request);
		this.commProcessMenuHighlight(request, model);
		this.commProcessSetMenu(true, model);
		
		List<Map<String, Object>> HEADER_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "01").put("GROUP_ID", "F0000002").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_IMG = webService.selectBoardDtl(JMap.instance("TAG_CD", "05").put("GROUP_ID", "F0000002").put("USE_YN", "Y").build());
		List<Map<String, Object>> BODY_LIST = webService.selectBoardDtl(JMap.instance("TAG_CD", "02").put("GROUP_ID", "F0000002").put("USE_YN", "Y").put("ORDER_BY", "ATTR03 DESC").build());
//		List<Map<String, Object>> DISP_Y_LIST = webService.getMapper().selectDispYnBoard(JMap.instance("GROUP_ID", "E0000004").put("TAG_CD", "00").build());
		this.setBoardGalaryInitParams(params, model);
		String title = webService.getMapper().selectTitle(JMap.instance("MENU_ID", "F0000002").build()).get("MENU_NM").toString();
		
		model.addAttribute("HEADER_IMG", HEADER_IMG.size() > 0 ? HEADER_IMG.get(0) : null);
		model.addAttribute("BODY_IMG", BODY_IMG.size() > 0 ? BODY_IMG.get(0) : null);
		model.addAttribute("BODY_LIST", BODY_LIST);
//		model.addAttribute("DISP_Y_LIST", DISP_Y_LIST);
		model.addAttribute("TITLE", title);
//		commProcessEscapeBoard(new String[] {"HEADER_IMG","BODY_IMG","BODY_LIST"}, new Boolean[] {false, false, true}, model);
		
		return "home/F0000000/F0000002";
	}	
	
	/*
	 * 관리자 로그인 접속
	 */
	@RequestMapping(value = "/admin/login.do")
	public String adminLogin(@RequestParam(required = false, name = "LOGIN_YN") String loginYn, ModelMap model, HttpServletRequest request) throws Exception {
		accessLog(request);
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
		
		List<Map<String, Object>> menuList = webService.selectMenuByTree(false);
		List<Map<String, Object>> countList = webService.getMapper().selectVisitCnt(null);
		model.addAttribute("MENU_LIST", menuList);
		model.addAttribute("COUNT_LIST", countList);
		
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
	 * JSON 요청처리
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
		
		List<Map<String, Object>> mainMenuList = webService.selectMenuByTree(false);
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
	 * 상위메뉴를 수정한다.
	 */
	@RequestMapping(value = "/admin/menu/saveMainMenu.do")
	public String saveMainMenu(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		webService.updateMainMenu(params);
		
		return "redirect:/admin/menu/mainMenuMng.do";
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
	 * 게시판 삭제
	 */
	@RequestMapping(value = "/admin/board/delete.do")
	public String deleteBoard(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		debug(params);
		webService.deleteBoard(params);
		
//		String isAdminIfrmPage = params.get("IS_ADMIN_IFRM_PAGE").toString();
//		if ("N".equalsIgnoreCase(isAdminIfrmPage)) {
			return "redirect:/admin/adminPage.do?CURR_PAGE=" + params.get("CURR_PAGE")
				+ "&PAGE=" + params.get("PAGE")
				+ "&GROUP_ID=" + JStr.ifNull(params.get("GROUP_ID"), "");
//		} else {
//			return "redirect:/admin/adminIfrmPage.do?CURR_PAGE=" + params.get("CURR_PAGE")
//				+ "&PAGE=" + params.get("PAGE")
//				+ "&TAG_CD=" + params.get("TAG_CD")
//				+ "&GROUP_ID=" + JStr.ifNull(params.get("GROUP_ID"), "");			
//		}
	}	
	
	/*
	 * 게시판 활성비활성
	 */
	@RequestMapping(value = "/admin/board/useYn.do")
	public String updateUseYnBoard(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		debug(params);
		webService.getMapper().updateUseYnBoard(params);
		
		return "redirect:/admin/adminPage.do?CURR_PAGE=" + params.get("CURR_PAGE")
			+ "&PAGE=" + params.get("PAGE")
			+ "&GROUP_ID=" + JStr.ifNull(params.get("GROUP_ID"), "");
	}
	
	/*
	 * 게시판 메인노출토글
	 */
	@RequestMapping(value = "/admin/board/showYn.do")
	public String updateMainDispYnBoard(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		debug(params);
		webService.getMapper().updateMainDispYnBoard(params);
		
		return "redirect:/admin/adminPage.do?CURR_PAGE=" + params.get("CURR_PAGE")
		+ "&PAGE=" + params.get("PAGE")
		+ "&GROUP_ID=" + JStr.ifNull(params.get("GROUP_ID"), "");
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
		
		switch ((String)params.get("GROUP_ID")) {
		case "B0000004" :
		case "C0000001" :
		case "C0000002" :
		case "C0000003" :
		case "D0000001" :
		case "D0000002" :
		case "D0000003" :
		case "D0000004" :	
		case "E0000001" :
		case "E0000002" :
		case "E0000003" :
		case "E0000004" :
		case "F0000001" :
		case "F0000002" :
			params.put("ORDER_BY", "SCREEN_YN DESC, ATTR03 DESC");
			break;
		default:
			params.put("ORDER_BY", "SCREEN_YN DESC, ORD_NO ASC");
		}
		
		this.commSetTitle(params.get("PAGE").toString(), model);
		String jspAdminPage = params.get("PAGE").toString();
		this.setBoardListInitParams(params, model);
		
		String url = "admin/" + jspAdminPage.substring(0, 1) + "0000000/" + jspAdminPage;
		System.out.println(url);
		
		return url;
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
	 * 성경구절 또는 찬송가 조회
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
	 * 성경구절 또는 찬송가 조회
	 */
	@RequestMapping(value = "/popMsg.do")
	public String popMsg(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		params.put("TAG_CD", "00");
		params.put("USE_YN", "Y");
		debug(params);
		List<Map<String, Object>> POP_MSG = webService.selectBoardDtl(params);
		if (POP_MSG != null && POP_MSG.size() > 0) {
			model.addAttribute("title", POP_MSG.get(0).get("SUBJECT"));
			model.addAttribute("content", POP_MSG.get(0).get("CONTENT").toString().replaceFirst("<h1>.+</h1>", ""));
		}
		
		return "jsonView";
	}	
	
	/*
	 * JSON 바자회 구매
	 */
	@ResponseBody
	@RequestMapping(value = "/bazaarPurchase.do")
	public Map<String, Object> jsonTest(@RequestBody Map<String, Object> params) throws Exception {
		
		debug(params);
		webService.updateBazaar(params);
		
		return JMap.instance("result", "N".equals(params.get("IS_PURCHASED")) ? "1" : "0").build();
		
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
					
					// 이미지 리싸이즈 처리
					if (JIMG.saveToResizeImage(mf, 0, 0, 0f, file) == false) {
						mf.transferTo(file);						
					}
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
	
	/*
	 * 주보파일 저장
	 */
	@RequestMapping(value = "/admin/weekly/save.do")
	public String weeklySave(@RequestParam("W_FILE_NM") MultipartFile file1
			, @RequestParam("W_STYL_NM") MultipartFile file2
			, @RequestParam("GROUP_ID") String groupId
			, @RequestParam("PAGE") String page
			, ModelMap model) throws Exception {
		
		final String weeklyRealPath = messageSourceAccessor.getMessage("path.file.weekly");
		String originalFileName1 = file1.getOriginalFilename();
		String originalFileName2 = file2.getOriginalFilename();
		
		webService.getMapper().updateBoard(
				JMap.instance("RTN_MSG", "")
				.put("DEL_YN", null)
				.put("SUBJECT", JStr.formatDateStr(originalFileName1, "-") + " 주보")
				.put("CONTENT", "")
				.put("GROUP_ID", groupId)
				.put("SEQ_NO", null)
				.put("SCREEN_YN", "N")
				.put("DEPTH_NO", null)
				.put("ORD_NO", null)
				.put("USE_YN", "Y")
				.put("USER_ID", "SYSTEM")
				.put("TAG_CD", "00")
				.put("MAIN_DISP_YN", "N")
				.put("ATTR01", "/images/weekly_sign2.webp")
				.put("ATTR02", null)
				.put("ATTR03", JStr.formatDateStr(new Date(), null))
				.put("ATTR04", null)
				.put("ATTR05", "/weekly/"+originalFileName1)
				.build());
		
		//File newFile1 = new File(weeklyRealPath + originalFileName1);
		File newFile2 = new File(weeklyRealPath + originalFileName2);
		
		JStr.saveFileWithReplaceStr(file1.getBytes()
				, new String[] {"<body><div class=\"hpa\" style=\"width:380mm;height:210mm;\">", "<div class=\"hpa\" style=\"width:380mm;height:210mm;\">"}
				, new String[] {"<body><div class=\"hpa\" style=\"width:380mm;height:210mm;\"><img src=\"/images/weekly_out_bg2.webp\" style=\"position: absolute; width:100%\">", "<div class=\"hpa\" style=\"width:380mm;height:210mm;\"><img src=\"/images/weekly_in_bg.webp\" style=\"position: absolute; width:100%\">"}
				, weeklyRealPath + originalFileName1);
		
		//file1.transferTo(newFile1);
		file2.transferTo(newFile2);
		
		return "redirect:/admin/adminPage.do"+"?PAGE="+page+"&GROUP_ID="+groupId;
	}
	
	/*
	 * 해당 코드그룹의 코드조회
	 */
	@RequestMapping(value = "/admin/score/scoreMng.do")
	public String scoreMng(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		params.put("BLOCK_START", 0);
		params.put("BLOCK_END", 0);
		params.put("TOTAL_PAGE", 0);
		params.put("TOTAL_BLOCK", 0);
		params.put("START_NUM", 0);		
		
		if (JNum.isInteger(params.get("CURR_PAGE")) == false) {
			params.put("CURR_PAGE", 1);
		}
		if (JStr.isStr(params.get("SUBJECT")) == false) {
			params.put("SUBJECT", null);
		}
		if (JStr.isStr(params.get("S_KEY")) == false) {
			params.put("S_KEY", null);
		}
		
		List<Map<String, Object>> list = webService.getMapper().selectScoreList(params);
		
		model.addAttribute("TITLE", "악보관리");
		model.addAttribute("SCORE_LIST", list);
		model.addAttribute("PAGE_CTL", params);
		
		return "admin/score/scoreMng";
	}	
	
	/*
	 * 악보 저장
	 */
	@RequestMapping(value = "/admin/score/save.do")
	public String saveScore(HttpServletRequest request
			, @RequestParam(name="FILE", required=false) MultipartFile sFile
			, @RequestParam("SUBJECT") String subject
			, @RequestParam("S_KEY") String sKey
			, @RequestParam("URL") String url
			, @RequestParam(name="LYRICS", required=false) String lyrics
			, ModelMap model) throws Exception {
		
		
		if (sFile != null && JStr.isStr(sFile.getOriginalFilename())) {
			
			final String imgRealPath = messageSourceAccessor.getMessage("path.image.score");
			final String imgUrlPath = request.getContextPath().concat("/images/score/");
			
			String originFileName = sFile.getOriginalFilename();
			debug("[originFileName] " + originFileName);
			String ext = FilenameUtils.getExtension(originFileName);
			String newlnfImgFileName = "score_" + sKey + "_" + ((new Random()).nextInt(900) + 100) + "." + ext;
			url = imgUrlPath + newlnfImgFileName;
			File file = new File(imgRealPath + newlnfImgFileName);
			
			// 이미지 리싸이즈 처리
			if (JIMG.saveToResizeImage(sFile, 0, 0, 0f, file) == false) {
				sFile.transferTo(file);						
			}
			
		}
		webService.getMapper().insertScore(JMap.instance("SUBJECT", subject).put("S_KEY", sKey).put("URL", url).put("LYRICS", lyrics).build());
		
		return "redirect:/admin/score/scoreMng.do";
	}
	
	/*
	 * 악보 삭제
	 */
	@RequestMapping(value = "/admin/score/delete.do")
	public String deleteScore(@RequestParam Map<String, Object> params, ModelMap model) throws Exception {
		
		debug(params);
		webService.getMapper().deleteScore(params);
		
		return "redirect:/admin/score/scoreMng.do?CURR_PAGE=" + params.get("CURR_PAGE")
			+ "&SUBJECT=" + JStr.ifNull(params.get("SUBJECT"), "")
			+ "&S_KEY=" + JStr.ifNull(params.get("S_KEY"), "");
	}	
	
}
