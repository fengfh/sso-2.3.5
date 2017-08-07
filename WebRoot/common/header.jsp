<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %><%
	String contextPath    = bingo.sso.server.web.WebUtils.getContextPath(request);
	String themeName      = bingo.sso.server.web.WebUtils.getTheme(pageContext.getServletContext());
	String themePath      = contextPath + "/themes/" + themeName;
	String serverViewPath = bingo.sso.server.web.WebUtils.getViewPath(pageContext.getServletContext());
	String viewPath       = contextPath + serverViewPath;
	
	request.setAttribute("contextPath",   contextPath);
	request.setAttribute("themePath",     themePath);
	request.setAttribute("viewPath",      viewPath);
	request.setAttribute("serverViewPath",serverViewPath);
	request.setAttribute("serverPath",request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+contextPath);
%>