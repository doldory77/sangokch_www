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
	
	Pattern imgPattern = Pattern.compile("\"(/images/board/img_.*[.].{3})\"");
	
	@Autowired
	WebMapper webMapper;
	
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
	public List<Map<String, Object>> selectMenuByTree() throws Exception {
		try {
			List<Map<String, Object>> menuLvl1 = webMapper.selectMenuByParentId(JMap.instance("PARENT_MENU_ID", "00000000").build());
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
			String stdImgPath = JStr.extractStr(imgPattern, JStr.toStr(params.get("CONTENT")));
			params.put("ATTR01", stdImgPath);
			
			webMapper.updateBoard(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"updateBoard",e.getMessage()});
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
	public Map<String, Object> selectBoardDtl(Map<String, Object> params) throws Exception {
		try {
			if (JStr.isStr(params.get("GROUP_ID")) == false) params.put("GROUP_ID", null);
			if (JNum.isInteger(params.get("SEQ_NO")) == false) params.put("SEQ_NO", 0);
			return webMapper.selectBoardDtl(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw processException("fail.common.sql", new String[]{"selectBoardDtl",e.getMessage()});
		}
	}

}
