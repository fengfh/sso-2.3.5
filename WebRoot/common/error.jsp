<%@page errorPage="true" pageEncoding="UTF-8"%>
<%@include file="/common/header.jsp"%>
<%
	Integer   status     = (Integer)request.getAttribute("javax.servlet.error.status_code");
	String    message    = (String)request.getAttribute("javax.servlet.error.message");
	Throwable exception  = (Throwable)request.getAttribute("javax.servlet.error.exception");
	String    requestUri = (String)request.getAttribute("javax.servlet.error.request_uri");
	
	if(null == requestUri){
		requestUri = request.getRequestURI();
	}
	if(null == message && null != exception){
		message = exception.getMessage();
	}
	
	request.setAttribute("error_status",    status);
	request.setAttribute("error_message",   message);
	request.setAttribute("error_exception", exception);
	request.setAttribute("error_request_uri",requestUri);
	
	String errorPage = serverViewPath + "/error/" + status + ".jsp";
%>
<jsp:include page="<%=errorPage%>"></jsp:include>