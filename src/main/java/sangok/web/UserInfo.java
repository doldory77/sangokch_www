package sangok.web;

import java.util.HashMap;
import java.util.Map;

public class UserInfo {

	private Map<String, Object> authMap;
	private String id;		/*ID*/
	private String admYn;	/*관리자여부*/
	private String useYn;	/*사용유무*/
	private String attr01;	/*기타속성1*/
	
	public UserInfo() {
		authMap = new HashMap<String, Object>();
	}

	public Map<String, Object> getAuthMap() {
		return authMap;
	}

	public void setAuthMap(Map<String, Object> authMap) {
		this.authMap = authMap;
	}

	public String getAdmYn() {
		return admYn;
	}

	public void setAdmYn(String admYn) {
		this.admYn = admYn;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getAttr01() {
		return attr01;
	}

	public void setAttr01(String attr01) {
		this.attr01 = attr01;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	
	

}
