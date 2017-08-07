<%@page import="bingo.sso.api.login.ILoginContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
ILoginContext loginContext = (ILoginContext)request.getAttribute("loginContext");
String prevLoginAccount = loginContext.getPreviousLoginAccount();
String curLoginAccount = loginContext.getPrincipal().getId();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>已经登录用户(<%=prevLoginAccount %>)，是否覆盖登录(<%=curLoginAccount %>)？</h1>
<a href="${loginAction}&isGoOnLogin=true">继续</a>
<a href="${loginAction}&isGoOnLogin=false">取消</a>
</body>
</html>