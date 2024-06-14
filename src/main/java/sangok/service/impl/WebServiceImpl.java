package sangok.service.impl;

import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import sangok.service.WebService;
import sangok.utils.JMap;
import sangok.utils.JNum;
import sangok.utils.JStr;

@Service("webService")
public class WebServiceImpl extends EgovAbstractServiceImpl implements WebService {
	
	public static Pattern imgPattern = Pattern.compile("\"(/images/board/img_.{36}[.].{3})\"");
	
	@Autowired
	private WebMapper webMapper;
	
	@Override
	public WebMapper getMapper() {
		return webMapper;
	}
	
	@Override
	public List<Map<String, Object>> selectMenu(Map<String, Object> params) throws Exception {
		try {
			return (List<Map<String, Object>>) webMapper.selectMenuBySP(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"selectMenu",e.getMessage()});
		}
	}
	
	@Override
	public void updateSubMenu(Map<String, Object> params) throws Exception {
		try {
			webMapper.updateSubMenu(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"updateSubMenu",e.getMessage()});
		}
	}	
	
	@Override
	public List<Map<String, Object>> selectMenuByTree(boolean isUseY) throws Exception {
		try {
			List<Map<String, Object>> menuLvl1;
			if (isUseY) {
				menuLvl1 = webMapper.selectMenuByParentId(JMap.instance("PARENT_MENU_ID", "00000000").put("USE_YN", "Y").build());
			} else {
				menuLvl1 = webMapper.selectMenuByParentId(JMap.instance("PARENT_MENU_ID", "00000000").build());
			}
			
			for (Map<String, Object> tmpMap : menuLvl1) {
				tmpMap.put("SUB_MENU", webMapper.selectMenuByParentId(JMap.instance("PARENT_MENU_ID", tmpMap.get("MENU_ID")).build()));
			}
			return menuLvl1;
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"selectMenuByTree",e.getMessage()});
		}
	}

	@Override
	public List<Map<String, Object>> selectCode(Map<String, Object> params) throws Exception {
		try {
			return (List<Map<String, Object>>) webMapper.selectCode(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"selectCode",e.getMessage()});
		}
	}
	
	@Override
	public List<Map<String, Object>> selectCodeGroup(Map<String, Object> params) throws Exception {
		try {
			return (List<Map<String, Object>>) webMapper.selectCodeGroup(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"selectCodeGroup",e.getMessage()});
		}
	}
	
	@Override
	public void updateBoard(Map<String, Object> params) throws Exception {
		try {
			//webMapper.update("updateBoard", params);
			if (JStr.isStr(params.get("ORD_NO")) == false) {
				params.put("ORD_NO", "0");
			}
			/*String stdImgPath = JStr.extractStr(imgPattern, JStr.toStr(params.get("CONTENT")));
			params.put("ATTR01", JStr.isStr(stdImgPath) ? stdImgPath.replaceAll("\"", "") : stdImgPath);*/
			
			webMapper.updateBoard(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"updateBoard",e.getMessage()});
		}
	}
	
	@Override
	public void deleteBoard(Map<String, Object> params) throws Exception {
		try {
			
			webMapper.deleteBoard(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"deleteBoard",e.getMessage()});
		}
	}
	
	@Override
	public void updateCodeGroup(Map<String, Object> params) throws Exception {
		try {
			webMapper.updateCodeGroup(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"updateBoard",e.getMessage()});
		}
	}
	
	@Override
	public void updateCode(Map<String, Object> params) throws Exception {
		try {
			webMapper.updateCode(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"updateBoard",e.getMessage()});
		}
	}

	@Override
	public List<Map<String, Object>> selectBoardList(Map<String, Object> params) throws Exception {
		try {
			
			params.put("BLOCK_START", 0);
			params.put("BLOCK_END", 0);
			params.put("TOTAL_PAGE", 0);
			params.put("TOTAL_BLOCK", 0);
			params.put("START_NUM", 0);
			
			return webMapper.selectBoardList(params); 
			
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"selectBoardList",e.getMessage()});
		}
	}
	
	@Override
	public List<Map<String, Object>> selectBoardGalary(Map<String, Object> params) throws Exception {
		try {
			
			params.put("BLOCK_START", 0);
			params.put("BLOCK_END", 0);
			params.put("TOTAL_PAGE", 0);
			params.put("TOTAL_BLOCK", 0);
			params.put("START_NUM", 0);
			
			return webMapper.selectBoardGalary(params); 
			
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"selectBoardGalary",e.getMessage()});
		}
	}

	@Override
	public List<Map<String, Object>> selectBoardDtl(Map<String, Object> params) throws Exception {
		try {
			if (JStr.isStr(params.get("GROUP_ID")) == false) params.put("GROUP_ID", null);
			if (JNum.isInteger(params.get("SEQ_NO")) == false) params.put("SEQ_NO", 0);
			if (JStr.isStr(params.get("TAG_CD")) == false) params.put("TAG_CD", null);
			if (JStr.isStr(params.get("ORDER_BY")) == false) params.put("ORDER_BY", null);
			return webMapper.selectBoardDtl(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"selectBoardDtl",e.getMessage()});
		}
	}
	
	@Override
	public List<Map<String, Object>> selectBoardDtlByTag(Map<String, Object> params) throws Exception {
		try {
			return webMapper.selectBoardDtlByTag(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"selectBoardDtlByTag",e.getMessage()});
		}
	}
	
	@Override
	public List<Map<String, Object>> selectUser(Map<String, Object> params) throws Exception {
		try {
			return (List<Map<String, Object>>) webMapper.selectUser(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"selectUser",e.getMessage()});
		}
	}
	
	@Override
	public List<Map<String, Object>> selectUserAuth(Map<String, Object> params) throws Exception {
		try {
			return (List<Map<String, Object>>) webMapper.selectUserAuth(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"selectUserAuth",e.getMessage()});
		}
	}
	
	@Override
	public void updateUserAuth(List<Map<String, Object>> params) throws Exception {
		try {			
			for (int i=0; i<params.size(); i++) {
				webMapper.updateUserAuth(params.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"updateUserAuth",e.getMessage()});
		}
	}
	
	@Override
	public void updateUser(Map<String, Object> params) throws Exception {
		try {
			if (JStr.isStr(params.get("NEW_PW")) == false) params.put("NEW_PW", null);
			webMapper.updateUser(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"updateBoard",e.getMessage()});
		}
	}

	@Override
	public List<Map<String, Object>> selectBibleAndHymn(Map<String, Object> params) throws Exception {
		if ("bible".equalsIgnoreCase(params.get("DVSN").toString())) {
			return webMapper.selectBible(params);
		} else {
			return webMapper.selectHymn(params);
		}
	}
	
	@Override
	public void updateBazaar(Map<String, Object> params) throws Exception {
		try {
			Map<String, Object> rtnMap = webMapper.isPurchase(params);
			if ((long)rtnMap.get("CNT") > 0) {
				params.putIfAbsent("IS_PURCHASED", "Y");
			} else {
				params.putIfAbsent("IS_PURCHASED", "N");
				webMapper.updateBazaar(params);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"updateBazaar",e.getMessage()});
		}
	}	

}
