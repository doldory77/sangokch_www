package sangok.service;

import java.util.List;
import java.util.Map;

public interface WebService {

	List<Map<String, Object>> selectMenu(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectMenuByTree() throws Exception;
	
	List<Map<String, Object>> selectCode(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectCodeGroup(Map<String, Object> params) throws Exception;
	
	void updateBoard(Map<String, Object> params) throws Exception;
	
	void updateCodeGroup(Map<String, Object> params) throws Exception;
	
	void updateCode(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectBoardList(Map<String, Object> params) throws Exception;
	
	Map<String, Object> selectBoardDtl(Map<String, Object> params) throws Exception;
	
	Map<String, Object> selectBoardDtl2(Map<String, Object> params) throws Exception;
	
}
