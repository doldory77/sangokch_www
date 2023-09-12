package sangok.service.impl;

import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.mapper.Mapper;

@Mapper("webMapper")
public interface WebMapper {

	List<Map<String, Object>> selectCode(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectMenuBySP(Map<String, Object> params) throws Exception;
	
	void updateBoard(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectBoardList(Map<String, Object> params) throws Exception;
	
	Map<String, Object> selectBoardDtl(Map<String, Object> params) throws Exception;

}
