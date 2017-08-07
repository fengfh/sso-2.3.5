<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@include file="/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>注销成功</title>
	<%@include file="/common/meta.jsp"%>
	<link href="${viewPath}/style.css" media="screen" rel="stylesheet" type="text/css">
	<style>
	* {
		margin: 0;
		padding: 0;
	}
	
	html {
		background-color: #717a80;
		font: 13px/160% Helvetica, Arial, Verdana, sans-serif;
		color: #082f42;
		height: 100%;
	}
	
	#login_wrapper {
		width: 470px;
		position: absolute;
		left: 50%;
		top: 50%;
		margin-left: -265px;
		margin-top: -160px;
	}
	
	.b-ie #login_wrapper,
	.b-op #login_wrapper {
		border: 1px solid #25292b;
	}
	</style>
</head>
<body>
<div id="login_wrapper" class="dialog">
<div id="signin">
  <div class="messages"><p class="info">注销成功</p></div>
  <div id="customlogo">
       <img src="${viewPath}/images/bg_logo.gif">
  </div>
 
  <div id="logins">
	<p><img src="${viewPath}/images/ok_small.gif" style="padding-right:2px"/>您已成功从系统中注销。</p>
	<p style="margin-left:18px;margin-top:20px"></p>
	<ul style="margin-left:18px;">
		<li>
			为了保障系统账号的安全性，如果您不再使用系统，请<a href="javascript:" onclick="window.close();"><span>关闭浏览器</span></a>。
       </li>
	   <li style="margin-top:10px;">
			<i>提示：如果上面链接不能正常关闭，请手工关闭当前窗口。</i>
       </li>       
    </ul>
  </div>
  <div class="dlg_footer">
    &nbsp;
  </div>
</div>
</div>
</body>
</html>