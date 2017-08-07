<%@page import="java.util.ArrayList"%>
<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@include file="/common/header.jsp"%>
<%
	String returnTo  = (String)request.getAttribute("returnUrl");
	if(null == returnTo || "".equals(returnTo.trim())){
		returnTo = (String)request.getParameter("returnUrl");
		if(null == returnTo || "".equals(returnTo.trim())){
			returnTo = viewPath + "/logout.success.jsp";
		}	
	}
	
	//construts logout scripts
	StringBuilder scripts = new StringBuilder();
	List<String> logoutUrls = (List<String>)request.getAttribute("logoutUrls");
	if(logoutUrls == null){
		String tempLogoutUrls = (String)request.getParameter("logoutUrls");
		if(tempLogoutUrls != null){
			String[] urls = tempLogoutUrls.split(",");
			logoutUrls = new ArrayList<String>();
			for(String url : urls){
				logoutUrls.add(url);
			}
		}
	}
	if(null != logoutUrls){
		for(String logoutUrl : logoutUrls){
			scripts.append("<script type=\"text/javascript\" src=\"")
			       .append(logoutUrl)
			       .append("\"></script>")
			       .append("\n");
		}
	}
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title><spring:message code="logout.view.title"/></title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
</head>
<body>
<img id="loading" src="${viewPath}/images/loading.gif"/>

<%=scripts.toString()%>

<script type="text/javascript">
	window.location.href = '<%=returnTo %>';
</script>