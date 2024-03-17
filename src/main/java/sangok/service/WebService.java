package sangok.service;

import java.util.List;
import java.util.Map;

import sangok.service.impl.WebMapper;

public interface WebService {
	
	WebMapper getMapper();

	List<Map<String, Object>> selectMenu(Map<String, Object> params) throws Exception;
	
	void updateSubMenu(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectMenuByTree() throws Exception;
	
	List<Map<String, Object>> selectCode(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectCodeGroup(Map<String, Object> params) throws Exception;
	
	void updateBoard(Map<String, Object> params) throws Exception;
	
	void deleteBoard(Map<String, Object> params) throws Exception;
	
	void updateCodeGroup(Map<String, Object> params) throws Exception;
	
	void updateCode(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectBoardList(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectBoardDtl(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectBoardDtlByTag(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectUser(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectUserAuth(Map<String, Object> params) throws Exception;
	
	void updateUserAuth(List<Map<String, Object>> params) throws Exception;
	
	void updateUser(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectBibleAndHymn(Map<String, Object> params) throws Exception;
	
}
