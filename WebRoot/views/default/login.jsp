<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@include file="/common/header.jsp"%>
<%
	String  errors  = (String)request.getAttribute("login.errors");
	boolean isError = null != errors && !"".equals(errors.trim());
	//验证码
	String pageKeyValue = "login.default_" + System.currentTimeMillis();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title><spring:message code="login.form.title"/></title>
	<%@include file="/common/meta.jsp"%>
	<link href="${viewPath}/style.css" media="screen" rel="stylesheet" type="text/css">
	<script src="${viewPath}/login.js" type="text/javascript"></script>
	<script src="${viewPath}/qrcode.js" type="text/javascript"></script>

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
  <% if(isError){ %>
  <div class="messages"><p class="error"><%=errors %></p></div>
  <% } %>
  <div id="customlogo">
      <img src="${viewPath}/images/bg_logo.gif">
  </div>
  <div id="logins">
	<%-- 改造登录页面需要注意以下内容必须定义：
	     1. <form action="${loginAction}">
	     2. <input type="hidden" name="LoginForm" value="yes"/>
	     3. <input name="username"/>
	     3. <input name="password"/>
	 --%>
    <form action="${loginAction}" method="post">
    <input type="hidden" name="credential_type" value="password"/>
      <div class="group">
        <fieldset>
          <label for="username"><spring:message code="login.form.username"/>:</label>
          <input id="username" name="username" tabindex="1" type="text" value="">
        </fieldset>
        <fieldset>
          <label for="password"><spring:message code="login.form.password"/>:</label>
          <input id="password" name="password" tabindex="2" type="password" />
          <input id="domain" name="domain" value="nheducloud.net" type="hidden" />
        </fieldset>
        <fieldset style="display:none" id="randomCodeFieldset">
          <label for="random_code"><spring:message code="login.form.randomcode"/>:</label>
          <input id="random_code" name="random_code" tabindex="3" type="text">
          <input style="display:none" name="pageKey" style="width:100px;" value="<%=pageKeyValue %>"/>
          <img src="${contextPath}/servlet/validatecode?pageKey=<%=pageKeyValue %>"  onclick="refresh(this);" align="middle" alt="看不清楚，点击获得新图片"/>
        </fieldset>
      </div>
      <p class="buttons">
        <a class="mmbutton" id="sign_in_button_standard" onclick="doSubmit();">
          <span>登录</span>
        </a>
        <a class="mmbutton" id="sign_in_button_qrcode">
          <span>二维码登录</span>
        </a>
      </p>
    </form>
    <div class="qrcode_wrapper">
	  	<div class="qrcode_scan_container">
	  		<img class="qrcode_img" alt="在Link中扫描登录" width="200" height="200" />
	  	</div>
	  	<div class="qrcode_confirm_container">
	  		<!-- <img class="qrcode_user_img" width="200" height="200" /> -->
	  		<span class="qrcode_confirm_tip">
	  			已在Link上扫描成功，请在Link上确认
	  		</span>
	  		<a class="qrcode_cancel" id="qrcodeCancel">
	          <span>返 回</span>
	        </a>
	  	</div>
	  	<div class="qrcode_error">
	  	</div>
	  </div>
  </div>

  <div class="dlg_footer">
    &nbsp;
  </div>
</div>
</div>
<!-- 两个sso单点登录服务器互联
<script type="text/javascript">
	loginFromTrustSSO("https://www.bingolink.biz/sso");
</script>
-->
<script type="text/javascript">
	var qrcode=null;
	$("#sign_in_button_qrcode").click(function(){
		if(qrcode==null){
			qrcode=$(".qrcode_wrapper").qrcodeLogin();
		}
		$(".qrcode_wrapper").show();
	});
</script>
</body>
</html>