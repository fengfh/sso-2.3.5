<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%
	request.setAttribute("result", request.getAttribute("login.saml.result"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>正在处理...</title>
</head>
<body>
	<form method="post" name="hiddenform" action="${result.wtrealm}">
		<input type="hidden" name="wa" value="${result.wa}" />
		<input	type="hidden" name="wresult" value="${fn:escapeXml(result.wresult)}"/>
		<input	type="hidden" name="wctx" value="${result.wctx}" />
		<noscript>
			<p>已禁用脚本。请单击“提交”继续。</p>
			<input type="submit" value="提交" />
		</noscript>
	</form>
	<script language="javascript">
		window.setTimeout('document.forms[0].submit()', 0);
	</script>
</body>
</html>