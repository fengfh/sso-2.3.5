/**
 * This file created at 2011-12-28.
 *
 * Copyright (c) 2002-2011 Bingosoft, Inc. All rights reserved.
 */
package bingo.web.filter;

import java.io.IOException;
import java.util.Enumeration;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import bingo.common.core.utils.StringUtils;

/**
 * <code>{@link ResponseHeaderFilter}</code>
 *
 * 阻止缓存的Filter
 *
 * @author zhongtao
 */
public class ResponseHeaderFilter implements Filter {
	private static final Logger log = LoggerFactory.getLogger(ResponseHeaderFilter.class);
	private static final String ignorePatternInitParamName = "ignorePattern";
	private FilterConfig filterConfig;
	private String ignorePatternString;
	private Pattern ignorePattern;

	/* (non-Javadoc)
	 * @see javax.servlet.Filter#destroy()
	 */
	public void destroy() {
		this.filterConfig = null;
	}

	/* (non-Javadoc)
	 * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest, javax.servlet.ServletResponse, javax.servlet.FilterChain)
	 */
	@SuppressWarnings("unchecked")
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

		if ("".equals(path)) {
			path = "/";
		}
		
		if (ignores(path)) {
			chain.doFilter(request, response);
			return;
		}
		
		HttpServletResponse localHttpServletResponse = (HttpServletResponse) response;
		Enumeration localEnumeration = this.filterConfig.getInitParameterNames();
		while (localEnumeration.hasMoreElements()) {
			//每一个通过这个filter的请求，filter都将<init-param>的参数值赋值到响应的header中
			String name = (String) localEnumeration.nextElement();
			if (!ignorePatternInitParamName.equalsIgnoreCase(name)) {
				localHttpServletResponse.addHeader(name, this.filterConfig.getInitParameter(name));
			} else {
				setIgnorePattern(this.filterConfig.getInitParameter(name));
			}
		}
		chain.doFilter(request, localHttpServletResponse);
	}

	protected boolean ignores(String path) {
		if (ignorePattern != null) {
			return ignorePattern.matcher(path).matches();
		}
		return false;
	}

	/* (non-Javadoc)
	 * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
	 */
	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}

	/**
	 * @return the ignorePatternString
	 */
	public String getIgnorePatternString() {
		return ignorePatternString;
	}

	/**
	 * @param ignorePatternString the ignorePatternString to set
	 */
	public void setIgnorePatternString(String ignorePatternString) {
		this.ignorePatternString = ignorePatternString;
		setIgnorePattern(this.ignorePatternString);
	}

	/**
	 * @return the ignorePattern
	 */
	public Pattern getIgnorePattern() {
		return ignorePattern;
	}

	/**
	 * @param ignorePatternString the ignorePattern to set
	 */
	public void setIgnorePattern(String ignorePatternString) {
		if (StringUtils.isNotEmpty(ignorePatternString)) {
			ignorePatternString = ignorePatternString.replaceAll("\\.", "\\\\."); //替换 . 为正则表达式的写法 \. //$NON-NLS-1$ //$NON-NLS-2$
			ignorePatternString = ignorePatternString.replaceAll("\\*", ".*"); //替换 * 为正则表达式的写法 .*  //$NON-NLS-1$ //$NON-NLS-2$

			log.debug("ignore-pattern regex : {}", ignorePatternString);

			ignorePattern = Pattern.compile(ignorePatternString);
		}
	}
}