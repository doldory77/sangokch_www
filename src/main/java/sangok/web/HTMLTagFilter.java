package sangok.web;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import egovframework.rte.ptl.mvc.filter.HTMLTagFilterRequestWrapper;

public class HTMLTagFilter implements Filter {
	
	private FilterConfig config;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		this.config = filterConfig;

	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		if (checkUrl(req)) {
			chain.doFilter(request, response);
		} else {
			chain.doFilter(new HTMLTagFilterRequestWrapper((HttpServletRequest)request), response);
		}

	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub

	}
	
	private boolean checkUrl(HttpServletRequest req) {
		String uri = req.getRequestURI().toString().trim();
		if (uri.startsWith("/admin/") || uri.startsWith("/mng/")) {
			return true;
		} else {
			return false;
		}
	}

}
