package sangok.utils;

import java.util.HashMap;

public class JMap {

	private HashMap<String, Object> map;
	
	private JMap() {
		this.map = new HashMap<String, Object>();
	}
	
	public JMap put(String key, Object item) {
		this.map.put(key, item);
		return this;
	}
	
	public HashMap<String, Object> build() {
		return this.map;
	}
	
	public static JMap instance(String key, Object item) {
		JMap jMap = new JMap();
		return jMap.put(key, item);
	}
}
