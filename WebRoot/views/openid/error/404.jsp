<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@include file="/common/header.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>页面不存在</title>
	<%@include file="/common/meta.jsp"%>
	<link href="${viewPath}/error/style.css" media="screen" rel="stylesheet" type="text/css">
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
  <div class="messages"><p class="error">找不到您要访问的页面！</p></div>
  <div id="customlogo">
      <img src="${viewPath}/images/bg_logo.gif">
  </div>
  <div id="logins">
  	<p>&nbsp;</p>
	<p>您也许输入了一个过期的链接或者误打地址，有些网址区分大小写字母。</p>
	<p>&nbsp;</p>
	<p>
       <a href="javascript:" onclick="history.back(-1);">
         <span>返回上页</span>
       </a>
    </p>
  </div>
  <div class="dlg_footer">
    &nbsp;
  </div>
</div>
</div>
</body>
</html>