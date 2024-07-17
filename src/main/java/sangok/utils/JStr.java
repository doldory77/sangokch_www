package sangok.utils;

import java.io.FileWriter;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
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
	
	public static String formatDateStr(String yyyymmdd, String div) {
		if (yyyymmdd != null && yyyymmdd.length() >= 8) {
			return yyyymmdd.substring(0, 4) + div + yyyymmdd.substring(4, 6) + div + yyyymmdd.substring(6, 8);
		}
		return yyyymmdd;
	}
	
	public static String yyyyMMddTHHmiss() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm:ss+09:00");
		Date dt = new Date();
		return sdf.format(dt) + "T" + sdf2.format(dt);
	}
	
	public static void saveFileWithReplaceStr(byte[] srcFileByte, String[] replaceSrc, String[] replaceCotent, String saveFilePath) throws Exception {
		String str = new String(srcFileByte, StandardCharsets.UTF_8);
		for (int i=0; i<replaceSrc.length; i++) {
			str = str.replace(replaceSrc[i], replaceCotent[i]);
		}
		FileWriter fw = new FileWriter(saveFilePath);
		fw.write(str);
		fw.close();
	}
}
