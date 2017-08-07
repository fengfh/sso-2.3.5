package bingo.sso.server.web;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

/**
 * <code>{@link AccessHostConvertFilter}</code>
 * 
 * TODO : document me
 * 
 * @author yohn
 */
public class AccessHostConvertFilter implements Filter {
	private static String INIT_PARAM_HOST = "host";
	private static String INIT_PARAM_PORT = "port";

	private String hostConf;
	private String portConf;
	private String serverConf;

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.Filter#destroy()
	 */
	public void destroy() {
		// TODO implement AccessHostConvertFilter.destroy

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest,
	 * javax.servlet.ServletResponse, javax.servlet.FilterChain)
	 */
	public void doFilter(ServletRequest arg0, ServletResponse arg1,
			FilterChain arg2) throws IOException, ServletException {

		arg2.doFilter(new HttpServletRequestHostWrapper(
				(HttpServletRequest) arg0), arg1);

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
	 */
	public void init(FilterConfig arg0) throws ServletException {
		// TODO implement AccessHostConvertFilter.init
		hostConf = arg0.getInitParameter(INIT_PARAM_HOST);
		portConf = arg0.getInitParameter(INIT_PARAM_PORT);
		serverConf = hostConf + (portConf == null ? "":":" + portConf);
	}

	/**
	 * <code>{@link HttpServletRequestHostWrapper}</code>
	 * 
	 * TODO : document me
	 * 
	 * @author yohn
	 */
	private class HttpServletRequestHostWrapper extends
			HttpServletRequestWrapper {
		private String host;
		private String port;
		private String server;

		/**
		 * @param request
		 */
		public HttpServletRequestHostWrapper(HttpServletRequest request) {
			super(request);
			if(hostConf != null){
				host = hostConf;
				port = portConf;
				server = serverConf;
			}else{
				//TODO: parse from request
			}
		}
		
		/*
		 * (non-Javadoc)
		 * 
		 * @see
		 * javax.servlet.http.HttpServletRequestWrapper#getHeader(java.lang.
		 * String)
		 */
		@Override
		public String getHeader(String name) {
			return super.getHeader(name);
		}

		/*
		 * (non-Javadoc)
		 * 
		 * @see
		 * javax.servlet.http.HttpServletRequestWrapper#getHeaders(java.lang
		 * .String)
		 */
		@Override
		public Enumeration getHeaders(String name) {
			return super.getHeaders(name);
		}

		/*
		 * (non-Javadoc)
		 * 
		 * @see javax.servlet.http.HttpServletRequestWrapper#getRequestURI()
		 */
		@Override
		public String getRequestURI() {
			return super.getRequestURI();
		}

		/*
		 * (non-Javadoc)
		 * 
		 * @see javax.servlet.http.HttpServletRequestWrapper#getRequestURL()
		 */
		@Override
		public StringBuffer getRequestURL() {
			StringBuffer str = super.getRequestURL();
			int index = str.indexOf("//") + 2;
			int index2 = str.indexOf("/", index);
			
			return str.replace(index, index2, server);
			
		}

		/*
		 * (non-Javadoc)
		 * 
		 * @see javax.servlet.ServletRequestWrapper#getRemoteAddr()
		 */
		@Override
		public String getRemoteAddr() {
			// TODO implement HttpServletRequestHostWrapper.getRemoteAddr
			return super.getRemoteAddr();
		}

		/*
		 * (non-Javadoc)
		 * 
		 * @see javax.servlet.ServletRequestWrapper#getRemoteHost()
		 */
		@Override
		public String getRemoteHost() {
			// TODO implement HttpServletRequestHostWrapper.getRemoteHost
			return super.getRemoteHost();
		}

		/*
		 * (non-Javadoc)
		 * 
		 * @see javax.servlet.ServletRequestWrapper#getRemotePort()
		 */
		@Override
		public int getRemotePort() {
			return super.getRemotePort();
		}

		/*
		 * (non-Javadoc)
		 * 
		 * @see javax.servlet.ServletRequestWrapper#getServerName()
		 */
		@Override
		public String getServerName() {
			return host;
		}

		/*
		 * (non-Javadoc)
		 * 
		 * @see javax.servlet.ServletRequestWrapper#getServerPort()
		 */
		@Override
		public int getServerPort() {
			return Integer.parseInt(port);
		}
	}

}
