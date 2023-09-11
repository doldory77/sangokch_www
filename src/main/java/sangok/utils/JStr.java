package sangok.utils;

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
}
