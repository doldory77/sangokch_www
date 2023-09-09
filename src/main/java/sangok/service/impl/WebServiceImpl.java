package sangok.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import sangok.service.WebService;

@SuppressWarnings("unchecked")
@Service("webService")
public class WebServiceImpl extends EgovAbstractServiceImpl implements WebService {
	
	@Autowired
	WebMapper webMapper;
	
	@Override
	public List<Map<String, Object>> selectMenu(Map<String, Object> params) throws Exception {
		try {
			return (List<Map<String, Object>>) webMapper.selectMenuBySP(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Map<String, Object>> selectCode(Map<String, Object> params) throws Exception {
		try {
			return (List<Map<String, Object>>) webMapper.selectCode(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void updateBoard(Map<String, Object> params) throws Exception {
		try {
			//webMapper.update("updateBoard", params);
			webMapper.updateBoard(params);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
