<%@page import="bingo.sso.core.utils.URLEncoderUtils"%><%@page import="bingo.sso.server.web.SecurityContextUtil"%><%@page import="bingo.sso.core.utils.WebUtils"%><%
String serverViewPath = bingo.sso.server.web.WebUtils.getViewPath(pageContext.getServletContext());
boolean isLogined = SecurityContextUtil.isLogined(request,response);
if(isLogined){
	//String successUrl = "/modules/specsecret/spec_secret_manage.jsp";
	String successUrl = serverViewPath + "/login.success.jsp";
	request.getRequestDispatcher(successUrl).forward(request,response);
}else{
	String loginUrl = WebUtils.getServerBaseUrl(request) + "/signon/login?returnUrl=" + URLEncoderUtils.encode(WebUtils.getServerBaseUrl(request) + "/index.jsp");
	response.sendRedirect(loginUrl);
}
%>