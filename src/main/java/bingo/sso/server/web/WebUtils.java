/**
 * This file created at 2010-8-25.
 *
 * Copyright (c) 2002-2010 Bingosoft, Inc. All rights reserved.
 */
package bingo.sso.server.web;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.support.WebApplicationContextUtils;

import bingo.sso.api.SingleSignOnContextHolder;

/**
 *
 * @author marco
 *
 */
public class WebUtils {

	public static final String CONFIG_UI_THEME_NAME  = "runtime.theme";
	public static final String CONFIG_UI_VIEW_PATH   = "runtime.viewpath";

	public static final String getContextPath(HttpServletRequest request){
		String path = request.getContextPath();
		if("/".equals(path)){
			return "";
		}
		return path;
	}

	public static final String getTheme(ServletContext context){
		if(SingleSignOnContextHolder.getSingleSignOnContext()==null){
			return WebApplicationContextUtils.getWebApplicationContext(context).getEnvironment().getProperty(CONFIG_UI_THEME_NAME);
		}
		return SingleSignOnContextHolder.getSingleSignOnContext().getConfig().getThemeManager().getCurrentTheme();
	}

	public static final String getViewPath(ServletContext context){
		if(SingleSignOnContextHolder.getSingleSignOnContext()==null){
			return WebApplicationContextUtils.getWebApplicationContext(context).getEnvironment().getProperty(CONFIG_UI_VIEW_PATH);
		}
		return SingleSignOnContextHolder.getSingleSignOnContext().getConfig().getThemeManager().buildPath("/{theme}");
	}
}
