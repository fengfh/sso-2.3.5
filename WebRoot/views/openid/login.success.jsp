<%@page import="bingo.sso.server.web.SecurityContextUtil"%><%
String successUrl = "/views/openid/login.jsp";
request.setAttribute("user", SecurityContextUtil.getAccount(request,response));
request.setAttribute("url", SecurityContextUtil.getOpenIdIdentifier(request,response));
request.getRequestDispatcher(successUrl).forward(request,response);
%>