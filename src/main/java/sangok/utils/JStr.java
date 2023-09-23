package sangok.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class JStr {

	public static String toStr(Object obj) {
		if (obj != null) {
			return obj.toString();
		} else {
			return null;
		}
	}
	
	public static boolean isStr(Object obj) {
		if (obj == null) return false;
		if (String.valueOf(obj).length() < 1) return false;
		return true;
	}
	
	public static String extractStr(Pattern p, String srcStr) {
		String rtn = null;
		if (isStr(srcStr)) {			
			Matcher m = p.matcher(srcStr);
			if (m.find()) {
				rtn = m.group(0);
			}
		}
		return rtn;
	}
	
	public static String ifNull(Object obj, String defStr) {
		if (isStr(obj)) {
			return obj.toString();
		} else {
			return defStr;
		}
	}
}
