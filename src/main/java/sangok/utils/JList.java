package sangok.utils;

import java.util.List;
import java.util.Map;

public class JList {

	public static Map<String, Object> get(List<Map<String, Object>> refList, int idx) {
		if (refList != null && (idx >= 0 && idx < refList.size())) {
			return refList.get(idx);
		}
		return null;
	}
}
