package sangok.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@SuppressWarnings("unchecked")
@Repository("webDAO")
public class WebDAO extends EgovAbstractDAO {

	public List<Map<String, Object>> selectMenu(Map<String, Object> params) throws Exception {
		return (List<Map<String, Object>>) list("selectMenuBySP", params);
	}
	
}
