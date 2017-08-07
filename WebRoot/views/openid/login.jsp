<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/common/header.jsp"%>
<%
	String  errors  = (String)request.getAttribute("login.errors");
	ISingleSignOnContext context = (ISingleSignOnContext)request.getAttribute("singleSignOnContext");
	ClientHostType clientHostType = context.getClientHost().getClientHostType();
	boolean isLoginByOpenId = false;
	boolean isLoginByLocal = false;
	if (ClientHostType.None.equals(clientHostType)){
		isLoginByLocal = true;
		request.setAttribute("isLoginByLocal",true);
	}else if (ClientHostType.Web.equals(clientHostType)){
		isLoginByOpenId = true;
		request.setAttribute("isLoginByOpenId",true);
	}
	String  clientHostName  = (String)request.getAttribute("login.host.name");
	request.setAttribute("clientHostName",clientHostName);
	
	boolean isError = null != errors && !"".equals(errors.trim());
	
	//验证码
	String pageKeyValue = "login.default_" + System.currentTimeMillis();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="bingo.sso.api.client.ClientHostType"%>
<%@page import="bingo.sso.api.ISingleSignOnContext"%><html>
<head>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="/common/meta.jsp"%>
<title>欢迎登录品高OpenID</title>
<link href="${contextPath}/themes/default/bootstrap.css" type="text/css" rel="stylesheet" />
<link type="text/css" rel="stylesheet" href="${viewPath}/js/tipsy.css" />
<link href="${viewPath}/style.css" rel="stylesheet" type="text/css">

<script src="${contextPath}/scripts/jquery-1.7.1.js" type="text/javascript"></script>
<script src="${viewPath}/js/application.js" type="text/javascript"></script>
<script src="${viewPath}/js/jquery.tipsy.js" type="text/javascript"></script>
<script src="${viewPath}/js/jquery.validationConfig.js" type="text/javascript"></script>
<script src="${viewPath}/js/jquery.validation.js" type="text/javascript"></script>
<script src="${viewPath}/js/jquery.form.js" type="text/javascript"></script>
<script src="${viewPath}/ZeroClipboard.js" type="text/javascript"></script>

<script type="text/javascript">
//加载验证码
function displayRandomCode(username){
	jQuery.ajax(
			{url: Global.contextPath + "/servlet/validatecodeneedcheck" + "?username=" + username,
		    type: 'GET',
		    timeout: 1000,
		    error: function(){
		    	$("#random_code_div").hide();
		    },
		    success: function(ret){
		    	var retJson = $.parseJSON(ret);		    	
		        if(retJson.needcode){
		        	$("#random_code_div").show();
		        }else{
		        	$("#random_code_div").hide();
		        }
		    }
			});
}

$(document).ready(
	function(){

		//登录成功后现实的复制按钮
		<c:if test="${!empty user}">
			console.log("1");
			ZeroClipboard.setMoviePath("${viewPath}/ZeroClipboard.swf");
			var clip = new ZeroClipboard.Client(); // 新建一个对象
			clip.setHandCursor( true ); // 设置鼠标为手型
			// 注册一个 button，参数为 id。点击这个 button 就会复制。
			//这个 button 不一定要求是一个 input 按钮，也可以是其他 DOM 元素。
			clip.glue("copyBtn"); // 和上一句位置不可调换
	
			clip.addEventListener("mouseDown", function(client) {
			    var my = $("#myOpenId").val()
			    client.setText(my); 
			});
			
			//复制成功：
			clip.addEventListener( "complete", function(){
				$("#copyBtn").html("完成").removeClass("btn-warning");
			});
		</c:if>

		//账号输入框的效果
		$("input#userName").addClass("colorGray").focus(function(){
			if($(this).val() == this.defaultValue){
				$(this).val("").removeClass("colorGray");
			}
		}).blur(function(){
			if($(this).val() == ""){
				$(this).val(this.defaultValue).addClass("colorGray");
			}
			//加载验证码
			displayRandomCode(this.value);
		});

		//密码输入框的效果
		var pswText;
		$("input#passwordText").addClass("colorGray").focus(function(){
			if($(this).val() == this.defaultValue){
				pswText = $(this).detach();
				$("input#password").css("display", "inline-block").focus();
			}
		});
		$("input#password").blur(function(){
			if($(this).val() == ""){
				$(this).css("display", "none").before(pswText);
			}
		});

		//验证码输入框的效果
		$("input#random_code").addClass("colorGray").focus(function(){
			if($(this).val() == this.defaultValue){
				$(this).val("").removeClass("colorGray");
			}
		}).blur(function(){
			if($(this).val() == ""){
				$(this).val(this.defaultValue).addClass("colorGray");
			}
		});
	}
);
</script>
</head>
<body style="overflow: hidden;">
	<div class="headerArea">
		<div class="row">
			<div class="span3 offset1">
				<img src="${viewPath}/images/bingo.png" style="height:40px;"/>
				<img src="${viewPath}/images/openid.png" style="height:70px;"/>
			</div>
			<div class="span2 offset10" style="margin-top: 25px">
				<c:choose>
					<c:when test="${empty user}">
						<span>匿名用户，请登录</span>
					</c:when>
					<c:otherwise>
						<span>欢迎您：${user}</span>
						|
						<span>
						<a href="${contextPath}/signon/logout">注销</a>
						</span>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	<div id="containerArea">
		<div class="row-fluid">
	    <div class="span1">&nbsp;</div>
	    <div class="span5">
	    	<div id="contentDiv">
	    		<c:choose>
	    			<c:when test="${isLoginByLocal==true}">
			    		<h2 class="redText">欢迎使用品高开放身份验证服务</h2>
			    		<hr/>
			    		<div class="introList">
					      
					        <div class="listItem">
					        	<div class="itemBody" >
						        	<div class="showImage">
						        		<img alt="" src="${viewPath}/images/o1.jpg">
						        	</div>
						        	<div class="showText">
						        		<p>
						        			<h3>1.获取OpenID</h3>
						        		</p>
							           	<p>
							           		OpenID 是一个以用户为中心的数字身份识别框架，
							           		它具有开放、分散、自由等特性。
							           		假如你是第一次登录，还不知道自己的OpenID账号是多少。那么
							           		<strong>请在右侧登陆框输入你的用户名和密码</strong>，获取属于你的OpenID！
							           	</p>
							    	</div>
					        	</div>
					        </div>
					        
					        <div class="listItem">
					        	<div class="itemBody" >
						        	<div class="showImage">
						        		<img alt="" src="${viewPath}/images/o2.jpg">
						        	</div>
						        	<div class="showText">
						        		<p>
						        			<h3>2.使用OpenID</h3>
						        		</p>
							           	<p>
							           		目前支持OpenID的应用与网站越来越多，以下是支持OpenID账号登陆的一些网站，
							           		赶快去体验一下吧！
							           		点击这里查看<a href="http://openid.net/get-an-openid/start-using-your-openid/" target="_blank">《如何使用OpenID》</a>。
							           	</p>
						        		<div >
							          		<a href="http://10.201.76.233:88/blog/" class="btn" target="_blank">
							          			平台架构部技术博客
							          		</a>
							          		<a href="http://www.springnote.com/" class="btn" target="_blank">
							          			SpringNote——在线笔记本
							          		</a>
						        		</div>
							    	</div>
					        	</div>
					        </div>
					        
					        <div class="listItem">
					        	<div class="itemBody" >
						        	<div class="showImage">
						        		<img alt="" src="${viewPath}/images/o3.jpg">
						        	</div>
						        	<div class="showText">
						        		<p>
						        			<h3>3.了解OpenID</h3>
						        		</p>
							           	<p>
							           		无论你是普通用户还是开发者，只要你对OpenID有兴趣，请到我们的专题介绍网站了解更多。
							           	</p>
						        		<div >
							        		<a class="btn" href="http://openid.net/" target="_blank">
							        			了解更多
							          		</a>
						        		</div>
							    	</div>
					        	</div>
					        </div>
						</div>
	    			</c:when>
	    			<c:otherwise>
			    		<h2 class="redText">
			    			<c:choose>
			    				<c:when test="${isLoginByOpenId == true}">
			    					您从${clientHostName}跳转过来<br/>
			    					请在右侧登录以验证您的身份
			    				</c:when>
			    				<c:otherwise>
			    					${user}，欢迎回来。
			    				</c:otherwise>
			    			</c:choose>
			    		</h2>
			    		<hr/>
			    		<div class="introList">
					      
					        <div class="listItem">
					        	<div class="itemBody" >
						        	<div class="showImage">
						        		<img alt="" src="${viewPath}/images/o2.jpg">
						        	</div>
						        	<div class="showText">
						        		<p>
						        			<h3>支持OpenID的应用</h3>
						        		</p>
							           	<p>
							           		目前支持OpenID的应用与网站越来越多，以下是支持OpenID账号登陆的一些网站，
							           		赶快去体验一下吧！
							           		点击这里查看<a href="http://openid.net/get-an-openid/start-using-your-openid/" target="_blank">《如何使用OpenID》</a>。
							           	</p>
							           	<hr/>
						        		<div id="appList">
						        			<div class="siteItem">
							        			<img alt="" src="${viewPath}/images/w1.jpg" class="btn-large">
								          		<a href="http://10.201.76.233:88/blog/" class="btn btn-large" target="_blank">
								          			平台架构部技术博客
								          		</a>
						        			</div>
						        			<div class="siteItem">
							        			<img alt="" src="${viewPath}/images/s3.jpg" class="btn-large">
							          		<a href="http://www.springnote.com/" class="btn btn-large" target="_blank">
							          			SpringNote——在线笔记本
							          		</a>
						        			</div>
						        		</div>
							    	</div>
					        	</div>
					        </div>
					        <hr/>
					        <div class="listItem">
					        	<div class="itemBody" >
						        	<div class="showImage">
						        		<img alt="" src="${viewPath}/images/o3.jpg">
						        	</div>
						        	<div class="showText">
						        		<p>
						        			<h3>了解OpenID</h3>
						        		</p>
							           	<p>
							           		无论你是普通用户还是开发者，只要你对OpenID有兴趣，请到我们的专题介绍网站了解更多。
							           	</p>
						        		<div >
							        		<a class="btn" href="http://openid.net/" target="_blank">
							        			了解更多
							          		</a>
						        		</div>
							    	</div>
					        	</div>
					        </div>
						</div>
	    			</c:otherwise>
	    		</c:choose>
	    	</div>
		</div>
	    <div class="span1">&nbsp;</div>
	    <div class="span4">
	    	<c:choose>
	    		<c:when test="${empty user}">
		    		<form id="loginForm" class="well" style="margin-top:35px;" data-widget="validator" action="${loginAction}" method="post">    			
				        <fieldset>
				          <input type="hidden" name="credential_type" value="password"/>
				          <legend>登录</legend>
				          <div class="control-group">
				            <div class="controls">
				              <input class="input-xlarge focused" id="userName" name="username" value="请输入公司邮箱账号(不带@后缀)" type="text" data-validator="required">
				            </div>
				            
				          </div>
				          <div class="control-group">
				            <div class="controls">
				              <input class="input-xlarge focused" id="password" name="password" type="password" data-validator="required" style="display: none;">
				              <input class="input-xlarge focused" id="passwordText" type="text" value="请输入密码">
				            </div>
				          </div>
				          <div class="control-group" id="random_code_div" style="display:none">
					          <input id="random_code" name="random_code" type="text" value="请输入验证码">
					          <input style="display:none" name="pageKey" style="width:100px;" value="<%=pageKeyValue %>"/>
					          <img src="${contextPath}/servlet/validatecode?pageKey=<%=pageKeyValue %>" style="cursor:pointer" onclick="refresh(this);" align="middle" alt="看不清楚，点击获得新图片"/>
					      </div>
					      <% if(isError){ %>
				          <div class="control-group error ">
				          	<span class="help-inline">		          		
								  <div class="messages"><p class="error"><%=errors %></p></div>						
				          	</span>
				          </div>
				          <% } %>
				          <button type="submit" class="btn btn-primary">登录</button>
				          <div class="control-group">
				          	
				          </div>
				          <div class="otherLogin">
				          	<span>使用其他方式登录：</span>
				          	<div class="loginList">
				          		<div class="loginItem">
				          			<a href="${loginAction}&authType=ntlm">
				          				<img alt="" src="${viewPath}/images/W1.png" style="width: 14px; height: 14px"/>Windows集成验证
				          			</a>
				          		</div>
				          	</div>
				          </div>
				        </fieldset>
				      </form>
	    		</c:when>
	    		<c:otherwise>
		    		<form id="loginForm" class="well" style="margin-top:35px; width: 280px" data-widget="validator" action="${loginAction}" method="post">    			
				        <fieldset>
				          	<legend>openID登录成功！</legend>
			    			<div id="profileDiv">
			    				<div id="profileImage">
			    					<img alt="" src="${viewPath}/images/u1.jpg">
			    				</div>
			    				<div class="profileText">
			    					<span class="grayTitle">
			    						您是
			    					</span>
			    					|
			    					<span class="userInfo">
			    						${user}
			    					</span>
			    				</div>
			    				<hr/>
			    				<div class="profileText">
			    					<span class="grayTitle">
			    						您的品高OpenID
			    					</span>
			    					<div class="userID">
			    						<div class="inputID">
			    							<input type="text" id="myOpenId" value="${url}" readonly="readonly">
			    						</div>
			    						<div class="buttonCopy">
			    							<a class="btn btn-warning" id="copyBtn" href="#">复制</a>
			    						</div>
			    					</div>
			    				</div>
			    			</div>
				        </fieldset>
				      </form>
	    		</c:otherwise>
	    	</c:choose>	    	
	    </div>
	    <div class="span1">&nbsp;</div>
	  </div>
	</div>
	<div class="footerArea">
		@Bingosoft.net
	</div>
</body>
</html>