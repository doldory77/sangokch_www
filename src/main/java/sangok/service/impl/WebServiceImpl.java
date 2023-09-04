package sangok.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import sangok.service.WebService;

@Service("webService")
public class WebServiceImpl extends EgovAbstractServiceImpl implements WebService {

	@Resource(name = "webDAO")
	private WebDAO webDAO;
	
	@Override
	public List<Map<String, Object>> selectMenu(Map<String, Object> params) throws Exception {
		return webDAO.selectMenu(params); 
	}

}
