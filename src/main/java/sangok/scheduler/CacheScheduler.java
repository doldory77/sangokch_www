package sangok.scheduler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import sangok.service.impl.WebMapper;
import sangok.utils.JMap;

@Service
public class CacheScheduler {

	@Autowired
	private WebMapper webMapper;
	
	public Map<String, Object> envMap;
	
	public CacheScheduler() {
		envMap = new HashMap<String, Object>();
	}
	
	/*5분마다*/
	@Scheduled(fixedDelay = 3600000)
	public void routin() {
		try {
			List<Map<String, Object>> envMapList = webMapper.selectEnv(JMap.instance("GROUP_ID", "CD0002").build());
			for (int i=0, max=envMapList.size(); i<max; i++) {
				envMap.put(envMapList.get(i).get("CODE").toString(), envMapList.get(i));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
