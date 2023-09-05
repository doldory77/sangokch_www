package sangok.service;

import java.util.List;
import java.util.Map;

public interface WebService {

	List<Map<String, Object>> selectMenu(Map<String, Object> params) throws Exception;
	
	List<Map<String, Object>> selectCode(Map<String, Object> params) throws Exception;
}
