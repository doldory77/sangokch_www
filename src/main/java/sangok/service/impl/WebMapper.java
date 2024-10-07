package sangok.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("webMapper")
public interface WebMapper {

	List<Map<String, Object>> selectCode(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectCodeGroup(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectMenuByParentId(Map<String, Object> params) throws Exception;
	
	void updateMainMenu(Map<String, Object> params) throws Exception;
	
	void updateSubMenu(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectMenuBySP(Map<String, Object> params) throws Exception;
	
	void updateBoard(Map<String, Object> params) throws Exception;
	
	void deleteBoard(Map<String, Object> params) throws Exception;
	
	void updateCodeGroup(Map<String, Object> params) throws Exception;
	
	void updateCode(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectBoardList(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectBoardGalary(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectBoardDtl(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectBoardDtlByTag(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectUser(Map<String, Object> params) throws Exception;
	
	void updateUser(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectUserAuth(Map<String, Object> params) throws Exception;
	
	void updateUserAuth(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectBible(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectHymn(Map<String, Object> params) throws Exception;
	
	Map<String, Object> selectUserByIdPw(Map<String, Object> params) throws Exception;
	
	Map<String, Object> selectMenuNm(String menuId) throws Exception;
	
	List<Map<String, Object>> selectEnv(Map<String, Object> params) throws Exception;
	
	Map<String, Object> selectTitle(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectDispYnBoard(Map<String, Object> params) throws Exception;
	
	void insertAccessLog(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectVisitCnt(Map<String, Object> params) throws Exception;
	
	void updateBazaar(Map<String, Object> params) throws Exception;
	
	Map<String, Object> isPurchase(Map<String, Object> params) throws Exception;
	
	void insertScore(Map<String, Object> params) throws Exception;
	
	void deleteScore(Map<String, Object> params) throws Exception;
	
	void updateUseYnBoard(Map<String, Object> params) throws Exception;
	
	void updateMainDispYnBoard(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectScoreList(Map<String, Object> params) throws Exception;
}
