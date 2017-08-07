/**
 * This file created at 2010-8-23.
 *
 * Copyright (c) 2002-2010 Bingosoft, Inc. All rights reserved.
 */
package bingo.sso.server.web.servlets;

import java.io.IOException;

import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * 把请求交给一个定义在Spring中的Serlvet Bean执行的代理Servlet类。
 *
 * @author fenghm (fenghm@bingosoft.net)
 * @since 1.0.0
 */
public class ServletToBeanProxy extends HttpServlet {
	private static final Logger log = LoggerFactory.getLogger(ServletToBeanProxy.class);

    private static final long serialVersionUID = 7865137812375771662L;

    protected Servlet proxy;

	@Override
    public void init(ServletConfig config) throws ServletException {
		String proxyBeanName = config.getInitParameter("proxy-bean");
		if(null == proxyBeanName || "".equals(proxyBeanName = proxyBeanName.trim())){
			throw new ServletException("proxy-bean init parameter required");
		}

		ApplicationContext spring = 
			WebApplicationContextUtils.getRequiredWebApplicationContext(config.getServletContext());
		
		proxy = (Servlet)spring.getBean(proxyBeanName);
		
		proxy.init(config);
		
		/*//inject spring properties to SingleSignOnConfig
		PropertyConfigurer springProperties = spring.getBean(PropertyConfigurer.class);
		if(null == springProperties){
			throw new SingleSignOnException(PropertyConfigurer.class.getName() + " not found in spring context");
		}
		
		ISingleSignOnConfig ssoConfig = ConfigUtils.getConfig(config.getServletContext());
		if(null == ssoConfig){
			throw new SingleSignOnException("single-sign-on config not found in servlet context");
		}
		
		Properties props = springProperties.getProperties();
		for(Object key : props.keySet()){
			String name  = key.toString();
			String value = props.getProperty(name);
			
			ssoConfig.setParameter(name, value);
			
			if(log.isTraceEnabled()){
				log.trace(" config sso prop: {} = {}",name,value);
			}
		}*/
    }

	@Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		proxy.service(req, resp);
    }

	@Override
    public void destroy() {
		proxy.destroy();
    }
}
