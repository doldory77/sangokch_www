package sangok.utils;

public class JNum {

	public static boolean isInteger(Object obj) {
		try {
			Integer.parseInt(String.valueOf(obj));
			return true;
		} catch (NullPointerException e) {
			return false;
		} catch (NumberFormatException e) {
			return false;
		}
	}
	
	public static boolean isLong(Object obj) {
		try {
			Long.parseLong(String.valueOf(obj));
			return true;
		} catch (NullPointerException e) {
			return false;
		} catch (NumberFormatException e) {
			return false;
		}
	}
	
	public static boolean isFloat(Object obj) {
		try {
			Float.parseFloat(String.valueOf(obj));
			return true;
		} catch (NullPointerException e) {
			return false;
		} catch (NumberFormatException e) {
			return false;
		}
	}
	
	public static boolean isDouble(Object obj) {
		try {
			Double.parseDouble(String.valueOf(obj));
			return true;
		} catch (NullPointerException e) {
			return false;
		} catch (NumberFormatException e) {
			return false;
		}
	}
}
